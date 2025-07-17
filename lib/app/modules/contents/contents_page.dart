import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/navbar/navbar_desktop_widget.dart';
import '../../shared/navbar/navbar_mobile_widget.dart';
import 'widgets/content_create_edit_widget.dart';
import 'widgets/content_header_widget.dart';
import 'widgets/content_list_widget.dart';
import 'widgets/content_search_widget.dart';
import 'contents_controller.dart';

class ContentsPage extends StatelessWidget {
  static const String route = '/contents';

  const ContentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NavbarMobileWidget(),
      body: Row(
        children: [
          const NavbarDesktopWidget(),
          Expanded(
            child: GetBuilder<ContentsController>(
              builder: (controller) {
                switch (controller.selectedSubModule) {
                  case 'create_content':
                    return const ContentCreateEditWidget(isEditing: false);
                  case 'edit_content':
                    return const ContentCreateEditWidget(isEditing: true);
                  case 'list':
                  default:
                    return Column(
                      children: [
                        const ContentHeaderWidget(),
                        const ContentSearchField(),
                        Expanded(
                          child: ContentListWidget(controller: controller),
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
