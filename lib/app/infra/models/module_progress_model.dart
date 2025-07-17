class ModuleProgressModel {
  final int? id;
  final int? userId;
  final int? moduleId;
  final bool isCompleted;
  final DateTime? updatedAt;

  ModuleProgressModel({
    this.id,
    this.userId,
    this.moduleId,
    this.isCompleted = false,
    this.updatedAt,
  });

  factory ModuleProgressModel.fromMap(Map<String, dynamic> map) {
    return ModuleProgressModel(
      id: map['id'],
      userId: map['userId'],
      moduleId: map['moduleId'],
      isCompleted: map['isCompleted'] ?? false,
      updatedAt: map['updatedAt'] != null 
          ? DateTime.parse(map['updatedAt']) 
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      if (userId != null) 'userId': userId,
      if (moduleId != null) 'moduleId': moduleId,
      'isCompleted': isCompleted,
      if (updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  // Retorna uma cópia do modelo com os campos atualizados
  ModuleProgressModel copyWith({
    int? id,
    int? userId,
    int? moduleId,
    bool? isCompleted,
    DateTime? updatedAt,
  }) {
    return ModuleProgressModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      moduleId: moduleId ?? this.moduleId,
      isCompleted: isCompleted ?? this.isCompleted,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
} 