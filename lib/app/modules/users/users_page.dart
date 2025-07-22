import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/navbar/navbar_desktop_widget.dart';
import 'users_controller.dart';
import 'widgets/users_create_widget.dart';
import 'widgets/users_header_widget.dart';
import 'widgets/users_list_widget.dart';
import 'widgets/users_search_field.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  static const String route = '/users';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const NavbarDesktopWidget(),
          Expanded(
            child: GetBuilder<UsersController>(
              builder: (controller) {
                switch (controller.selectedSubModule) {
                  case 'create_user':
                    return const UsersCreateWidget();
                  case 'users_list':
                  default:
                    return Column(
                      children: [
                        const UsersHeaderWidget(),
                        const UsersSearchField(),
                        Expanded(
                          child:
                              controller.isLoading
                                  ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                  : UsersListWidget(controller: controller),
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
