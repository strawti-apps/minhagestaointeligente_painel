import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/app_colors.dart';
import 'navbar_navigation_controller.dart';
import 'user_info_widget.dart';

class NavbarMobileWidget extends StatelessWidget {
  const NavbarMobileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (MediaQuery.of(context).size.width >= 700) {
          return const SizedBox.shrink();
        }
        return GetBuilder<NavbarNavigationController>(
          builder: (controller) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Informações do usuário
                const UserInfoWidget(isMobile: true),
                
                // Bottom Navigation Bar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 8,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          for (int i = 0; i < controller.currentNavItems.length; i++)
                            Expanded(
                              child: InkWell(
                                onTap: () => controller.changeTab(i),
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        controller.currentNavItems[i].icon,
                                        size: 24,
                                        color: controller.currentIndex == i
                                            ? AppColors.primary
                                            : AppColors.textSecondary,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        controller.currentNavItems[i].label,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: controller.currentIndex == i
                                              ? AppColors.primary
                                              : AppColors.textSecondary,
                                          fontWeight: controller.currentIndex == i
                                              ? FontWeight.w600
                                              : FontWeight.w400,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
} 