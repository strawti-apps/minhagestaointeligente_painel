class LessonModel {
  final int? id;
  final int? moduleId;
  final String title;
  final String? type; // 'video', 'material', 'quiz'
  final String? videoId;
  final int orderIndex;
  final DateTime? createdAt;
  final int? materialId;
  final int? quizId;

  LessonModel({
    this.id,
    this.moduleId,
    required this.title,
    this.type,
    this.videoId,
    required this.orderIndex,
    this.createdAt,
    this.materialId,
    this.quizId,
  });

  factory LessonModel.fromMap(Map<String, dynamic> map) {
    return LessonModel(
      id: map['id'],
      moduleId: map['moduleId'],
      title: map['title'],
      type: map['type'],
      videoId: map['videoId'],
      orderIndex: map['orderIndex'],
      createdAt: map['createdAt'] != null 
          ? DateTime.parse(map['createdAt']) 
          : null,
      materialId: map['materialId'],
      quizId: map['quizId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      if (moduleId != null) 'moduleId': moduleId,
      'title': title,
      if (type != null) 'type': type,
      if (videoId != null) 'videoId': videoId,
      'orderIndex': orderIndex,
      if (createdAt != null) 'createdAt': createdAt?.toIso8601String(),
      if (materialId != null) 'materialId': materialId,
      if (quizId != null) 'quizId': quizId,
    };
  }

  // Retorna uma cópia do modelo com os campos atualizados
  LessonModel copyWith({
    int? id,
    int? moduleId,
    String? title,
    String? type,
    String? videoId,
    int? orderIndex,
    DateTime? createdAt,
    int? materialId,
    int? quizId,
  }) {
    return LessonModel(
      id: id ?? this.id,
      moduleId: moduleId ?? this.moduleId,
      title: title ?? this.title,
      type: type ?? this.type,
      videoId: videoId ?? this.videoId,
      orderIndex: orderIndex ?? this.orderIndex,
      createdAt: createdAt ?? this.createdAt,
      materialId: materialId ?? this.materialId,
      quizId: quizId ?? this.quizId,
    );
  }
} 