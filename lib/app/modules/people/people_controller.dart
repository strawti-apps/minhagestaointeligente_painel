import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../access/access_page.dart';
import '../classes/classes_page.dart';
import '../users/users_page.dart';
import 'widgets/people_option_card_widget.dart';

class PeopleController extends GetxController {
  List<Widget> options = [
    PeopleOptionCardWidget(
      title: 'Gerenciar Turmas',
      description: 'Organize e administre as turmas do sistema',
      icon: Icons.school,
      color: const Color(0xFF4CAF50),
      onTap: () {
        Get.toNamed(ClassesPage.route);
      },
    ),

    PeopleOptionCardWidget(
      title: 'Gerenciar Usuários',
      description: 'Cadastre e gerencie usuários do sistema',
      icon: Icons.person,
      color: const Color(0xFF2196F3),
      onTap: () {
        Get.toNamed(UsersPage.route);
      },
    ),

    PeopleOptionCardWidget(
      title: 'Gerenciar Acessos',
      description: 'Controle os acessos e permissões',
      icon: Icons.vpn_key,
      color: const Color(0xFFFF9800),
      onTap: () {
        Get.toNamed(AccessPage.route);
      },
    ),
  ];
}
