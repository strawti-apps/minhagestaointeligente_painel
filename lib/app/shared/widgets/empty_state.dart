import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import '../../themes/app_colors.dart';
import 'custom_button.dart';

class EmptyState extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final String? message;
  final String? buttonText;
  final VoidCallback? onPressed;
  final String? lottieAnimation;
  final double? iconSize;
  final Color? iconColor;
  final Color? textColor;
  final double? titleFontSize;
  final double? messageFontSize;
  final FontWeight? titleFontWeight;
  final FontWeight? messageFontWeight;
  final EdgeInsetsGeometry? padding;

  const EmptyState({
    super.key,
    this.icon,
    this.title,
    this.message,
    this.buttonText,
    this.onPressed,
    this.lottieAnimation,
    this.iconSize,
    this.iconColor,
    this.textColor,
    this.titleFontSize,
    this.messageFontSize,
    this.titleFontWeight,
    this.messageFontWeight,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: padding ?? EdgeInsets.all(24.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (lottieAnimation != null)
              Lottie.asset(
                lottieAnimation!,
                width: 150.r,
                height: 150.r,
                repeat: true,
              )
            else if (icon != null)
              FaIcon(
                icon,
                size: iconSize ?? 80.r,
                color: iconColor ?? AppColors.primary,
              ),
            SizedBox(height: 24.h),
            if (title != null)
              Text(
                title!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: titleFontSize ?? 18.sp,
                  fontWeight: titleFontWeight ?? FontWeight.bold,
                  color: textColor ?? AppColors.textPrimary,
                ),
              ),
            if (title != null) SizedBox(height: 8.h),
            if (message != null)
              Text(
                message!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: messageFontSize ?? 14.sp,
                  fontWeight: messageFontWeight ?? FontWeight.normal,
                  color: textColor ?? AppColors.textSecondary,
                ),
              ),
            if (buttonText != null && onPressed != null) SizedBox(height: 24.h),
            if (buttonText != null && onPressed != null)
              CustomButton(
                onPressed: onPressed!,
                text: buttonText,
                backgroundColor: AppColors.primary,
                height: 48.h,
                width: 200.w,
                borderRadius: 8.r,
              ),
          ],
        ),
      ),
    );
  }
}