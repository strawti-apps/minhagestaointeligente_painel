import 'package:get/get.dart';

import 'educacao_controller.dart';
import 'educacao_page.dart';
import 'module_professor/pages/alunos_page.dart';
import 'module_professor/pages/boletins_page.dart';
import 'module_professor/pages/frequencia_aluno_page.dart';
import 'module_professor/pages/material_escolar_page.dart';

final educacaoRoutes = [
  GetPage(
    name: EducacaoPage.route,
    page: () => const EducacaoPage(),
    binding: BindingsBuilder(() {
      Get.put(EducacaoController());
    }),
  ),
  GetPage(name: AlunosPage.route, page: () => const AlunosPage()),
  GetPage(name: BoletinsPage.route, page: () => const BoletinsPage()),
  GetPage(
    name: FrequenciaAlunoPage.route,
    page: () => const FrequenciaAlunoPage(),
  ),
  GetPage(
    name: MaterialEscolarPage.route,
    page: () => const MaterialEscolarPage(),
  ),
];
