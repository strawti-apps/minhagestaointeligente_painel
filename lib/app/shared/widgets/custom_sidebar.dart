import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minha_gestao_inteligente_painel/app/modules/auth/pages/login_email_page.dart';

import '../../modules/dashboard/dashboard_controller.dart';
import '../../themes/app_colors.dart';
import '../utils/formatters.dart';

class CustomSidebar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomSidebar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        final user = controller.currentUser;
        final role = user?.role ?? 'admin';
        final displayName =
            user != null
                ? '${user.firstName} ${user.lastName ?? ''}'
                : 'Usuário';
        final initials =
            user != null
                ? Formatters.getInitials(
                  '${user.firstName} ${user.lastName ?? ''}',
                )
                : 'U';

        // Itens do menu por tipo de usuário
        List<_SidebarItem> menuItems = [];
        if (role == 'admin') {
          menuItems = [
            _SidebarItem('Saúde', Icons.local_hospital),
            _SidebarItem('Gerenciar hospitais', Icons.apartment),
            _SidebarItem('Gerenciar médicos', Icons.medical_services),
            _SidebarItem('Gerenciar plantões', Icons.schedule),
            _SidebarItem('Feed', Icons.dynamic_feed),
            _SidebarItem('Gerenciar itens do feed', Icons.edit_note),
            _SidebarItem('Educação', Icons.school),
            _SidebarItem('Gerenciar escolas/creches', Icons.location_city),
            _SidebarItem('Listagem de professores', Icons.person_outline),
            _SidebarItem('Listagem de alunos', Icons.people_outline),
            _SidebarItem('Notificações', Icons.notifications),
            _SidebarItem('Listagem de notificações', Icons.list_alt),
          ];
        } else if (role == 'medico') {
          menuItems = [
            _SidebarItem('Pacientes', Icons.people),
            _SidebarItem('Receitas', Icons.receipt_long),
            _SidebarItem('Consultas', Icons.event_note), // Corrigido ícone
          ];
        } else if (role == 'professor') {
          menuItems = [
            _SidebarItem('Alunos', Icons.people),
            _SidebarItem('Frequência do Aluno', Icons.checklist),
            _SidebarItem('Boletins', Icons.assignment),
            _SidebarItem('Material Escolar', Icons.menu_book),
          ];
        }

        return Container(
          width: 260,
          color: Colors.white,
          child: Column(
            children: [
              const SizedBox(height: 24),
              // Logo e nome do sistema
              Row(
                children: const [
                  SizedBox(width: 16),
                  Icon(
                    Icons.add_box_rounded,
                    size: 32,
                    color: AppColors.primaryDark,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'FillerBase',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Menu
              ...menuItems.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                final selected = index == selectedIndex;
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 2,
                  ),
                  child: ListTile(
                    leading: Icon(
                      item.icon,
                      color: selected ? AppColors.primary : Colors.grey[600],
                    ),
                    title: Text(
                      item.title,
                      style: TextStyle(
                        color: selected ? AppColors.primary : Colors.grey[800],
                        fontWeight:
                            selected ? FontWeight.bold : FontWeight.normal,
                        fontSize: 15,
                      ),
                    ),
                    selected: selected,
                    selectedTileColor: AppColors.primary.withOpacity(0.08),
                    onTap: () => onItemSelected(index),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                );
              }),
              const Spacer(),
              // Rodapé com usuário
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primaryDark,
                      child: Text(
                        initials ?? 'U',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      displayName,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      role == 'admin'
                          ? 'Administrador'
                          : (role == 'medico' ? 'Médico' : 'Professor'),
                      style: const TextStyle(fontSize: 12),
                    ),
                    trailing: const Icon(
                      Icons.logout,
                      size: 22,
                      color: Colors.grey,
                    ),
                    onTap: () => Get.offAllNamed(LoginEmailPage.route),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }
}

class _SidebarItem {
  final String title;
  final IconData icon;
  _SidebarItem(this.title, this.icon);
}
