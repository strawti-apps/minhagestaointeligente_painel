import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';

class AppButtonDefault extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final bool isLoading;
  final bool usingJustPadding;
  final double paddingVertical;
  final double? radius;
  final double width;
  final bool? isValid;
  final Color? buttonColor;
  final Color? textColor;
  final Color? borderColor;
  final String? imageIcon;
  final IconData? icon;
  final IconData? suffixIcon;
  final String? image;
  final double fontSize;
  final FontWeight? weight;

  const AppButtonDefault({
    super.key,
    required this.onTap,
    required this.text,
    this.isLoading = false,
    this.usingJustPadding = false,
    this.width = 300,
    this.paddingVertical = 8,
    this.fontSize = 14,
    this.radius,
    this.isValid,
    this.image,
    this.icon,
    this.imageIcon,
    this.buttonColor = AppColors.primaryDark,
    this.textColor = Colors.white,
    this.borderColor,
    this.suffixIcon,
    this.weight,
  });

  @override
  Widget build(BuildContext context) {
    bool isValidButton = isValid ?? true;

    final Color effectiveButtonColor =
        buttonColor ?? Theme.of(context).primaryColor;
    final Color effectiveTextColor = textColor ?? AppColors.textPrimary;

    return InkWell(
      onTap: isLoading || !isValidButton ? null : onTap,
      child: Container(
        clipBehavior: Clip.hardEdge,
        width: usingJustPadding ? null : width,
        padding: EdgeInsets.symmetric(
          horizontal: usingJustPadding ? 15 : 0,
          vertical: paddingVertical,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 12),
          border: Border.all(
            color:
                isValidButton
                    ? borderColor ?? Colors.transparent
                    : AppColors.textPrimary,
          ),
          color: isValidButton ? effectiveButtonColor : AppColors.textSecondary,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isValidButton ? effectiveTextColor : Colors.grey[400]!,
                  ),
                ),
              ),
            if (isLoading) const SizedBox(width: 12),
            if (!isLoading) ...[
              if (icon != null)
                Icon(
                  icon!,
                  color: isValidButton ? effectiveTextColor : Colors.grey[400],
                ),
              if (image != null) Image.asset(image ?? '', height: 25),
              if (image != null) const SizedBox(width: 10),
              if (icon != null) const SizedBox(width: 5),
              if (imageIcon != null && icon == null)
                Image.asset(
                  imageIcon ?? 'assets/icons/attention.png',
                  scale: 3.5,
                ),
              if (imageIcon != null && icon == null) const SizedBox(width: 10),
              Flexible(
                fit: FlexFit.loose,
                child: Text(
                  text,
                  style: TextStyle(
                    color:
                        isValidButton ? effectiveTextColor : Colors.grey[400],
                    fontSize: fontSize,
                    fontWeight: weight,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (suffixIcon != null) const SizedBox(width: 10),
              if (suffixIcon != null)
                Icon(
                  suffixIcon!,
                  color: isValidButton ? effectiveTextColor : Colors.grey[400],
                ),
            ],
          ],
        ),
      ),
    );
  }
}
