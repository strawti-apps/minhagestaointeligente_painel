import 'package:get/get.dart';

import 'notifications_controller.dart';
import 'notifications_page.dart';

final notificationsRoutes = [
  GetPage(
    name: NotificationsPage.route,
    page: () => const NotificationsPage(),
    binding: BindingsBuilder(() {
      Get.put(NotificationsController());
    }),
  ),
];
