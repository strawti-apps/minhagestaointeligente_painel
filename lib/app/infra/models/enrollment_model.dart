class EnrollmentModel {
  final int? id;
  final int? userId;
  final int? classId;
  final DateTime? createdAt;

  EnrollmentModel({
    this.id,
    this.userId,
    this.classId,
    this.createdAt,
  });

  factory EnrollmentModel.fromMap(Map<String, dynamic> map) {
    return EnrollmentModel(
      id: map['id'],
      userId: map['userId'],
      classId: map['classId'],
      createdAt: map['createdAt'] != null 
          ? DateTime.parse(map['createdAt']) 
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      if (userId != null) 'userId': userId,
      if (classId != null) 'classId': classId,
      if (createdAt != null) 'createdAt': createdAt?.toIso8601String(),
    };
  }

  // Retorna uma cópia do modelo com os campos atualizados
  EnrollmentModel copyWith({
    int? id,
    int? userId,
    int? classId,
    DateTime? createdAt,
  }) {
    return EnrollmentModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      classId: classId ?? this.classId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
} 