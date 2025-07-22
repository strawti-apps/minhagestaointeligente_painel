import 'package:get/get.dart';

import '../../shared/navbar/navbar_navigation_controller.dart';
import '../models/user_model.dart';

class UserService {
  static final UserService _instance = UserService._internal();

  factory UserService() {
    return _instance;
  }

  UserService._internal();
  UserModel? internalCurrentUser;
  String? _currentUserType;

  static UserModel? get currentUser => UserService().internalCurrentUser;
  static String? get currentUserType => UserService()._currentUserType;

  static bool get loggedIn => UserService.currentUser != null;

  // Mock: setar usuário
  static void setMockUser(UserModel user) {
    UserService().internalCurrentUser = user;
    UserService()._currentUserType = user.role;
    _notifyNavbarUpdate();
  }

  // Mock: limpar usuário
  static void clearUser() {
    UserService().internalCurrentUser = null;
    UserService()._currentUserType = null;
    _notifyNavbarUpdate();
  }

  // Definir tipo de usuário
  static void setUserType(String type) {
    UserService()._currentUserType = type;
    _notifyNavbarUpdate();
  }

  static void _notifyNavbarUpdate() {
    try {
      final navController = Get.find<NavbarNavigationController>();
      navController.updateNavbarForRole();
    } catch (e) {
      // Navbar controller pode não estar registrado ainda
    }
  }
}
