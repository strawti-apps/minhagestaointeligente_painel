import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infra/services/user_service.dart';
import '../../modules/auth/pages/login_email_page.dart';
import '../../modules/educacao/module_professor/pages/alunos_page.dart';
import '../../modules/educacao/module_professor/pages/boletins_page.dart';
import '../../modules/educacao/module_professor/pages/frequencia_aluno_page.dart';
import '../../modules/educacao/module_professor/pages/material_escolar_page.dart';
import '../../modules/saude/module_medico/pages/consultas_page.dart';
import '../../modules/saude/module_medico/pages/pacientes_page.dart';
import '../../modules/saude/module_medico/pages/receitas_page.dart';
import '../../modules/saude/saude_page.dart';
import '../../shared/widgets/app_logo.dart';
import '../../themes/app_colors.dart';

class NavbarDesktopWidget extends StatefulWidget {
  static const double _mobileBreakpoint = 768; // Breakpoint consistente

  const NavbarDesktopWidget({super.key});

  @override
  State<NavbarDesktopWidget> createState() => _NavbarDesktopWidgetState();
}

class _NavbarDesktopWidgetState extends State<NavbarDesktopWidget> {
  @override
  Widget build(BuildContext context) {
    final String userType =
        UserService.currentUserType ?? (Get.parameters['type'] ?? '');
    final menuItems = _getMenuItems(userType);
    final String currentRoute = Get.currentRoute;

    int selectedIndex = menuItems.indexWhere(
      (item) => currentRoute.startsWith(item.route),
    );
    if (selectedIndex == -1) selectedIndex = 0;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Só mostra a navbar desktop se a tela for maior ou igual ao breakpoint
        if (constraints.maxWidth < NavbarDesktopWidget._mobileBreakpoint) {
          return const SizedBox.shrink();
        }

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
                  Center(child: AppLogo()),
                  const SizedBox(height: 12),
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
                                  if (Get.currentRoute != menuItems[i].route) {
                                    // Preservar o type na navegação
                                    final parameters = <String, String>{};
                                    if (userType.isNotEmpty) {
                                      parameters['type'] = userType;
                                    }
                                    if (UserService.currentUser?.email !=
                                        null) {
                                      parameters['email'] =
                                          UserService.currentUser!.email;
                                    }
                                    Get.toNamed(
                                      menuItems[i].route,
                                      parameters: parameters,
                                    );
                                  }
                                },
                                child: Container(
                                  decoration:
                                      selectedIndex == i
                                          ? BoxDecoration(
                                            color: const Color(0xFFEAF1FB),
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
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
                  const SizedBox(height: 24),
                  Divider(),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.textPrimary.withValues(
                          alpha: 0.4,
                        ),
                        child: Center(
                          child: Text(
                            userType.isNotEmpty
                                ? userType.substring(0, 1).toUpperCase()
                                : '?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          userType.isNotEmpty
                              ? userType[0].toUpperCase() +
                                  userType.substring(1)
                              : 'Usuário',
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
                        onPressed: () {
                          UserService.clearUser();
                          Get.offAllNamed(LoginEmailPage.route);
                        },
                        tooltip: 'Sair',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SidebarMenuItem {
  final String label;
  final IconData icon;
  final String route;
  const _SidebarMenuItem(this.label, this.icon, this.route);
}

List<_SidebarMenuItem> _getMenuItems(String type) {
  switch (type) {
    case 'professor':
      return [
        const _SidebarMenuItem('Dashboard', Icons.dashboard, '/dashboard'),
        _SidebarMenuItem('Alunos', Icons.people, AlunosPage.route),
        _SidebarMenuItem(
          'Frequência do Aluno',
          Icons.check_circle_outline,
          FrequenciaAlunoPage.route,
        ),
        _SidebarMenuItem('Boletins', Icons.assignment, BoletinsPage.route),
        _SidebarMenuItem(
          'Material Escolar',
          Icons.menu_book,
          MaterialEscolarPage.route,
        ),
      ];
    case 'medico':
      return [
        const _SidebarMenuItem('Dashboard', Icons.dashboard, '/dashboard'),
        _SidebarMenuItem('Pacientes', Icons.people, PacientesPage.route),
        _SidebarMenuItem('Receitas', Icons.receipt_long, ReceitasPage.route),
        _SidebarMenuItem(
          'Consultas',
          Icons.calendar_today,
          ConsultasPage.route,
        ),
      ];
    default:
      return [
        const _SidebarMenuItem('Dashboard', Icons.dashboard, '/dashboard'),
        _SidebarMenuItem(
          'Saúde',
          Icons.medical_services,
          SaudePage.routeMedicos,
        ),
        const _SidebarMenuItem('Feed', Icons.feed, '/feed'),
        const _SidebarMenuItem('Educação', Icons.school, '/escolas'),
        const _SidebarMenuItem(
          'Notificações',
          Icons.notifications,
          '/notificacoes',
        ),
      ];
  }
}
