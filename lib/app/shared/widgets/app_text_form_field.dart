import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../themes/app_colors.dart';

class AppTextFormField extends StatefulWidget {
  final String? title;
  final Widget? suffixIcon;
  final int? maxLines;
  final int? minLines;
  final String? hintText;
  final String? fontFamily;
  final String? initialValue;
  final TextEditingController? controller;
  final bool readOnly;
  final bool enabled;
  final bool isPassword;
  final FocusNode? focusNode;
  final bool optional;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Widget? prefixIcon;
  final double? radius;
  final Color? fillColor;
  final Color? textColor;
  final Color? floatingTextColor;
  final Color? borderColor;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final AutovalidateMode? autoValidateMode;
  final EdgeInsetsGeometry? contentPadding;
  final bool? hasTitle;
  final bool autofocus;
  final void Function(String)? onFieldSubmitted;
  final TextCapitalization textCapitalization;
  final bool alwaysFloatLabel;

  const AppTextFormField({
    super.key,
    this.fillColor,
    this.autofocus = false,
    this.suffixIcon,
    this.maxLines = 1,
    this.hintText,
    this.fontFamily,
    this.initialValue,
    this.controller,
    this.readOnly = false,
    this.enabled = true,
    this.isPassword = false,
    this.focusNode,
    this.optional = false,
    this.inputFormatters,
    this.validator,
    this.keyboardType,
    this.onTap,
    this.onChanged,
    this.prefixIcon,
    this.radius,
    this.textColor,
    this.floatingTextColor,
    this.title,
    this.borderColor,
    this.textInputAction = TextInputAction.next,
    this.maxLength,
    this.hasTitle,
    this.minLines,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.onFieldSubmitted,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 16,
    ),
    this.textCapitalization = TextCapitalization.none,
    this.alwaysFloatLabel = false,
  });

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.title != null && (widget.hasTitle ?? false)) ...[
          Text(
            widget.title ?? '',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
        ],
        TextFormField(
          textCapitalization: widget.textCapitalization,
          autofocus: widget.autofocus,
          autovalidateMode: widget.autoValidateMode,
          maxLength: widget.maxLength,
          textInputAction: widget.textInputAction,
          onChanged: widget.onChanged,
          keyboardType: widget.keyboardType,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          focusNode: widget.focusNode,
          onTap: widget.onTap,
          readOnly: widget.readOnly,
          enabled: widget.enabled,
          initialValue: widget.initialValue,
          controller: widget.initialValue != null ? null : widget.controller,
          obscureText: !widget.isPassword ? false : obscureText,
          inputFormatters: widget.inputFormatters,
          onFieldSubmitted: widget.onFieldSubmitted,
          validator:
              widget.validator ??
              (value) {
                if (widget.optional == false &&
                    (value?.trim().isEmpty ?? true)) {
                  return '*Campo obrigatório.';
                }
                return null;
              },
          decoration: InputDecoration(
            labelText: (widget.hasTitle ?? false) ? null : widget.title,
            floatingLabelBehavior:
                widget.alwaysFloatLabel
                    ? FloatingLabelBehavior.always
                    : FloatingLabelBehavior.auto,
            floatingLabelStyle: TextStyle(
              fontFamily: 'Poppins',
              color: widget.floatingTextColor ?? AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: widget.fillColor ?? AppColors.card,
            contentPadding: widget.contentPadding,
            suffixIcon: Visibility(
              visible: widget.isPassword,
              replacement: widget.suffixIcon ?? const SizedBox.shrink(),
              child: InkWell(
                onTap: () {
                  obscureText = !obscureText;
                  setState(() {});
                },
                child: Icon(
                  obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            prefixIcon:
                widget.prefixIcon != null
                    ? Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: widget.prefixIcon,
                    )
                    : null,
            hintText: widget.hintText,
            labelStyle: TextStyle(
              fontFamily: 'Poppins',
              color: widget.textColor ?? AppColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            hintStyle: TextStyle(
              fontFamily: 'Poppins',
              color: widget.textColor ?? AppColors.textPrimary,
              fontSize: 14,
              overflow: TextOverflow.visible,
              fontWeight: FontWeight.w400,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius ?? 6),
              borderSide: BorderSide(
                color: widget.borderColor ?? AppColors.primary.withValues(alpha: 0.1),
                width: 1.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius ?? 6),
              borderSide: BorderSide(
                color: widget.borderColor ?? AppColors.primary.withValues(alpha: 0.1),
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius ?? 6),
              borderSide: BorderSide(
                color: widget.borderColor ?? AppColors.primary.withValues(alpha: 0.5),
                width: 1.5,
              ),
            ),
          ),
          style: TextStyle(
            fontFamily: widget.fontFamily ?? 'Poppins',
            color: widget.textColor ?? AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
