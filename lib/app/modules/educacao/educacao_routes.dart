import 'package:get/get.dart';

import 'educacao_controller.dart';
import 'educacao_page.dart';

final educacaoRoutes = [
  GetPage(
    name: EducacaoPage.route,
    page: () => const EducacaoPage(),
    binding: BindingsBuilder(() {
      Get.put(EducacaoController());
    }),
  ),
];
