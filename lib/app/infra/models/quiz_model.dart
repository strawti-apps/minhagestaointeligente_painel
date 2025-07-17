class QuizModel {
  final int? id;
  final String type;
  final String title;
  final int? courseId;
  final DateTime? createdAt;

  QuizModel({
    this.id,
    required this.type,
    required this.title,
    this.courseId,
    this.createdAt,
  });

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    return QuizModel(
      id: map['id'],
      type: map['type'],
      title: map['title'],
      courseId: map['courseId'],
      createdAt: map['createdAt'] != null 
          ? DateTime.parse(map['createdAt']) 
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'type': type,
      'title': title,
      if (courseId != null) 'courseId': courseId,
      if (createdAt != null) 'createdAt': createdAt?.toIso8601String(),
    };
  }

  // Retorna uma cópia do modelo com os campos atualizados
  QuizModel copyWith({
    int? id,
    String? type,
    String? title,
    int? courseId,
    DateTime? createdAt,
  }) {
    return QuizModel(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      courseId: courseId ?? this.courseId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
} 