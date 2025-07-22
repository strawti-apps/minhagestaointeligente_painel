import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../infra/models/user_model.dart';
import '../../infra/services/user_service.dart';

class DashboardController extends GetxController {
  final box = GetStorage();
  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  @override
  void onInit() {
    super.onInit();
    _initializeUser();
  }

  void _initializeUser() {
    // Primeiro, tenta usar o usuário do UserService
    if (UserService.currentUser != null) {
      _currentUser = UserService.currentUser;
      update();
      return;
    }

    // Se não houver usuário no UserService, cria um mock baseado nos parâmetros
    final params = Get.parameters;
    String? role = params['type'];
    String? email = params['email'];
    if (role == null || email == null) {
      role = box.read('user_type') ?? 'admin';
      email = box.read('user_email') ?? 'admin@strawti.com';
    }

    String firstName = 'Admin';
    if (role == 'medico') firstName = 'Médico';
    if (role == 'professor') firstName = 'Professor';

    _currentUser = UserModel(
      id: 1,
      authUserId: 'mocked',
      firstName: firstName,
      lastName: null,
      email: email,
      role: role,
      createdAt: DateTime.now(),
      mustChangePassword: false,
    );

    // Salva no UserService para uso futuro
    UserService.setMockUser(_currentUser!);
    update();
  }
}
