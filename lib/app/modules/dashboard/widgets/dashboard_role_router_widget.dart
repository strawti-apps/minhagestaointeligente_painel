import 'package:flutter/material.dart';

import '../dashboard_controller.dart';
import 'admin_widgets/admin_dashboard_mock.dart';
import 'medico_dashboard_widget.dart';
import 'professor_dashboard_widget.dart';

class DashboardRoleRouterWidget extends StatelessWidget {
  final DashboardController controller;
  final bool isMobile;

  const DashboardRoleRouterWidget({
    super.key,
    required this.controller,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final type = controller.currentUser?.role;
    switch (type) {
      case 'admin':
        return AdminDashboardMockWidget(isMobile: isMobile);
      case 'medico':
        return MedicoDashboardWidget(isMobile: isMobile);
      case 'professor':
        return ProfessorDashboardWidget(isMobile: isMobile);
      default:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.red.shade300),
              const SizedBox(height: 16),
              Text(
                'Tipo de acesso não reconhecido: $type',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
    }
  }
}
