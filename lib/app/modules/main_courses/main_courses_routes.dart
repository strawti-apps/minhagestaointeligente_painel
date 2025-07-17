import 'package:get/get.dart';

import 'main_courses_controller.dart';
import 'main_courses_page.dart';

class MainCoursesRoutes {
  static List<GetPage> get routes => [
    GetPage(
      name: MainCoursesPage.route,
      page: () => const MainCoursesPage(),
      binding: BindingsBuilder(() {
        Get.put<MainCoursesController>(MainCoursesController());
      }),
    ),
  ];
}
