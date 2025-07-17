import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minha_gestao_inteligente_painel/app/modules/auth/pages/login_email_page.dart';

import '../../shared/widgets/app_logo.dart';
import '../../themes/app_colors.dart';

class NavbarDesktopWidget extends StatefulWidget {
  const NavbarDesktopWidget({super.key});

  @override
  State<NavbarDesktopWidget> createState() => _NavbarDesktopWidgetState();
}

class _NavbarDesktopWidgetState extends State<NavbarDesktopWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Mock: defina o tipo do usuário aqui para testar ('professor', 'medico', 'admin')
    final String userType = Get.parameters['type'] ?? 'admin';
    final menuItems = _getMenuItems(userType);

    return Container(
      width: 280,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: AppLogo(size: 100)),
              const SizedBox(height: 12),
              // Menu
              Expanded(
                child: Column(
                  children: [
                    for (int i = 0; i < menuItems.length; i++)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              setState(() {
                                selectedIndex = i;
                              });
                            },
                            child: Container(
                              decoration:
                                  selectedIndex == i
                                      ? BoxDecoration(
                                        color: const Color(0xFFEAF1FB),
                                        borderRadius: BorderRadius.circular(10),
                                      )
                                      : null,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    menuItems[i].icon,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    menuItems[i].label,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight:
                                          selectedIndex == i
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              // Usuário mockado e botão sair
              const SizedBox(height: 24),
              Divider(),
              const SizedBox(height: 12),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.textPrimary.withValues(
                      alpha: 0.4,
                    ),
                    child: Text(
                      userType.substring(0, 1).toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      userType[0].toUpperCase() + userType.substring(1),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.logout,
                      size: 20,
                      color: Colors.black,
                    ),
                    onPressed: () => Get.offAllNamed(LoginEmailPage.route),
                    tooltip: 'Sair',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SidebarMenuItem {
  final String label;
  final IconData icon;
  const _SidebarMenuItem(this.label, this.icon);
}

List<_SidebarMenuItem> _getMenuItems(String type) {
  switch (type) {
    case 'professor':
      return const [
        _SidebarMenuItem('Dashboard', Icons.dashboard),
        _SidebarMenuItem('Alunos', Icons.people),
        _SidebarMenuItem('Frequência do Aluno', Icons.check_circle_outline),
        _SidebarMenuItem('Boletins', Icons.assignment),
        _SidebarMenuItem('Material Escolar', Icons.menu_book),
      ];
    case 'medico':
      return const [
        _SidebarMenuItem('Dashboard', Icons.dashboard),
        _SidebarMenuItem('Pacientes', Icons.people),
        _SidebarMenuItem('Receitas', Icons.receipt_long),
        _SidebarMenuItem('Consultas', Icons.calendar_today),
      ];
    default:
      return const [
        _SidebarMenuItem('Dashboard', Icons.dashboard),
        _SidebarMenuItem('Saúde', Icons.medical_services),
        _SidebarMenuItem('Feed', Icons.feed),
        _SidebarMenuItem('Educação', Icons.school),
        _SidebarMenuItem('Notificações', Icons.notifications),
      ];
  }
}
