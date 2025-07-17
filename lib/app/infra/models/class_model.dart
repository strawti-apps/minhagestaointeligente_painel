import 'model_base.dart';

class ClassModel extends ModelBase {
  final int? id;
  final String title;
  final int? courseId;
  final String? thumbnailUrl;
  final bool sendWelcomeEmail;
  final DateTime? createdAt;

  ClassModel({
    this.id,
    required this.title,
    this.courseId,
    this.thumbnailUrl,
    this.sendWelcomeEmail = false,
    this.createdAt,
  });

  factory ClassModel.fromMap(Map<String, dynamic> map) {
    return ClassModel(
      id: map['id'],
      title: map['title'],
      courseId: map['courseId'],
      thumbnailUrl: map['thumbnailUrl'],
      sendWelcomeEmail: map['sendWelcomeEmail'] ?? false,
      createdAt: map['createdAt'] != null 
          ? DateTime.parse(map['createdAt']) 
          : null,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'title': title,
      if (courseId != null) 'courseId': courseId,
      if (thumbnailUrl != null) 'thumbnailUrl': thumbnailUrl,
      'sendWelcomeEmail': sendWelcomeEmail,
      if (createdAt != null) 'createdAt': createdAt?.toIso8601String(),
    };
  }

  // Retorna uma cópia do modelo com os campos atualizados
  ClassModel copyWith({
    int? id,
    String? title,
    int? courseId,
    String? thumbnailUrl,
    bool? sendWelcomeEmail,
    DateTime? createdAt,
  }) {
    return ClassModel(
      id: id ?? this.id,
      title: title ?? this.title,
      courseId: courseId ?? this.courseId,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      sendWelcomeEmail: sendWelcomeEmail ?? this.sendWelcomeEmail,
      createdAt: createdAt ?? this.createdAt,
    );
  }
} 