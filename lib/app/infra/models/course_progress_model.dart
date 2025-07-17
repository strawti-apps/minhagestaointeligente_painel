class CourseProgressModel {
  final int courseId;
  final String courseTitle;
  final String? courseThumbnail;
  final String classTitle;
  final int totalModules;
  final int completedModules;
  final int progressPercentage;
  final int? nextModuleIndex;
  final String? nextModuleTitle;
  final DateTime? lastActivity;
  
  // Novas métricas de aulas
  final int totalLessons;
  final int completedLessons;
  final int lessonProgressPercentage;
  
  // Métricas de tempo e status
  final int totalTimeSpentSeconds;
  final String courseStatus;
  final String? nextLessonTitle;

  CourseProgressModel({
    required this.courseId,
    required this.courseTitle,
    this.courseThumbnail,
    required this.classTitle,
    required this.totalModules,
    required this.completedModules,
    required this.progressPercentage,
    this.nextModuleIndex,
    this.nextModuleTitle,
    this.lastActivity,
    required this.totalLessons,
    required this.completedLessons,
    required this.lessonProgressPercentage,
    required this.totalTimeSpentSeconds,
    required this.courseStatus,
    this.nextLessonTitle,
  });

  factory CourseProgressModel.fromMap(Map<String, dynamic> map) {
    return CourseProgressModel(
      courseId: map['courseId'],
      courseTitle: map['courseTitle'],
      courseThumbnail: map['courseThumbnail'],
      classTitle: map['classTitle'],
      totalModules: map['totalModules'] ?? 0,
      completedModules: map['completedModules'] ?? 0,
      progressPercentage: map['progressPercentage'] ?? 0,
      nextModuleIndex: map['nextModuleIndex'],
      nextModuleTitle: map['nextModuleTitle'],
      lastActivity: map['lastActivity'] != null 
          ? DateTime.parse(map['lastActivity']) 
          : null,
      totalLessons: map['totalLessons'] ?? 0,
      completedLessons: map['completedLessons'] ?? 0,
      lessonProgressPercentage: map['lessonProgressPercentage'] ?? 0,
      totalTimeSpentSeconds: map['totalTimeSpentSeconds'] ?? 0,
      courseStatus: map['courseStatus'] ?? 'not_started',
      nextLessonTitle: map['nextLessonTitle'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'courseId': courseId,
      'courseTitle': courseTitle,
      'courseThumbnail': courseThumbnail,
      'classTitle': classTitle,
      'totalModules': totalModules,
      'completedModules': completedModules,
      'progressPercentage': progressPercentage,
      'nextModuleIndex': nextModuleIndex,
      'nextModuleTitle': nextModuleTitle,
      'lastActivity': lastActivity?.toIso8601String(),
      'totalLessons': totalLessons,
      'completedLessons': completedLessons,
      'lessonProgressPercentage': lessonProgressPercentage,
      'totalTimeSpentSeconds': totalTimeSpentSeconds,
      'courseStatus': courseStatus,
      'nextLessonTitle': nextLessonTitle,
    };
  }

  CourseProgressModel copyWith({
    int? courseId,
    String? courseTitle,
    String? courseThumbnail,
    String? classTitle,
    int? totalModules,
    int? completedModules,
    int? progressPercentage,
    int? nextModuleIndex,
    String? nextModuleTitle,
    DateTime? lastActivity,
    int? totalLessons,
    int? completedLessons,
    int? lessonProgressPercentage,
    int? totalTimeSpentSeconds,
    String? courseStatus,
    String? nextLessonTitle,
  }) {
    return CourseProgressModel(
      courseId: courseId ?? this.courseId,
      courseTitle: courseTitle ?? this.courseTitle,
      courseThumbnail: courseThumbnail ?? this.courseThumbnail,
      classTitle: classTitle ?? this.classTitle,
      totalModules: totalModules ?? this.totalModules,
      completedModules: completedModules ?? this.completedModules,
      progressPercentage: progressPercentage ?? this.progressPercentage,
      nextModuleIndex: nextModuleIndex ?? this.nextModuleIndex,
      nextModuleTitle: nextModuleTitle ?? this.nextModuleTitle,
      lastActivity: lastActivity ?? this.lastActivity,
      totalLessons: totalLessons ?? this.totalLessons,
      completedLessons: completedLessons ?? this.completedLessons,
      lessonProgressPercentage: lessonProgressPercentage ?? this.lessonProgressPercentage,
      totalTimeSpentSeconds: totalTimeSpentSeconds ?? this.totalTimeSpentSeconds,
      courseStatus: courseStatus ?? this.courseStatus,
      nextLessonTitle: nextLessonTitle ?? this.nextLessonTitle,
    );
  }

  bool get hasNextModule => nextModuleIndex != null && nextModuleTitle != null;
  bool get hasNextLesson => nextLessonTitle != null;
  bool get isCompleted => courseStatus == 'completed' || progressPercentage >= 100;
  bool get isInProgress => courseStatus == 'in_progress';
  bool get isNotStarted => courseStatus == 'not_started';
  
  String get statusText {
    switch (courseStatus) {
      case 'completed':
        return 'Concluído';
      case 'in_progress':
        return 'Em andamento';
      case 'not_started':
      default:
        return 'Não iniciado';
    }
  }

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

  String get nextActionText {
    if (isCompleted) {
      return 'Curso finalizado';
    } else if (hasNextLesson) {
      return 'Próxima aula: $nextLessonTitle';
    } else if (hasNextModule) {
      return 'Próximo módulo: $nextModuleTitle';
    } else {
      return 'Iniciar curso';
    }
  }

  double get overallProgress {
    if (totalModules == 0 && totalLessons == 0) return 0.0;
    
    // Calcular progresso ponderado: 70% módulos + 30% aulas
    final moduleWeight = 0.7;
    final lessonWeight = 0.3;
    
    final moduleProgress = totalModules > 0 ? progressPercentage / 100.0 : 0.0;
    final lessonProgress = totalLessons > 0 ? lessonProgressPercentage / 100.0 : 0.0;
    
    return (moduleProgress * moduleWeight) + (lessonProgress * lessonWeight);
  }

  String get progressSummary {
    final parts = <String>[];
    
    if (totalModules > 0) {
      parts.add('$completedModules/$totalModules módulos');
    }
    
    if (totalLessons > 0) {
      parts.add('$completedLessons/$totalLessons aulas');
    }
    
    return parts.isEmpty ? 'Sem conteúdo disponível' : parts.join(' • ');
  }
} 