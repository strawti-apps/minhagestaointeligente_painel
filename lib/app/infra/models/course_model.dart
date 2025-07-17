import 'model_base.dart';

class CourseModel extends ModelBase {
  final int? id;
  final String title;
  final DateTime? createdAt;
  final String? description;
  final String? category;
  final String? coverImageUrl;

  CourseModel({
    this.id,
    required this.title,
    this.createdAt,
    this.description,
    this.category,
    this.coverImageUrl,
  });

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      id: map['id'],
      title: map['title'],
      createdAt: map['createdAt'] != null 
          ? DateTime.parse(map['createdAt']) 
          : null,
      description: map['description'],
      category: map['category'],
      coverImageUrl: map['coverImageUrl'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'title': title,
      if (createdAt != null) 'createdAt': createdAt?.toIso8601String(),
      if (description != null) 'description': description,
      if (category != null) 'category': category,
      if (coverImageUrl != null) 'coverImageUrl': coverImageUrl,
    };
  }

  // Retorna uma cópia do modelo com os campos atualizados
  CourseModel copyWith({
    int? id,
    String? title,
    DateTime? createdAt,
    String? description,
    String? category,
    String? coverImageUrl,
  }) {
    return CourseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      description: description ?? this.description,
      category: category ?? this.category,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
    );
  }
} 