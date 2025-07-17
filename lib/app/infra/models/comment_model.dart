class CommentModel {
  final int? id;
  final int? userId;
  final int? lessonId;
  final String text;
  final DateTime? createdAt;

  CommentModel({
    this.id,
    this.userId,
    this.lessonId,
    required this.text,
    this.createdAt,
  });

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map['id'],
      userId: map['userId'],
      lessonId: map['lessonId'],
      text: map['text'],
      createdAt: map['createdAt'] != null 
          ? DateTime.parse(map['createdAt']) 
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      if (userId != null) 'userId': userId,
      if (lessonId != null) 'lessonId': lessonId,
      'text': text,
      if (createdAt != null) 'createdAt': createdAt?.toIso8601String(),
    };
  }

  // Retorna uma cópia do modelo com os campos atualizados
  CommentModel copyWith({
    int? id,
    int? userId,
    int? lessonId,
    String? text,
    DateTime? createdAt,
  }) {
    return CommentModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      lessonId: lessonId ?? this.lessonId,
      text: text ?? this.text,
      createdAt: createdAt ?? this.createdAt,
    );
  }
} 