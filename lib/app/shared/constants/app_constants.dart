import '../../modules/access/access_page.dart';
import '../../modules/contents/contents_page.dart';
import '../../modules/materials/materials_page.dart';
import '../../modules/people/people_page.dart';
import '../../modules/quizzes/quizzes_page.dart';
import '../../modules/users/users_page.dart';

class AppConstants {
  static const String appName = 'Minha Gestão Inteligente';

  // Supabase
  static const String supabaseUrl = 'https://mtnwmpffexoriffidhxe.supabase.co';
  static const String supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im10bndtcGZmZXhvcmlmZmlkaHhlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDcxOTcwNjYsImV4cCI6MjA2Mjc3MzA2Nn0.SMhehsAd3CbFOOXq-yNsiMmJX-Gy0ZPzJIVkxJfUUnE';

  // User roles
  static const String studentRole = 'student';
  static const String teacherRole = 'teacher';
  static const String adminRole = 'admin';

  // Permissões por role
  static const Map<String, List<String>> rolePermissions = {
    adminRole: [
      'dashboard',
      'courses',
      'materials',
      'quizzes',
      'contents',
      'people',
      'create_course',
      'edit_course',
      'delete_course',
      'create_user',
      'edit_user',
      'delete_user',
      'create_material',
      'edit_material',
      'delete_material',
      'create_quiz',
      'edit_quiz',
      'delete_quiz',
      'create_content',
      'edit_content',
      'delete_content',
    ],
    teacherRole: ['dashboard', 'courses', 'view_courses'],
    studentRole: ['dashboard', 'courses', 'view_courses'],
  };

  // Rotas que precisam de permissão admin
  static const List<String> adminOnlyRoutes = [
    MaterialsPage.route,
    QuizzesPage.route,
    ContentsPage.route,
    PeoplePage.route,
    UsersPage.route,
    AccessPage.route,
  ];

  // Método para verificar se usuário tem permissão
  static bool hasPermission(String userRole, String permission) {
    final permissions = rolePermissions[userRole.toLowerCase()];
    if (permissions == null) return false;
    return permissions.contains(permission);
  }

  // Método para verificar se usuário pode acessar rota
  static bool canAccessRoute(String userRole, String route) {
    // Administradores têm acesso a tudo
    if (userRole.toLowerCase() == adminRole) return true;

    // Verificar se é uma rota restrita
    return !adminOnlyRoutes.contains(route);
  }
}
