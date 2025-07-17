import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../themes/app_colors.dart';

class LoadingIndicator extends StatelessWidget {
  final String? message;
  final String? lottieAnimation;
  final double? size;
  final Color? color;
  final double? strokeWidth;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;

  const LoadingIndicator({
    super.key,
    this.message,
    this.lottieAnimation,
    this.size,
    this.color,
    this.strokeWidth,
    this.padding,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: padding ?? EdgeInsets.all(24.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (lottieAnimation != null)
              Lottie.asset(
                lottieAnimation!,
                width: size ?? 100.r,
                height: size ?? 100.r,
                repeat: true,
              )
            else
              SizedBox(
                width: size ?? 48.r,
                height: size ?? 48.r,
                child: CircularProgressIndicator(
                  strokeWidth: strokeWidth ?? 4.r,
                  valueColor: AlwaysStoppedAnimation<Color>(color ?? AppColors.primary),
                ),
              ),
            if (message != null) SizedBox(height: 16.h),
            if (message != null)
              Text(
                message!,
                textAlign: TextAlign.center,
                style: textStyle ?? TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
      ),
    );
  }
} 