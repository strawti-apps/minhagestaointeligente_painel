import 'package:get/get.dart';

import '../../shared/middlewares/auth_middleware.dart';
import 'people_controller.dart';
import 'people_page.dart';

class PeopleRoutes {
  static List<GetPage> get routes => [
    GetPage(
      name: PeoplePage.route,
      page: () => const PeoplePage(),
      binding: BindingsBuilder(() {
        Get.put<PeopleController>(PeopleController());
      }),
      middlewares: [
        AdminMiddleware(),
      ],
    ),
  ];
} 