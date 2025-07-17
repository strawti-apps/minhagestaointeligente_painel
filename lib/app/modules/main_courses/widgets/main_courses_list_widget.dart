import 'package:flutter/material.dart';

import '../../../shared/widgets/generic_grid_widget.dart';
import '../main_courses_controller.dart';
import 'main_course_card_widget.dart';

class MainCoursesListWidget extends StatelessWidget {
  final MainCoursesController controller;
  const MainCoursesListWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GenericGridWidget(
        items: controller.filteredMainCourses,
        itemBuilder: (course) {
          return MainCourseCardWidget(course: course, controller: controller);
        },
      ),
    );
  }
}
