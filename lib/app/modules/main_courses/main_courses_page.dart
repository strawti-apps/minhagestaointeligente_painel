import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/navbar/navbar_desktop_widget.dart';
import '../../shared/navbar/navbar_mobile_widget.dart';
import 'main_courses_controller.dart';
import 'widgets/main_course_create_edit_widget.dart';
import 'widgets/main_course_header_widget.dart';
import 'widgets/main_course_search_field.dart';
import 'widgets/main_courses_list_widget.dart';

class MainCoursesPage extends StatelessWidget {
  static const String route = '/main-courses';

  const MainCoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NavbarMobileWidget(),
      body: Row(
        children: [
          const NavbarDesktopWidget(),
          Expanded(
            child: GetBuilder<MainCoursesController>(
              builder: (controller) {
                switch (controller.selectedSubModule) {
                  case 'create_course':
                    return const MainCourseCreateEditWidget(isEditing: false);
                  case 'edit_course':
                    return const MainCourseCreateEditWidget(isEditing: true);
                  case 'list':
                  default:
                    return Column(
                      children: [
                        const MainCourseHeaderWidget(),
                        const MainCourseSearchField(),
                        Expanded(
                          child: MainCoursesListWidget(controller: controller),
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
