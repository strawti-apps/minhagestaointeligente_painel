import 'package:get/get.dart';

import '../../shared/middlewares/auth_middleware.dart';
import 'materials_controller.dart';
import 'materials_page.dart';

class MaterialsRoutes {
  static List<GetPage> get routes => [
    GetPage(
      name: MaterialsPage.route,
      page: () => const MaterialsPage(),
      binding: BindingsBuilder(() {
        Get.put<MaterialsController>(MaterialsController());
      }),
      middlewares: [
        AdminMiddleware(),
      ],
    ),
  ];
} 