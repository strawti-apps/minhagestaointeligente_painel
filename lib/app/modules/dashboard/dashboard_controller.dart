import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../infra/models/user_model.dart';

class DashboardController extends GetxController {
  final box = GetStorage();
  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  @override
  void onInit() {
    super.onInit();
    _mockUser();
  }

  void _mockUser() {
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
    update();
  }
}
