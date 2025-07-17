// ignore_for_file: unused_field

import 'package:strawti_utils/strawti_utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/course_progress_model.dart';
import '../models/student_stats_model.dart';

class StudentDashboardRepository extends StrautilsTryThis {
  late final SupabaseQueryBuilder _enrollmentsTable;
  late final SupabaseQueryBuilder _moduleProgressTable;
  late final SupabaseQueryBuilder _commentsTable;
  late final SupabaseQueryBuilder _modulesTable;
  late final SupabaseQueryBuilder _lessonProgressTable;
  late final SupabaseQueryBuilder _quizResponsesTable;
  late final SupabaseQueryBuilder _lastAccessTable;
  late final SupabaseQueryBuilder _accessTrackingTable;
  late final SupabaseClient _client;

  StudentDashboardRepository() {
    _client = Supabase.instance.client;
    _enrollmentsTable = _client.from('enrollments');
    _moduleProgressTable = _client.from('content_module_progress');
    _commentsTable = _client.from('content_comments');
    _modulesTable = _client.from('content_modules');
    _lessonProgressTable = _client.from('lesson_progress');
    _quizResponsesTable = _client.from('quiz_responses');
    _lastAccessTable = _client.from('last_access');
    _accessTrackingTable = _client.from('access_tracking');
  }

  // Obter estatísticas completas usando função SQL otimizada
  FStrautilsResponse<StudentStatsModel> getStudentStats(int userId) {
    return tryThis(() async {
      // Usar função SQL otimizada para estatísticas
      final statsResponse = await _client
          .rpc('get_user_progress_stats', params: {'p_user_id': userId});

      if (statsResponse.isEmpty) {
        return StrautilsResponse.success(StudentStatsModel.empty());
      }

      final stats = statsResponse.first;

      // Buscar atividades recentes usando view otimizada
      final recentActivitiesResponse = await _client
          .from('recent_activities')
          .select('*')
          .eq('user_id', userId)
          .order('activity_date', ascending: false)
          .limit(5);

      final recentActivities = (recentActivitiesResponse as List).map((activity) {
        return {
          'activityType': activity['activity_type'],
          'activityTitle': activity['activity_title'],
          'courseTitle': activity['course_title'],
          'activityDate': activity['activity_date'],
          'activityDescription': activity['activity_description'],
        };
      }).toList();

      // Buscar progresso de aulas para métricas mais detalhadas
      final lessonStatsResponse = await _lessonProgressTable
          .select('is_completed, time_spent_seconds')
          .eq('user_id', userId);

      final lessonStats = lessonStatsResponse as List;
      final totalLessons = lessonStats.length;
      final completedLessons = lessonStats.where((l) => l['is_completed'] == true).length;
      final totalTimeSpent = lessonStats.fold<int>(0, (sum, lesson) => 
          sum + (lesson['time_spent_seconds'] as int? ?? 0));

      // Buscar scores de quiz
      final quizScoresResponse = await _quizResponsesTable
          .select('''
            is_correct,
            questionnaire_questions!inner(
              id,
              quizId,
              questionnaire_quizzes!inner(title, courseId)
            )
          ''')
          .eq('user_id', userId);

      final quizResponses = quizScoresResponse as List;
      final totalQuizResponses = quizResponses.length;
      final correctAnswers = quizResponses.where((q) => q['is_correct'] == true).length;
      final quizAccuracy = totalQuizResponses > 0 ? (correctAnswers / totalQuizResponses * 100).round() : 0;

      final studentStats = StudentStatsModel(
        totalCourses: stats['total_enrolled_courses'] ?? 0,
        completedModules: stats['completed_modules'] ?? 0,
        totalModules: stats['total_modules'] ?? 0,
        progressPercentage: stats['total_modules'] > 0 
            ? ((stats['completed_modules'] / stats['total_modules']) * 100).round()
            : 0,
        totalComments: await _getTotalComments(userId),
        recentActivities: recentActivities,
        // Novas métricas
        completedLessons: completedLessons,
        totalLessons: totalLessons,
        lessonProgressPercentage: totalLessons > 0 ? (completedLessons / totalLessons * 100).round() : 0,
        totalTimeSpentSeconds: totalTimeSpent,
        quizAttempts: stats['quiz_attempts'] ?? 0,
        quizPasses: stats['quiz_passes'] ?? 0,
        quizAccuracy: quizAccuracy,
        lastActivity: stats['last_activity'] != null 
            ? DateTime.parse(stats['last_activity'])
            : null,
      );

      return StrautilsResponse.success(studentStats);
    });
  }

