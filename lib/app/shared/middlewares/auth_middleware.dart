import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../infra/services/auth_service.dart';
import '../../infra/services/user_service.dart';
import '../../modules/auth/pages/change_password_page.dart';
import '../../modules/auth/pages/login_email_page.dart';
import '../../modules/dashboard/dashboard_page.dart';
import '../utils/app_snackbar.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    // Permitir acesso à página de alteração de senha mesmo sem UserService.currentUser
    if (route == ChangePasswordPage.route) {
      final authUser = Supabase.instance.client.auth.currentUser;
      if (authUser != null) {
        return null; // Permite acesso se o usuário está autenticado no Supabase
      }
    }

    if (UserService.currentUser == null) {
      Future.delayed(const Duration(seconds: 1)).whenComplete(() {
        AppSnackbar.to.success("Sessão expirada! Entre novamente");
      });

      return const RouteSettings(name: LoginEmailPage.route);
    }
    return null;
  }
}

class AdminMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final user = UserService.currentUser;

    if (user == null) {
      Future.delayed(const Duration(seconds: 1)).whenComplete(() {
        AppSnackbar.to.error("Sessão expirada! Entre novamente");
      });
      return const RouteSettings(name: LoginEmailPage.route);
    }

    // Apenas administradores podem acessar certas rotas
    if (user.role.toLowerCase() != 'admin') {
      Future.delayed(const Duration(seconds: 1)).whenComplete(() {
        AppSnackbar.to.warning(
          "Acesso negado! Você não tem permissão para acessar esta área do sistema.",
        );
      });
      return const RouteSettings(name: DashboardPage.route);
    }

    return null;
  }
}

class SplashAuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    try {
      final authUser = Supabase.instance.client.auth.currentUser;

      if (authUser != null) {
        final session = Supabase.instance.client.auth.currentSession;

        if (session != null && !session.isExpired) {
          // Verificar se o usuário tem dados válidos
          // TODO: depois teremos os níveis de acesso
          if (UserService.currentUser != null) {
            // Usar AuthService para verificar se precisa alterar senha
            Future.delayed(Duration.zero, () {
              Get.find<AuthService>().checkPasswordStatus();
            });
            return null; // Não redireciona imediatamente, deixa o AuthService decidir
          } else {
            // Se não tem dados válidos, fazer logout e ir para login
            // UserService().logout();
            return const RouteSettings(name: LoginEmailPage.route);
          }
        } else {
          // Sessão expirada
          // UserService().logout();
          return const RouteSettings(name: LoginEmailPage.route);
        }
      } else {
        // Não há usuário autenticado
        return const RouteSettings(name: LoginEmailPage.route);
      }
    } catch (e) {
      // Erro na verificação de autenticação
      return const RouteSettings(name: LoginEmailPage.route);
    }
  }
}
