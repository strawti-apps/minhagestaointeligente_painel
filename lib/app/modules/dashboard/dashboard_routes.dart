import 'package:get/get.dart';

import '../../shared/navbar/navbar_navigation_controller.dart';
import 'dashboard_controller.dart';
import 'dashboard_page.dart';

class DashboardRoutes {
  static List<GetPage> routes = [
    GetPage(
      name: DashboardPage.route,
      page: () => const DashboardPage(),
      binding: BindingsBuilder(() {
        Get.put(DashboardController());
        Get.put(NavbarNavigationController());
      }),
    ),
  ];
}
