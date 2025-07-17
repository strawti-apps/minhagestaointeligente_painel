import 'package:get/get.dart';

import '../../shared/middlewares/auth_middleware.dart';
import 'users_controller.dart';
import 'users_page.dart';

class UsersRoutes {
  static const String usersPage = '/users';

  static List<GetPage> routes = [
    GetPage(
      name: usersPage,
      page: () => const UsersPage(),
      binding: BindingsBuilder(() {
        Get.put<UsersController>(UsersController());
      }),
      middlewares: [
        AdminMiddleware(),
      ],
    ),
  ];
} 