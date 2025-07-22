import 'package:get/get.dart';

import 'module_medico/pages/consultas_page.dart';
import 'module_medico/pages/pacientes_page.dart';
import 'module_medico/pages/receitas_page.dart';
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
  GetPage(name: PacientesPage.route, page: () => const PacientesPage()),
  GetPage(name: ReceitasPage.route, page: () => const ReceitasPage()),
  GetPage(name: ConsultasPage.route, page: () => const ConsultasPage()),
];
