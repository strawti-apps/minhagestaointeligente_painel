import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/navbar/navbar_desktop_widget.dart';
import '../../shared/navbar/navbar_mobile_widget.dart';
import 'classes_controller.dart';
import 'widgets/class_create_edit_widget.dart';
import 'widgets/class_header_widget.dart';
import 'widgets/class_search_field.dart';
import 'widgets/classes_list_widget.dart';

class ClassesPage extends StatelessWidget {
  static const String route = '/classes';

  const ClassesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NavbarMobileWidget(),
      body: Row(
        children: [
          const NavbarDesktopWidget(),
          Expanded(
            child: GetBuilder<ClassesController>(
              builder: (controller) {
                switch (controller.selectedSubModule) {
                  case 'create_class':
                    return const ClassCreateEditWidget(isEditing: false);
                  case 'edit_class':
                    return const ClassCreateEditWidget(isEditing: true);
                  case 'list':
                  default:
                    return Column(
                      children: [
                        const ClassHeaderWidget(),
                        const ClassSearchField(),
                        Expanded(
                          child: ClassesListWidget(controller: controller),
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