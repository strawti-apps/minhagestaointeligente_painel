import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/navbar/navbar_desktop_widget.dart';
import 'access_controller.dart';
import 'widgets/access_create_widget.dart';
import 'widgets/access_header_widget.dart';
import 'widgets/access_list_widget.dart';
import 'widgets/access_search_field.dart';

class AccessPage extends StatelessWidget {
  static const String route = '/access';

  const AccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const NavbarDesktopWidget(),
          Expanded(
            child: GetBuilder<AccessController>(
              builder: (controller) {
                switch (controller.selectedSubModule) {
                  case 'create_access':
                    return const AccessCreateWidget();
                  case 'list':
                  default:
                    return Column(
                      children: [
                        const AccessHeaderWidget(),
                        const AccessSearchField(),
                        Expanded(
                          child: AccessListWidget(controller: controller),
                        ),
                      ],
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
