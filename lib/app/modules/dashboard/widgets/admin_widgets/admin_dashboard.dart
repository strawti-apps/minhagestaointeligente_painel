import 'package:flutter/material.dart';

import '../../controllers/admin_dashboard_controller.dart';
import 'dashboard_stats_cards.dart';
// import 'recent_activities_widget.dart';

class AdminDashboard extends StatelessWidget {
  final AdminDashboardController controller;
  final bool isMobile;

  const AdminDashboard({
    super.key,
    required this.controller,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 16 : 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título da dashboard
          // _DashboardHeader(isMobile: isMobile),
          SizedBox(height: isMobile ? 16 : 24),

          // Cards de estatísticas
          DashboardStatsCards(controller: controller, isMobile: isMobile),

          SizedBox(height: isMobile ? 24 : 32),

          // // Seção inferior responsiva
          // LayoutBuilder(
          //   builder: (context, constraints) {
          //     if (constraints.maxWidth < 768) {
          //       return _DashboardMobileLayout(controller: controller);
          //     } else {
          //       return _DashboardDesktopLayout(controller: controller);
          //     }
          //   },
          // ),
        ],
      ),
    );
  }
}

// class _DashboardDesktopLayout extends StatelessWidget {
//   final AdminDashboardController controller;

//   const _DashboardDesktopLayout({required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(
//           flex: 2,
//           child: RecentActivitiesWidget(
//             controller: controller,
//             isMobile: false,
//           ),
//         ),
//         const SizedBox(width: 32),
//         Expanded(flex: 1, child: _QuickActionsWidget(isMobile: false)),
//       ],
//     );
//   }
// }

// class _DashboardMobileLayout extends StatelessWidget {
//   final AdminDashboardController controller;

//   const _DashboardMobileLayout({required this.controller});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: [
// //         // RecentActivitiesWidget(
// //         //   controller: controller,
// //         //   isMobile: true,
// //         // ),
// //         const SizedBox(height: 16),
// //         _QuickActionsWidget(isMobile: true),
// //       ],
// //     );
// //   }
// // }

// class _DashboardHeader extends StatelessWidget {
//   final bool isMobile;

//   const _DashboardHeader({required this.isMobile});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Icon(
//           Icons.dashboard,
//           size: isMobile ? 24 : 28,
//           color: Colors.grey.shade700,
//         ),
//         SizedBox(width: isMobile ? 8 : 12),
//         Text(
//           'Dashboard Administrativo',
//           style: TextStyle(
//             fontSize: isMobile ? 20 : 28,
//             fontWeight: FontWeight.bold,
//             color: Colors.grey.shade800,
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _QuickActionsWidget extends StatelessWidget {
//   final bool isMobile;

//   const _QuickActionsWidget({required this.isMobile});

//   @override
//   Widget build(BuildContext context) {
//     final currentUser = UserService.currentUser;

//     if (currentUser == null) {
//       return const SizedBox.shrink();
//     }

//     return Container(
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.04),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Ações Rápidas',
//             style: TextStyle(
//               fontSize: isMobile ? 16 : 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey.shade800,
//             ),
//           ),
//           SizedBox(height: isMobile ? 12 : 16),

//           if (AppConstants.hasPermission(currentUser.role, 'create_user'))
//             _QuickActionButton(
//               icon: Icons.person_add,
//               label: 'Criar Usuário',
//               color: Colors.blue,
//               onTap: () {
//                 // TODO: Implementar navegação para criar usuário
//               },
//             ),

//           if (AppConstants.hasPermission(currentUser.role, 'create_user'))
//             const SizedBox(height: 8),

//           if (AppConstants.hasPermission(currentUser.role, 'create_course'))
//             _QuickActionButton(
//               icon: Icons.library_books,
//               label: 'Novo Curso',
//               color: Colors.green,
//               onTap: () {
//                 // TODO: Implementar navegação para criar curso
//               },
//             ),

//           if (AppConstants.hasPermission(currentUser.role, 'create_course'))
//             const SizedBox(height: 8),

//           if (AppConstants.hasPermission(currentUser.role, 'create_quiz'))
//             _QuickActionButton(
//               icon: Icons.quiz,
//               label: 'Novo Quiz',
//               color: Colors.purple,
//               onTap: () {
//                 // TODO: Implementar navegação para criar quiz
//               },
//             ),
//         ],
//       ),
//     );
//   }
// }

// class _QuickActionButton extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final Color color;
//   final VoidCallback onTap;

//   const _QuickActionButton({
//     required this.icon,
//     required this.label,
//     required this.color,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(8),
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(color: Colors.grey.shade200),
//         ),
//         child: Row(
//           children: [
//             CircleAvatar(
//               backgroundColor: color.withValues(alpha: 0.1),
//               radius: 16,
//               child: Icon(icon, size: 16, color: color),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Text(
//                 label,
//                 style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//             Icon(
//               Icons.arrow_forward_ios,
//               size: 12,
//               color: Colors.grey.shade400,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
