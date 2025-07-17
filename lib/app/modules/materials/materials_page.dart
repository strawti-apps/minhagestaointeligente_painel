import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/navbar/navbar_desktop_widget.dart';
import '../../shared/navbar/navbar_mobile_widget.dart';
import 'materials_controller.dart';
import 'widgets/material_create_edit_widget.dart';
import 'widgets/material_header_widget.dart';
import 'widgets/material_search_field.dart';
import 'widgets/materials_list_widget.dart';

class MaterialsPage extends StatelessWidget {
  static const String route = '/materials';

  const MaterialsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NavbarMobileWidget(),
      body: Row(
        children: [
          const NavbarDesktopWidget(),
          Expanded(
            child: GetBuilder<MaterialsController>(
              builder: (controller) {
                switch (controller.selectedSubModule) {
                  case 'create_material':
                    return const MaterialCreateEditWidget(isEditing: false);
                  case 'edit_material':
                    return const MaterialCreateEditWidget(isEditing: true);
                  case 'list':
                  default:
                    return Column(
                      children: [
                        const MaterialHeaderWidget(),
                        const MaterialSearchField(),
                        Expanded(
                          child: MaterialsListWidget(controller: controller),
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