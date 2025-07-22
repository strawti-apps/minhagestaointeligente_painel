import 'package:get/get.dart';

import '../../infra/services/user_service.dart';

mixin NavigationHelper {
  /// Navega para uma rota preservando o type do usuário
  void navigateWithType(
    String route, {
    Map<String, String>? additionalParameters,
  }) {
    final parameters = <String, String>{};

    // Adicionar type do usuário
    final userType = UserService.currentUserType;
    if (userType != null && userType.isNotEmpty) {
      parameters['type'] = userType;
    }

    // Adicionar email do usuário
    if (UserService.currentUser?.email != null) {
      parameters['email'] = UserService.currentUser!.email;
    }

    // Adicionar parâmetros adicionais se fornecidos
    if (additionalParameters != null) {
      parameters.addAll(additionalParameters);
    }

    Get.toNamed(route, parameters: parameters);
  }

  /// Navega para uma rota substituindo a atual, preservando o type
  void navigateReplaceWithType(
    String route, {
    Map<String, String>? additionalParameters,
  }) {
    final parameters = <String, String>{};

    // Adicionar type do usuário
    final userType = UserService.currentUserType;
    if (userType != null && userType.isNotEmpty) {
      parameters['type'] = userType;
    }

    // Adicionar email do usuário
    if (UserService.currentUser?.email != null) {
      parameters['email'] = UserService.currentUser!.email;
    }

    // Adicionar parâmetros adicionais se fornecidos
    if (additionalParameters != null) {
      parameters.addAll(additionalParameters);
    }

    Get.offNamed(route, parameters: parameters);
  }

  /// Navega para uma rota limpando toda a pilha, preservando o type
  void navigateClearWithType(
    String route, {
    Map<String, String>? additionalParameters,
  }) {
    final parameters = <String, String>{};

    // Adicionar type do usuário
    final userType = UserService.currentUserType;
    if (userType != null && userType.isNotEmpty) {
      parameters['type'] = userType;
    }

    // Adicionar email do usuário
    if (UserService.currentUser?.email != null) {
      parameters['email'] = UserService.currentUser!.email;
    }

    // Adicionar parâmetros adicionais se fornecidos
    if (additionalParameters != null) {
      parameters.addAll(additionalParameters);
    }

    Get.offAllNamed(route, parameters: parameters);
  }
}