  // Obter progresso detalhado por curso usando view otimizada
  FStrautilsResponse<List<CourseProgressModel>> getCourseProgress(int userId) {
    return tryThis(() async {
      // Usar view otimizada para progresso por curso
      final progressResponse = await _client
          .from('course_progress_detailed')
          .select('*')
          .eq('user_id', userId)
          .order('last_accessed_at', ascending: false);

      final progressList = progressResponse as List;
      final List<CourseProgressModel> coursesProgress = [];

      for (final progress in progressList) {
        // Buscar informações adicionais da turma
        final classResponse = await _enrollmentsTable
            .select('''
              classes!inner(
                id,
                title,
                thumbnailUrl
              )
            ''')
            .eq('userId', userId)
            .eq('classes.courseId', progress['course_id'])
            .single();

        final classData = classResponse['classes'];

        // Buscar próximo módulo/aula
        final nextLessonResponse = await _client
            .from('content_lessons')
            .select('''
              id,
              title,
              orderIndex,
              content_modules!inner(
                id,
                title,
                orderIndex,
                courseId
              )
            ''')
            .eq('content_modules.courseId', progress['course_id'])
            .order('content_modules.orderIndex', ascending: true)
            .order('orderIndex', ascending: true)
            .limit(1);

        final nextLessonData = nextLessonResponse.isNotEmpty 
            ? nextLessonResponse.first
            : null;

        // Buscar tempo total gasto no curso
        final timeResponse = await _lessonProgressTable
            .select('''
              time_spent_seconds,
              content_lessons!inner(
                content_modules!inner(courseId)
              )
            ''')
            .eq('user_id', userId)
            .eq('content_lessons.content_modules.courseId', progress['course_id']);

        final timeData = timeResponse as List;
        final totalTimeSpent = timeData.fold<int>(0, (sum, item) => 
            sum + (item['time_spent_seconds'] as int? ?? 0));

        final courseProgress = CourseProgressModel(
          courseId: progress['course_id'],
          courseTitle: progress['course_title'],
          courseThumbnail: progress['course_description'],
          classTitle: classData['title'],
          totalModules: progress['total_modules'] ?? 0,
          completedModules: progress['completed_modules'] ?? 0,
          progressPercentage: progress['module_progress_percentage']?.round() ?? 0,
          nextModuleIndex: nextLessonData?['content_modules']['orderIndex'],
          nextModuleTitle: nextLessonData?['content_modules']['title'],
          lastActivity: progress['last_accessed_at'] != null 
              ? DateTime.parse(progress['last_accessed_at'])
              : null,
          // Novas métricas
          totalLessons: progress['total_lessons'] ?? 0,
          completedLessons: progress['completed_lessons'] ?? 0,
          lessonProgressPercentage: progress['lesson_progress_percentage']?.round() ?? 0,
          totalTimeSpentSeconds: totalTimeSpent,
          courseStatus: progress['course_status'] ?? 'not_started',
          nextLessonTitle: nextLessonData?['title'],
        );

        coursesProgress.add(courseProgress);
      }

      return StrautilsResponse.success(coursesProgress);
    });
  }

  // Obter comentários recentes do usuário
  FStrautilsResponse<List<Map<String, dynamic>>> getRecentComments(int userId) {
    return tryThis(() async {
      final response = await _commentsTable
          .select('''
            id,
            text,
            createdAt,
            content_lessons!inner(
              id,
              title,
              content_modules!inner(
                title,
                content_courses!inner(title)
              )
            )
          ''')
          .eq('userId', userId)
          .order('createdAt', ascending: false)
          .limit(10);

      final comments = (response as List).map((comment) {
        final lesson = comment['content_lessons'];
        final module = lesson['content_modules'];
        final course = module['content_courses'];

        return {
          'id': comment['id'],
          'text': comment['text'],
          'createdAt': comment['createdAt'],
          'lessonTitle': lesson['title'],
          'moduleTitle': module['title'],
          'courseTitle': course['title'],
        };
      }).toList();

      return StrautilsResponse.success(comments);
    });
  }

