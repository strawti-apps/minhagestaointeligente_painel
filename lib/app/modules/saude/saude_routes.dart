import 'package:get/get.dart';

import 'saude_controller.dart';
import 'saude_page.dart';

final saudeRoutes = [
  GetPage(
    name: SaudePage.routeMedicos,
    page: () => const SaudePage(),
    binding: BindingsBuilder(() {
      Get.put(SaudeController());
    }),
  ),
  GetPage(
    name: SaudePage.routePlantoes,
    page: () => const SaudePage(),
    binding: BindingsBuilder(() {
      Get.put(SaudeController());
    }),
  ),
];
