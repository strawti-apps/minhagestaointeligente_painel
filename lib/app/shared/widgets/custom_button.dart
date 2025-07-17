import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../themes/app_colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? text;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? width;
  final double? height;
  final double? borderRadius;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool isLoading;
  final bool isOutlined;
  final bool isDisabled;
  final EdgeInsetsGeometry? padding;

  const CustomButton({
    super.key,
    required this.onPressed,
    this.text,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.width,
    this.height,
    this.borderRadius,
    this.fontSize,
    this.fontWeight,
    this.isLoading = false,
    this.isOutlined = false,
    this.isDisabled = false,
    this.padding,
  });

  factory CustomButton.icon({
    required VoidCallback onPressed,
    required IconData icon,
    Color? backgroundColor,
    Color? buttonColor,
    Color? iconColor,
    Color? borderColor,
    double? width,
    double? height,
    double? borderRadius,
    double? iconSize,
    bool isLoading = false,
    bool isOutlined = false,
    bool isDisabled = false,
    EdgeInsetsGeometry? padding,
  }) {
    return CustomButton(
      onPressed: onPressed,
      icon: icon,
      backgroundColor: buttonColor ?? backgroundColor,
      textColor: iconColor,
      borderColor: borderColor,
      width: width,
      height: height,
      borderRadius: borderRadius,
      fontSize: iconSize,
      isLoading: isLoading,
      isOutlined: isOutlined,
      isDisabled: isDisabled,
      padding: padding,
    );
  }

  factory CustomButton.text({
    required VoidCallback onPressed,
    required String text,
    Color? backgroundColor,
    Color? textColor,
    Color? borderColor,
    double? width,
    double? height,
    double? borderRadius,
    double? fontSize,
    FontWeight? fontWeight,
    bool isLoading = false,
    bool isOutlined = false,
    bool isDisabled = false,
    EdgeInsetsGeometry? padding,
  }) {
    return CustomButton(
      onPressed: onPressed,
      text: text,
      backgroundColor: backgroundColor,
      textColor: textColor,
      borderColor: borderColor,
      width: width,
      height: height,
      borderRadius: borderRadius,
      fontSize: fontSize,
      fontWeight: fontWeight,
      isLoading: isLoading,
      isOutlined: isOutlined,
      isDisabled: isDisabled,
      padding: padding,
    );
  }

  @override
  Widget build(BuildContext context) {
    final effectiveBackgroundColor = isOutlined
        ? Colors.transparent
        : backgroundColor ?? AppColors.primary;
    
    final effectiveTextColor = isOutlined
        ? textColor ?? AppColors.primary
        : textColor ?? Colors.white;
    
    final effectiveBorderColor = borderColor ?? AppColors.primary;
    
    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: effectiveBackgroundColor,
      foregroundColor: effectiveTextColor,
      padding: padding ?? EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
        side: isOutlined ? BorderSide(color: effectiveBorderColor) : BorderSide.none,
      ),
      elevation: isOutlined ? 0 : 2,
      minimumSize: Size(width ?? 0, height ?? 40.h),
      maximumSize: width != null && height != null ? Size(width!, height!) : null,
      disabledBackgroundColor: isOutlined ? Colors.transparent : Colors.grey[300],
      disabledForegroundColor: isOutlined ? Colors.grey : Colors.grey[600],
    );

    return ElevatedButton(
      onPressed: isDisabled || isLoading ? null : onPressed,
      style: buttonStyle,
      child: _buildButtonContent(),
    );
  }

  Widget _buildButtonContent() {
    if (isLoading) {
      return SizedBox(
        width: 20.r,
        height: 20.r,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation<Color>(
            isOutlined ? (textColor ?? AppColors.primary) : Colors.white,
          ),
        ),
      );
    }

    if (icon != null && text != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(
            icon,
            size: fontSize ?? 16.sp,
            color: isOutlined
                ? (textColor ?? AppColors.primary)
                : (textColor ?? Colors.white),
          ),
          SizedBox(width: 8.w),
          Text(
            text!,
            style: TextStyle(
              fontSize: fontSize ?? 14.sp,
              fontWeight: fontWeight ?? FontWeight.w600,
              color: isOutlined
                  ? (textColor ?? AppColors.primary)
                  : (textColor ?? Colors.white),
            ),
          ),
        ],
      );
    } else if (icon != null) {
      return FaIcon(
        icon,
        size: fontSize ?? 16.sp,
        color: isOutlined
            ? (textColor ?? AppColors.primary)
            : (textColor ?? Colors.white),
      );
    } else if (text != null) {
      return Text(
        text!,
        style: TextStyle(
          fontSize: fontSize ?? 14.sp,
          fontWeight: fontWeight ?? FontWeight.w600,
          color: isOutlined
              ? (textColor ?? AppColors.primary)
              : (textColor ?? Colors.white),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}