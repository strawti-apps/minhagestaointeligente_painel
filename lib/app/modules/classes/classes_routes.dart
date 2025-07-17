import 'package:get/get.dart';

import 'classes_controller.dart';
import 'classes_page.dart';

class ClassesRoutes {
  static List<GetPage> get routes => [
    GetPage(
      name: ClassesPage.route,
      page: () => const ClassesPage(),
      binding: BindingsBuilder(() {
        Get.put<ClassesController>(ClassesController());
      }),
    ),
  ];
} 