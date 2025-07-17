import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/app_colors.dart';
import 'ternary_clean.dart';

class AppSnackbar {
  AppSnackbar._();

  static AppSnackbar get to => AppSnackbar._();

  final _defaultDuration = const Duration(seconds: 6);
  final _defaultBorderRadius = 8.0;

  final _defaultBoxShadows = [
    BoxShadow(
      color: const Color.fromARGB(255, 30, 0, 0).withValues(alpha: 0.2),
      offset: const Offset(0, 2),
      blurRadius: 4,
    ),
  ];

  void success(
    String message, {
    String? title,
    Widget? mainButton,
    bool success = true,
  }) {
    Get.rawSnackbar(
      maxWidth: ternaryClean(
        condition: Get.width <= 900,
        caseTrue: Get.width - 50,
        caseFalse: (Get.width / 2) - 50,
      ),
      title: title,
      messageText: Text(
        message,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: success ? AppColors.primary : Colors.orange.shade900,
      duration: _defaultDuration,
      animationDuration: const Duration(milliseconds: 600),
      margin: EdgeInsets.only(
        left: ternaryClean(
          condition: Get.width <= 900,
          caseTrue: 0,
          caseFalse: Get.width / 2,
        ),
        bottom: 10,
        top: 30,
      ),
      borderRadius: _defaultBorderRadius,
      snackPosition: ternaryClean(
        condition: Get.width <= 900,
        caseTrue: SnackPosition.BOTTOM,
        caseFalse: SnackPosition.TOP,
      ),
      boxShadows: _defaultBoxShadows,
      mainButton:
          mainButton ??
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                success
                    ? AppColors.primary.withValues(alpha: 0.5)
                    : Colors.red.shade900.withValues(alpha: 0.5),
              ),
            ),
            onPressed: Get.back,
            child: const Text(
              'Entendi',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
    );
  }

  void error(String message, {Widget? mainButton, bool success = false}) {
    Get.rawSnackbar(
      maxWidth: ternaryClean(
        condition: Get.width <= 900,
        caseTrue: Get.width - 50,
        caseFalse: (Get.width / 2) - 50,
      ),
      messageText: Text(
        message,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: success ? AppColors.primary : Colors.orange.shade900,
      duration: _defaultDuration,
      animationDuration: const Duration(milliseconds: 600),
      margin: EdgeInsets.only(
        left: ternaryClean(
          condition: Get.width <= 900,
          caseTrue: 0,
          caseFalse: Get.width / 2,
        ),
        bottom: 10,
        top: 30,
      ),
      borderRadius: _defaultBorderRadius,
      snackPosition: ternaryClean(
        condition: Get.width <= 900,
        caseTrue: SnackPosition.BOTTOM,
        caseFalse: SnackPosition.TOP,
      ),
      boxShadows: _defaultBoxShadows,
      mainButton:
          mainButton ??
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                success
                    ? AppColors.primary.withValues(alpha: 0.5)
                    : Colors.red.withValues(alpha: 0.5),
              ),
            ),
            onPressed: Get.back,
            child: const Text(
              'Entendi',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
    );
  }

  void warning(String message, {String? title, Widget? mainButton}) {
    Get.rawSnackbar(
      maxWidth: ternaryClean(
        condition: Get.width <= 900,
        caseTrue: Get.width - 50,
        caseFalse: (Get.width / 2) - 50,
      ),
      title: title,
      messageText: Text(
        message,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: Colors.orange.shade900,
      duration: _defaultDuration,
      animationDuration: const Duration(milliseconds: 600),
      margin: EdgeInsets.only(
        left: ternaryClean(
          condition: Get.width <= 900,
          caseTrue: 0,
          caseFalse: Get.width / 2,
        ),
        bottom: 10,
        top: 30,
      ),
      borderRadius: _defaultBorderRadius,
      snackPosition: ternaryClean(
        condition: Get.width <= 900,
        caseTrue: SnackPosition.BOTTOM,
        caseFalse: SnackPosition.TOP,
      ),
      boxShadows: _defaultBoxShadows,
      mainButton:
          mainButton ??
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                Colors.red.shade900.withValues(alpha: 0.5),
              ),
            ),
            onPressed: Get.back,
            child: const Text(
              'Entendi',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
    );
  }
}
