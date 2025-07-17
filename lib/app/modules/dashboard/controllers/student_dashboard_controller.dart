import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:strawti_utils/strawti_utils.dart';

import '../../../infra/models/course_progress_model.dart';
import '../../../infra/models/student_stats_model.dart';
import '../../../infra/repositories/student_dashboard_repository.dart';
import '../../../shared/mixins/loader_manager.dart';

class StudentDashboardController extends GetxController with LoaderManager {
  final StudentDashboardRepository _repository = StudentDashboardRepository();

  // Estados principais
  StudentStatsModel? _stats;
  List<CourseProgressModel> _courseProgress = [];
  List<Map<String, dynamic>> _recentActivities = [];
  String? _error;

  // Getters
  StudentStatsModel? get stats => _stats;
  List<CourseProgressModel> get courseProgress => _courseProgress;
  List<Map<String, dynamic>> get recentActivities => _recentActivities;
  String? get error => _error;
  bool get hasData => _stats != null;
  bool get hasError => _error != null;

  // Dados do usuário
  int get userId => Get.arguments?['userId'] ?? 0;
  String get userRole => Get.arguments?['userRole'] ?? 'student';

  @override
  void onInit() {
    super.onInit();
    loadDashboardData();
  }

  /// Carregar todos os dados da dashboard
  Future<void> loadDashboardData() async {
    try {
      changeLoading(true);
      _clearError();
      
      // Carregar dados em paralelo para melhor performance
      final results = await Future.wait([
        _repository.getStudentStats(userId),
        _repository.getCourseProgress(userId),
        _repository.getRecentActivities(userId),
      ]);

      final statsResult = results[0] as StrautilsResponse<StudentStatsModel>;
      final progressResult = results[1] as StrautilsResponse<List<CourseProgressModel>>;
      final activitiesResult = results[2] as StrautilsResponse<List<Map<String, dynamic>>>;

      // Verificar se todas as chamadas foram bem-sucedidas
      if (statsResult.data != null && progressResult.data != null && activitiesResult.data != null) {
        _stats = statsResult.data;
        _courseProgress = progressResult.data ?? [];
        _recentActivities = activitiesResult.data ?? [];
        _clearError();
      } else {
        _setError('Erro ao carregar dados da dashboard');
      }
    } catch (e) {
      debugPrint('Erro ao carregar dashboard: $e');
      _setError('Erro inesperado ao carregar dados');
    } finally {
      changeLoading(false);
    }
  }

  /// Atualizar apenas as estatísticas
  Future<void> refreshStats() async {
    try {
      final result = await _repository.getStudentStats(userId);
      
      if (result.data != null) {
        _stats = result.data;
        update(['stats']);
      }
    } catch (e) {
      debugPrint('Erro ao atualizar estatísticas: $e');
    }
  }

  /// Atualizar apenas o progresso dos cursos
  Future<void> refreshCourseProgress() async {
    try {
      final result = await _repository.getCourseProgress(userId);
      
      if (result.data != null) {
        _courseProgress = result.data ?? [];
        update(['courseProgress']);
      }
    } catch (e) {
      debugPrint('Erro ao atualizar progresso dos cursos: $e');
    }
  }

  /// Atualizar apenas as atividades recentes
  Future<void> refreshRecentActivities() async {
    try {
      final result = await _repository.getRecentActivities(userId);
      
      if (result.data != null) {
        _recentActivities = result.data ?? [];
        update(['recentActivities']);
      }
    } catch (e) {
      debugPrint('Erro ao atualizar atividades recentes: $e');
    }
  }

  /// Registrar acesso a uma aula
  Future<void> registerLessonAccess(int lessonId, {
    String? deviceType,
    String? ipAddress,
    String? userAgent,
  }) async {
    try {
      await _repository.registerLessonAccess(
        userId,
        lessonId,
        deviceType: deviceType,
        ipAddress: ipAddress,
        userAgent: userAgent,
      );
      
      // Atualizar estatísticas após registrar acesso
      refreshStats();
    } catch (e) {
      debugPrint('Erro ao registrar acesso à aula: $e');
    }
  }

  /// Finalizar sessão de uma aula
  Future<void> endLessonSession(
    int lessonId,
    DateTime sessionStart, {
    int? completionPercentage,
  }) async {
    try {
      await _repository.endLessonSession(
        userId,
        lessonId,
        sessionStart,
        completionPercentage: completionPercentage,
      );
      
      // Atualizar dados após finalizar sessão
      await Future.wait([
        refreshStats(),
        refreshCourseProgress(),
        refreshRecentActivities(),
      ]);
    } catch (e) {
      debugPrint('Erro ao finalizar sessão da aula: $e');
    }
  }

  /// Submeter resposta de quiz
  Future<void> submitQuizResponse(
    int questionId,
    int selectedOptionId,
    bool isCorrect,
  ) async {
    try {
      await _repository.submitQuizResponse(
        userId,
        questionId,
        selectedOptionId,
        isCorrect,
      );
      
      // Atualizar estatísticas após responder quiz
      refreshStats();
    } catch (e) {
      debugPrint('Erro ao submeter resposta do quiz: $e');
    }
  }

  /// Navegar para detalhes de um curso
  void navigateToCourse(int courseId) {
    Get.toNamed('/course/$courseId');
  }

  /// Navegar para um quiz específico
  void navigateToQuiz(int quizId) {
    Get.toNamed('/quiz/$quizId');
  }

  /// Formatar última atividade
  String formatLastActivity() {
    if (_stats?.lastActivity == null) return 'Nunca';
    
    final now = DateTime.now();
    final difference = now.difference(_stats!.lastActivity!);
    
    if (difference.inDays > 0) {
      return '${difference.inDays} dia${difference.inDays > 1 ? 's' : ''} atrás';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hora${difference.inHours > 1 ? 's' : ''} atrás';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minuto${difference.inMinutes > 1 ? 's' : ''} atrás';
    } else {
      return 'Agora mesmo';
    }
  }

  /// Formatar data de atividade
  String formatActivityDate(dynamic date) {
    if (date == null) return '';
    
    final activityDate = DateTime.parse(date.toString());
    final now = DateTime.now();
    final difference = now.difference(activityDate);
    
    if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else {
      return '${difference.inMinutes}m';
    }
  }

  /// Obter título da dashboard baseado no role
  String get dashboardTitle {
    return 'Dashboard ${userRole == "student" ? "do Aluno" : "do Professor"}';
  }

  /// Verificar se tem atividade recente
  bool get hasRecentActivity => _stats?.hasRecentActivity ?? false;

  /// Limpar erro
  void _clearError() {
    _error = null;
    update(['error']);
  }

  /// Definir erro
  void _setError(String errorMessage) {
    _error = errorMessage;
    update(['error']);
  }

  /// Retry em caso de erro
  Future<void> retry() async {
    await loadDashboardData();
  }
} 