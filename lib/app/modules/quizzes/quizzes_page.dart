import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/navbar/navbar_desktop_widget.dart';
import '../../shared/navbar/navbar_mobile_widget.dart';
import 'quizzes_controller.dart';
import 'widgets/quiz_create_edit_widget.dart';
import 'widgets/quiz_header_widget.dart';
import 'widgets/quiz_search_field.dart';
import 'widgets/quizzes_list_widget.dart';

class QuizzesPage extends StatelessWidget {
  static const String route = '/quizzes';

  const QuizzesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NavbarMobileWidget(),
      body: Row(
        children: [
          const NavbarDesktopWidget(),
          Expanded(
            child: GetBuilder<QuizzesController>(
              builder: (controller) {
                switch (controller.selectedSubModule) {
                  case 'create_quiz':
                    return const QuizCreateEditWidget(isEditing: false);
                  case 'edit_quiz':
                    return const QuizCreateEditWidget(isEditing: true);
                  case 'list':
                  default:
                    return Column(
                      children: [
                        const QuizHeaderWidget(),
                        const QuizSearchField(),
                        Expanded(
                          child: QuizzesListWidget(controller: controller),
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