import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../themes/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? titleWidget;
  final double? elevation;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? iconColor;
  final PreferredSizeWidget? bottom;
  final bool centerTitle;
  final double? titleSpacing;
  final VoidCallback? onBackPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.actions,
    this.leading,
    this.titleWidget,
    this.elevation,
    this.backgroundColor,
    this.titleColor,
    this.iconColor,
    this.bottom,
    this.centerTitle = true,
    this.titleSpacing,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:
          titleWidget ??
          Text(
            title,
            style: TextStyle(
              color: titleColor ?? AppColors.textPrimary,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
      leading: _buildLeading(),
      actions: actions,
      elevation: elevation ?? 0,
      backgroundColor: backgroundColor ?? Colors.white,
      centerTitle: centerTitle,
      titleSpacing: titleSpacing,
      bottom: bottom,
      iconTheme: IconThemeData(color: iconColor ?? AppColors.primaryDark),
    );
  }

  Widget? _buildLeading() {
    if (leading != null) {
      return leading;
    }

    if (showBackButton) {
      return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: onBackPressed ?? () => Get.back(),
      );
    }

    return null;
  }

  @override
  Size get preferredSize => Size.fromHeight(
    bottom != null
        ? kToolbarHeight + bottom!.preferredSize.height
        : kToolbarHeight,
  );
}
