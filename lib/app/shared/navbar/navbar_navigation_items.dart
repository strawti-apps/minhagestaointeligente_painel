import 'package:flutter/material.dart';

import '../../infra/services/user_service.dart';
import '../../modules/dashboard/dashboard_page.dart';
import '../constants/app_constants.dart';

// Itens para PROFESSOR
const List<SidebarNavItem> _professorNavItems = [
  SidebarNavItem(icon: Icons.people, label: 'Alunos', route: '/alunos'),
  SidebarNavItem(
    icon: Icons.check_circle_outline,
    label: 'Frequência do Aluno',
    route: '/frequencia_aluno',
  ),
  SidebarNavItem(icon: Icons.assignment, label: 'Boletins', route: '/boletins'),
  SidebarNavItem(
    icon: Icons.menu_book,
    label: 'Material Escolar',
    route: '/material_escolar',
  ),
  SidebarNavItem(
    icon: Icons.dashboard,
    label: 'Dashboard',
    route: DashboardPage.route,
  ),
];

// Itens para MÉDICO
const List<SidebarNavItem> _medicoNavItems = [
  SidebarNavItem(icon: Icons.people, label: 'Pacientes', route: '/pacientes'),
  SidebarNavItem(
    icon: Icons.receipt_long,
    label: 'Receitas',
    route: '/receitas',
  ),
  SidebarNavItem(
    icon: Icons.calendar_today,
    label: 'Consultas',
    route: '/consultas',
  ),
  SidebarNavItem(
    icon: Icons.dashboard,
    label: 'Dashboard',
    route: DashboardPage.route,
  ),
];

// Itens para ADMIN/PAINEL GERAL
const List<SidebarNavItem> _adminNavItems = [
  SidebarNavItem(
    icon: Icons.local_hospital,
    label: 'Gerenciar Hospitais',
    route: '/hospitais',
  ),
  SidebarNavItem(
    icon: Icons.medical_services,
    label: 'Gerenciar Médicos',
    route: '/medicos',
  ),
  SidebarNavItem(
    icon: Icons.access_time,
    label: 'Gerenciar Plantões',
    route: '/plantoes',
  ),
  SidebarNavItem(icon: Icons.feed, label: 'Gerenciar Feed', route: '/feed'),
  SidebarNavItem(
    icon: Icons.school,
    label: 'Gerenciar Escolas/Creches',
    route: '/escolas',
  ),
  SidebarNavItem(
    icon: Icons.person,
    label: 'Listagem de Professores',
    route: '/professores',
  ),
  SidebarNavItem(
    icon: Icons.people,
    label: 'Listagem de Alunos',
    route: '/alunos_admin',
  ),
  SidebarNavItem(
    icon: Icons.notifications,
    label: 'Notificações',
    route: '/notificacoes',
  ),
  SidebarNavItem(
    icon: Icons.dashboard,
    label: 'Dashboard',
    route: DashboardPage.route,
  ),
];

class SidebarNavItem {
  final IconData icon;
  final String label;
  final String route;
  final List<String> requiredRoles;

  const SidebarNavItem({
    required this.icon,
    required this.label,
    required this.route,
    this.requiredRoles = const ['admin', 'teacher', 'student'],
  });
}

// Função para obter itens filtrados baseado no role do usuário
List<SidebarNavItem> get sidebarNavItems {
  final currentUser = UserService.currentUser;
  if (currentUser == null) {
    return [];
  }
  final userRole = currentUser.role.toLowerCase();
  if (userRole == 'professor' || userRole == 'teacher') {
    return _professorNavItems;
  } else if (userRole == 'medico') {
    return _medicoNavItems;
  } else {
    return _adminNavItems;
  }
}

// Função para verificar se usuário pode acessar uma rota específica
bool canAccessRoute(String route) {
  final currentUser = UserService.currentUser;
  if (currentUser == null) {
    return false;
  }
  return AppConstants.canAccessRoute(currentUser.role, route);
}
