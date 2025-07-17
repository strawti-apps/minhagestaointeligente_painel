import 'package:get/get.dart';

import '../../shared/middlewares/auth_middleware.dart';
import 'contents_controller.dart';
import 'contents_page.dart';

class ContentsRoutes {
  static List<GetPage> get routes => [
    GetPage(
      name: ContentsPage.route,
      page: () => const ContentsPage(),
      binding: BindingsBuilder(() {
        Get.put<ContentsController>(ContentsController());
      }),
      middlewares: [
        AdminMiddleware(),
      ],
    ),
  ];
} 