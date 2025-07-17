class StudentStatsModel {
  final int totalCourses;
  final int completedModules;
  final int totalModules;
  final int progressPercentage;
  final int totalComments;
  final List<Map<String, dynamic>> recentActivities;
  
  // Novas métricas de aulas
  final int completedLessons;
  final int totalLessons;
  final int lessonProgressPercentage;
  
  // Métricas de tempo e atividade
  final int totalTimeSpentSeconds;
  final DateTime? lastActivity;
  
  // Métricas de quiz
  final int quizAttempts;
  final int quizPasses;
  final int quizAccuracy;

  StudentStatsModel({
    required this.totalCourses,
    required this.completedModules,
    required this.totalModules,
    required this.progressPercentage,
    required this.totalComments,
    required this.recentActivities,
    required this.completedLessons,
    required this.totalLessons,
    required this.lessonProgressPercentage,
    required this.totalTimeSpentSeconds,
    this.lastActivity,
    required this.quizAttempts,
    required this.quizPasses,
    required this.quizAccuracy,
  });

  // Construtor para estado vazio
  factory StudentStatsModel.empty() {
    return StudentStatsModel(
      totalCourses: 0,
      completedModules: 0,
      totalModules: 0,
      progressPercentage: 0,
      totalComments: 0,
      recentActivities: [],
      completedLessons: 0,
      totalLessons: 0,
      lessonProgressPercentage: 0,
      totalTimeSpentSeconds: 0,
      lastActivity: null,
      quizAttempts: 0,
      quizPasses: 0,
      quizAccuracy: 0,
    );
  }

  factory StudentStatsModel.fromMap(Map<String, dynamic> map) {
    return StudentStatsModel(
      totalCourses: map['totalCourses'] ?? 0,
      completedModules: map['completedModules'] ?? 0,
      totalModules: map['totalModules'] ?? 0,
      progressPercentage: map['progressPercentage'] ?? 0,
      totalComments: map['totalComments'] ?? 0,
      recentActivities: List<Map<String, dynamic>>.from(map['recentActivities'] ?? []),
      completedLessons: map['completedLessons'] ?? 0,
      totalLessons: map['totalLessons'] ?? 0,
      lessonProgressPercentage: map['lessonProgressPercentage'] ?? 0,
      totalTimeSpentSeconds: map['totalTimeSpentSeconds'] ?? 0,
      lastActivity: map['lastActivity'] != null 
          ? DateTime.parse(map['lastActivity'])
          : null,
      quizAttempts: map['quizAttempts'] ?? 0,
      quizPasses: map['quizPasses'] ?? 0,
      quizAccuracy: map['quizAccuracy'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'totalCourses': totalCourses,
      'completedModules': completedModules,
      'totalModules': totalModules,
      'progressPercentage': progressPercentage,
      'totalComments': totalComments,
      'recentActivities': recentActivities,
      'completedLessons': completedLessons,
      'totalLessons': totalLessons,
      'lessonProgressPercentage': lessonProgressPercentage,
      'totalTimeSpentSeconds': totalTimeSpentSeconds,
      'lastActivity': lastActivity?.toIso8601String(),
      'quizAttempts': quizAttempts,
      'quizPasses': quizPasses,
      'quizAccuracy': quizAccuracy,
    };
  }

  StudentStatsModel copyWith({
    int? totalCourses,
    int? completedModules,
    int? totalModules,
    int? progressPercentage,
    int? totalComments,
    List<Map<String, dynamic>>? recentActivities,
    int? completedLessons,
    int? totalLessons,
    int? lessonProgressPercentage,
    int? totalTimeSpentSeconds,
    DateTime? lastActivity,
    int? quizAttempts,
    int? quizPasses,
    int? quizAccuracy,
  }) {
    return StudentStatsModel(
      totalCourses: totalCourses ?? this.totalCourses,
      completedModules: completedModules ?? this.completedModules,
      totalModules: totalModules ?? this.totalModules,
      progressPercentage: progressPercentage ?? this.progressPercentage,
      totalComments: totalComments ?? this.totalComments,
      recentActivities: recentActivities ?? this.recentActivities,
      completedLessons: completedLessons ?? this.completedLessons,
      totalLessons: totalLessons ?? this.totalLessons,
      lessonProgressPercentage: lessonProgressPercentage ?? this.lessonProgressPercentage,
      totalTimeSpentSeconds: totalTimeSpentSeconds ?? this.totalTimeSpentSeconds,
      lastActivity: lastActivity ?? this.lastActivity,
      quizAttempts: quizAttempts ?? this.quizAttempts,
      quizPasses: quizPasses ?? this.quizPasses,
      quizAccuracy: quizAccuracy ?? this.quizAccuracy,
    );
  }

  // Getters utilitários
  String get formattedTimeSpent {
    final hours = totalTimeSpentSeconds ~/ 3600;
    final minutes = (totalTimeSpentSeconds % 3600) ~/ 60;
    
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else if (minutes > 0) {
      return '${minutes}m';
    } else {
      return '${totalTimeSpentSeconds}s';
    }
  }

  double get quizPassRate {
    return quizAttempts > 0 ? (quizPasses / quizAttempts) * 100 : 0.0;
  }

  bool get hasRecentActivity => lastActivity != null;

  String get overallProgressText {
    if (totalModules == 0) return 'Nenhum módulo disponível';
    if (progressPercentage == 100) return 'Todos os módulos concluídos';
    if (progressPercentage == 0) return 'Nenhum módulo iniciado';
    return '$completedModules de $totalModules módulos concluídos';
  }

  String get lessonProgressText {
    if (totalLessons == 0) return 'Nenhuma aula disponível';
    if (lessonProgressPercentage == 100) return 'Todas as aulas concluídas';
    if (lessonProgressPercentage == 0) return 'Nenhuma aula iniciada';
    return '$completedLessons de $totalLessons aulas concluídas';
  }
} 