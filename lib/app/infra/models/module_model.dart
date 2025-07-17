class ModuleModel {
  final int? id;
  final int? courseId;
  final String title;
  final int orderIndex;
  final DateTime? createdAt;

  ModuleModel({
    this.id,
    this.courseId,
    required this.title,
    required this.orderIndex,
    this.createdAt,
  });

  factory ModuleModel.fromMap(Map<String, dynamic> map) {
    return ModuleModel(
      id: map['id'],
      courseId: map['courseId'],
      title: map['title'],
      orderIndex: map['orderIndex'],
      createdAt: map['createdAt'] != null 
          ? DateTime.parse(map['createdAt']) 
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      if (courseId != null) 'courseId': courseId,
      'title': title,
      'orderIndex': orderIndex,
      if (createdAt != null) 'createdAt': createdAt?.toIso8601String(),
    };
  }

  // Retorna uma cópia do modelo com os campos atualizados
  ModuleModel copyWith({
    int? id,
    int? courseId,
    String? title,
    int? orderIndex,
    DateTime? createdAt,
  }) {
    return ModuleModel(
      id: id ?? this.id,
      courseId: courseId ?? this.courseId,
      title: title ?? this.title,
      orderIndex: orderIndex ?? this.orderIndex,
      createdAt: createdAt ?? this.createdAt,
    );
  }
} 