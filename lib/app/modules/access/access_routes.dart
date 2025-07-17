import 'package:get/get.dart';

import '../../shared/middlewares/auth_middleware.dart';
import 'access_controller.dart';
import 'access_page.dart';

class AccessRoutes {
  static const String access = '/access';

  static List<GetPage> get routes => [
    GetPage(
      name: AccessPage.route,
      page: () => const AccessPage(),
      binding: BindingsBuilder(() {
        Get.put<AccessController>(AccessController());
      }),
      middlewares: [
        AdminMiddleware(),
      ],
    ),
  ];
} 