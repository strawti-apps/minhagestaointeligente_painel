import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/navbar/navbar_desktop_widget.dart';
import 'notifications_controller.dart';
import 'widgets/notifications_list_widget.dart';

class NotificationsPage extends StatelessWidget {
  static const String route = '/notificacoes';
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const NavbarDesktopWidget(),
          Expanded(
            child: GetBuilder<NotificationsController>(
              builder: (controller) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: const [
                          Text(
                            'Notificações',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(child: NotificationsListWidget()),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
