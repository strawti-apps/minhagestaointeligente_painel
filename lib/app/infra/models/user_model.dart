import 'model_base.dart';

class UserModel extends ModelBase {
  final int? id;
  final String authUserId;
  final String firstName;
  final String? lastName;
  final String email;
  final String role;
  final DateTime? createdAt;
  final bool mustChangePassword;

  UserModel({
    this.id,
    required this.authUserId,
    required this.firstName,
    this.lastName,
    required this.email,
    required this.role,
    this.createdAt,
    this.mustChangePassword = false, // Por padrão, usuários NÃO precisam mudar a senha
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      authUserId: map['authUserId'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      role: map['role'],
      createdAt: map['createdAt'] != null 
          ? DateTime.parse(map['createdAt']) 
          : null,
      mustChangePassword: map['mustChangePassword'] ?? false,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'authUserId': authUserId,
      'firstName': firstName,
      if (lastName != null) 'lastName': lastName,
      'email': email,
      'role': role,
      if (createdAt != null) 'createdAt': createdAt?.toIso8601String(),
      'mustChangePassword': mustChangePassword,
    };
  }

  // Retorna uma cópia do modelo com os campos atualizados
  UserModel copyWith({
    int? id,
    String? authUserId,
    String? firstName,
    String? lastName,
    String? email,
    String? role,
    DateTime? createdAt,
    bool? mustChangePassword,
  }) {
    return UserModel(
      id: id ?? this.id,
      authUserId: authUserId ?? this.authUserId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      mustChangePassword: mustChangePassword ?? this.mustChangePassword,
    );
  }
} 