import 'package:get/get.dart';

import 'feed_controller.dart';
import 'feed_page.dart';

final feedRoutes = [
  GetPage(
    name: FeedPage.route,
    page: () => const FeedPage(),
    binding: BindingsBuilder(() {
      Get.put(FeedController());
    }),
  ),
];
