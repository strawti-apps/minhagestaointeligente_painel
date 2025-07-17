import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../repositories/user_repository.dart';
import '../../modules/auth/pages/change_password_page.dart';
import '../../modules/dashboard/dashboard_page.dart';

class AuthService extends GetxService {
  late final UserRepository _userRepository;
  late final SupabaseClient _supabaseClient;

  @override
  void onInit() {
    super.onInit();
    _userRepository = UserRepository();
    _supabaseClient = Supabase.instance.client;
  }

  /// Verifica após o login se o usuário precisa alterar a senha
  Future<void> checkPasswordStatus() async {
    final user = _supabaseClient.auth.currentUser;
    
    if (user == null) {
      // Se não há usuário logado, redireciona para login
      debugPrint('DEBUG: Usuário não encontrado, redirecionando para login');
      Get.offAllNamed('/auth/login-email');
      return;
    }

    debugPrint('DEBUG: Verificando status da senha para o usuário: ${user.id}');
    
    // Verifica se o usuário precisa alterar a senha
    final mustChangeResponse = await _userRepository.mustChangePassword(user.id);
    
    debugPrint('DEBUG: Resultado da verificação: ${mustChangeResponse.success} - ${mustChangeResponse.data}');
    
    if (mustChangeResponse.success && mustChangeResponse.data == true) {
      // Usuário precisa alterar a senha
      debugPrint('DEBUG: Usuário precisa alterar a senha, redirecionando para mudança de senha');
      Get.offAllNamed(ChangePasswordPage.route);
    } else {
      // Usuário pode prosseguir para o dashboard
      debugPrint('DEBUG: Usuário NÃO precisa alterar a senha, redirecionando para dashboard');
      Get.offAllNamed(DashboardPage.route);
    }
  }

  /// Marca que o usuário alterou a senha e redireciona para o dashboard
  Future<void> completePasswordChange() async {
    final user = _supabaseClient.auth.currentUser;
    
    if (user == null) return;

    // Busca o usuário no banco para obter o ID
    final userResponse = await _userRepository.getUserByAuthId(user.id);
    
    if (userResponse.success && userResponse.data != null) {
      final userId = userResponse.data!.id;
      
      if (userId != null) {
        // Marca que a senha foi alterada
        final markPasswordResponse = await _userRepository.markPasswordChanged(userId);
        
        if (markPasswordResponse.success) {
          debugPrint('DEBUG: Senha marcada como alterada para o usuário ID: $userId');
        } else {
          debugPrint('DEBUG: Erro ao marcar senha como alterada: ${markPasswordResponse.message}');
        }
      }
    } else {
      debugPrint('DEBUG: Erro ao buscar usuário: ${userResponse.message}');
    }

    // Redireciona para o dashboard
    Get.offAllNamed(DashboardPage.route);
  }
} 