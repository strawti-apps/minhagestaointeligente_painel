import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../shared/widgets/app_logo.dart';
import 'splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static const route = '/splash';

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder: (context) {
        return const Scaffold(
          body: Center(child: AppLogo(size: 250)),
        );
      },
    );
  }
} 