  // Obter questionários disponíveis dos cursos matriculados
  FStrautilsResponse<List<Map<String, dynamic>>> getAvailableQuizzes(int userId) {
    return tryThis(() async {
      // Primeiro, buscar IDs dos cursos matriculados
      final enrollmentsResponse = await _enrollmentsTable
          .select('''
            classes!inner(
              courseId,
              content_courses!inner(id, title)
            )
          ''')
          .eq('userId', userId);

      final enrollments = enrollmentsResponse as List;
      final courseIds = enrollments
          .map((e) => e['classes']['courseId'] as int)
          .toSet()
          .toList();

      if (courseIds.isEmpty) {
        return StrautilsResponse.success(<Map<String, dynamic>>[]);
      }

      // Buscar questionários dos cursos com status de conclusão
      final quizzesResponse = await _client
          .from('questionnaire_quizzes')
          .select('''
            id,
            title,
            type,
            courseId,
            createdAt,
            content_courses!inner(title)
          ''')
          .inFilter('courseId', courseIds)
          .order('createdAt', ascending: false);

      final quizzes = (quizzesResponse as List);
      final List<Map<String, dynamic>> quizzesWithStatus = [];

      for (final quiz in quizzes) {
        // Verificar se o usuário já fez este quiz
        final userScore = await _calculateQuizScore(userId, quiz['id']);
        
        quizzesWithStatus.add({
          'id': quiz['id'],
          'title': quiz['title'],
          'type': quiz['type'],
          'courseId': quiz['courseId'],
          'courseTitle': quiz['content_courses']['title'],
          'createdAt': quiz['createdAt'],
          'isCompleted': userScore != null,
          'score': userScore?['score_percentage'],
          'isPassing': userScore?['is_passing'] ?? false,
        });
      }

      return StrautilsResponse.success(quizzesWithStatus);
    });
  }

  // Registrar acesso a aula
  FStrautilsResponse<void> registerLessonAccess(int userId, int lessonId, 
      {String? deviceType, String? ipAddress, String? userAgent}) {
    return tryThis(() async {
      // Registrar sessão de acesso
      await _accessTrackingTable.insert({
        'user_id': userId,
        'lesson_id': lessonId,
        'session_start': DateTime.now().toIso8601String(),
        'device_type': deviceType ?? 'web',
        'ip_address': ipAddress,
        'user_agent': userAgent,
      });

      // Atualizar último acesso usando função SQL
      await _client.rpc('upsert_last_access', params: {
        'p_user_id': userId,
        'p_lesson_id': lessonId,
      });

      return StrautilsResponse.success(null);
    });
  }

  // Finalizar sessão de acesso
  FStrautilsResponse<void> endLessonSession(int userId, int lessonId, 
      DateTime sessionStart, {int? completionPercentage}) {
    return tryThis(() async {
      // Finalizar sessão usando função SQL
      await _client.rpc('end_access_session', params: {
        'p_user_id': userId,
        'p_lesson_id': lessonId,
        'p_session_start': sessionStart.toIso8601String(),
      });

      // Atualizar progresso se fornecido
      if (completionPercentage != null) {
        await _lessonProgressTable
            .upsert({
              'user_id': userId,
              'lesson_id': lessonId,
              'completion_percentage': completionPercentage,
              'is_completed': completionPercentage >= 100,
              'completed_at': completionPercentage >= 100 
                  ? DateTime.now().toIso8601String()
                  : null,
            });
      }

      return StrautilsResponse.success(null);
    });
  }

  // Registrar resposta de quiz
  FStrautilsResponse<void> submitQuizResponse(int userId, int questionId, 
      int selectedOptionId, bool isCorrect) {
    return tryThis(() async {
      await _quizResponsesTable.upsert({
        'user_id': userId,
        'question_id': questionId,
        'selected_option_id': selectedOptionId,
        'is_correct': isCorrect,
      });

      return StrautilsResponse.success(null);
    });
  }

  // Calcular score de quiz
  Future<Map<String, dynamic>?> _calculateQuizScore(int userId, int quizId) async {
    try {
      final response = await _client
          .rpc('calculate_quiz_score', params: {
            'p_user_id': userId,
            'p_quiz_id': quizId,
          });

      return response.isNotEmpty ? response.first : null;
    } catch (e) {
      return null;
    }
  }

  // Obter total de comentários
  Future<int> _getTotalComments(int userId) async {
    try {
      final response = await _commentsTable
          .select('id')
          .eq('userId', userId);
      return (response as List).length;
    } catch (e) {
      return 0;
    }
  }

  // Obter dashboard resumido usando view otimizada
  FStrautilsResponse<Map<String, dynamic>> getDashboardSummary(int userId) {
    return tryThis(() async {
      final response = await _client
          .from('student_dashboard_summary')
          .select('*')
          .eq('user_id', userId)
          .single();

      return StrautilsResponse.success(response);
    });
  }

  // Obter atividades recentes
  FStrautilsResponse<List<Map<String, dynamic>>> getRecentActivities(int userId) {
    return tryThis(() async {
      final response = await _client
          .from('recent_activities')
          .select('*')
          .eq('user_id', userId)
          .order('activity_date', ascending: false)
          .limit(10);

      return StrautilsResponse.success(response);
    });
  }
} 