import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infra/models/user_model.dart';
import '../../infra/services/user_service.dart';
import '../../modules/auth/pages/login_email_page.dart';
import '../../themes/app_colors.dart';

class UserInfoWidget extends StatelessWidget {
  final bool isMobile;

  const UserInfoWidget({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    final user = UserService.currentUser;

    if (user == null) {
      return const SizedBox.shrink();
    }

    if (isMobile) {
      return UserInfoMobileWidget(user: user);
    } else {
      return UserInfoDesktopWidget(user: user);
    }
  }
}

class UserInfoDesktopWidget extends StatelessWidget {
  final UserModel user;

  const UserInfoDesktopWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          // Avatar e nome
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                child: Text(
                  UserInfoHelper.getInitials(user.firstName, user.lastName),
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${user.firstName} ${user.lastName ?? ''}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      UserInfoHelper.getRoleLabel(user.role),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Botão de logout
          const LogoutButton(isDesktop: true),
        ],
      ),
    );
  }
}

class UserInfoMobileWidget extends StatelessWidget {
  final UserModel user;

  const UserInfoMobileWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.grey.shade50,
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            backgroundColor: AppColors.primary.withValues(alpha: 0.1),
            radius: 18,
            child: Text(
              UserInfoHelper.getInitials(user.firstName, user.lastName),
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Nome e role
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${user.firstName} ${user.lastName ?? ''}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  UserInfoHelper.getRoleLabel(user.role),
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),

          // Botão de logout
          const LogoutButton(isDesktop: false),
        ],
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  final bool isDesktop;

  const LogoutButton({super.key, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    if (isDesktop) {
      return SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: UserInfoHelper.logout,
          icon: const Icon(Icons.logout, size: 16),
          label: const Text('Sair', style: TextStyle(fontSize: 12)),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 8),
            side: BorderSide(color: Colors.grey.shade300),
            foregroundColor: Colors.grey.shade700,
          ),
        ),
      );
    } else {
      return IconButton(
        onPressed: UserInfoHelper.logout,
        icon: Icon(Icons.logout, size: 20, color: Colors.grey.shade700),
        tooltip: 'Sair',
      );
    }
  }
}

class UserInfoHelper {
  static String getInitials(String firstName, String? lastName) {
    String initials = firstName.isNotEmpty ? firstName[0].toUpperCase() : '';
    if (lastName != null && lastName.isNotEmpty) {
      initials += lastName[0].toUpperCase();
    }
    return initials;
  }

  static String getRoleLabel(String role) {
    switch (role.toLowerCase()) {
      case 'admin':
        return 'Administrador';
      case 'teacher':
        return 'Professor';
      case 'student':
        return 'Aluno';
      default:
        return role;
    }
  }

  static void logout() async {
    // Mostrar diálogo de confirmação
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Confirmar Logout'),
        content: const Text('Tem certeza que deseja sair da sua conta?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Sair'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      Get.offAllNamed(LoginEmailPage.route);
    }
  }
}
