import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/navbar/navbar_desktop_widget.dart';
import '../../shared/navbar/navbar_mobile_widget.dart';
import 'people_controller.dart';
import 'widgets/people_header_widget.dart';
import 'widgets/people_options_widget.dart';

class PeoplePage extends StatelessWidget {
  const PeoplePage({super.key});

  static const String route = '/people';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NavbarMobileWidget(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NavbarDesktopWidget(),
          Expanded(
            child: GetBuilder<PeopleController>(
              builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const PeopleHeaderWidget(),
                    Expanded(
                      child: PeopleOptionsWidget(controller: controller),
                    ),
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
