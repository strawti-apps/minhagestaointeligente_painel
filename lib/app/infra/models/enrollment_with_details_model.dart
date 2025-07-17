import 'class_model.dart';
import 'enrollment_model.dart';
import 'user_model.dart';

class EnrollmentWithDetailsModel {
  final int id;
  final int userId;
  final int classId;
  final DateTime? createdAt;
  final UserModel user;
  final ClassModel classData;

  EnrollmentWithDetailsModel({
    required this.id,
    required this.userId,
    required this.classId,
    this.createdAt,
    required this.user,
    required this.classData,
  });

  factory EnrollmentWithDetailsModel.fromMap(Map<String, dynamic> map) {
    return EnrollmentWithDetailsModel(
      id: map['id'],
      userId: map['userId'],
      classId: map['classId'],
      createdAt: map['createdAt'] != null 
          ? DateTime.parse(map['createdAt']) 
          : null,
      user: UserModel.fromMap(map['users']),
      classData: ClassModel.fromMap(map['classes']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'classId': classId,
      if (createdAt != null) 'createdAt': createdAt?.toIso8601String(),
      'users': user.toMap(),
      'classes': classData.toMap(),
    };
  }

  // Métodos de conveniência para facilitar o uso
  String get userFullName {
    return '${user.firstName} ${user.lastName ?? ''}'.trim();
  }

  String get userRole {
    return user.role == 'teacher' ? 'Professor' : 'Aluno';
  }

  String get userEmail {
    return user.email;
  }

  String get className {
    return classData.title;
  }

  String get formattedDate {
    if (createdAt != null) {
      return '${createdAt!.day.toString().padLeft(2, '0')}/${createdAt!.month.toString().padLeft(2, '0')}/${createdAt!.year}';
    }
    return '';
  }

  // Converter para EnrollmentModel simples
  EnrollmentModel toEnrollmentModel() {
    return EnrollmentModel(
      id: id,
      userId: userId,
      classId: classId,
      createdAt: createdAt,
    );
  }

  // Criar cópia com campos atualizados
  EnrollmentWithDetailsModel copyWith({
    int? id,
    int? userId,
    int? classId,
    DateTime? createdAt,
    UserModel? user,
    ClassModel? classData,
  }) {
    return EnrollmentWithDetailsModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      classId: classId ?? this.classId,
      createdAt: createdAt ?? this.createdAt,
      user: user ?? this.user,
      classData: classData ?? this.classData,
    );
  }
} 