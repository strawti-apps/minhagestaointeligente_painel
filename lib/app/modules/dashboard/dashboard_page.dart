import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/navbar/navbar_desktop_widget.dart';
import '../../shared/navbar/navbar_mobile_widget.dart';
import 'dashboard_controller.dart';
import 'widgets/dashboard_role_router_widget.dart';

class DashboardPage extends StatelessWidget {
  static const String route = '/dashboard';

  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 700;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isMobile) const NavbarDesktopWidget(),
              Expanded(
                child: GetBuilder<DashboardController>(
                  builder: (controller) {
                    if (controller.currentUser == null) {
                      return const Center(
                        child: Text('Usuário não encontrado'),
                      );
                    }

                    return DashboardRoleRouterWidget(
                      controller: controller,
                      isMobile: isMobile,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: NavbarMobileWidget(),
    );
  }
}
