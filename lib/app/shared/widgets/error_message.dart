import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../themes/app_colors.dart';
import 'custom_button.dart';

class ErrorMessage extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final IconData? icon;
  final String? retryButtonText;
  final double? iconSize;
  final Color? iconColor;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? padding;

  const ErrorMessage({
    super.key,
    required this.message,
    this.onRetry,
    this.icon,
    this.retryButtonText,
    this.iconSize,
    this.iconColor,
    this.textColor,
    this.fontSize,
    this.fontWeight,
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
            FaIcon(
              icon ?? FontAwesomeIcons.triangleExclamation,
              size: iconSize ?? 64.r,
              color: iconColor ?? AppColors.error,
            ),
            SizedBox(height: 24.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize ?? 16.sp,
                fontWeight: fontWeight ?? FontWeight.w500,
                color: textColor ?? AppColors.textSecondary,
              ),
            ),
            if (onRetry != null) SizedBox(height: 24.h),
            if (onRetry != null)
              CustomButton(
                onPressed: onRetry!,
                text: retryButtonText ?? 'Tentar novamente',
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