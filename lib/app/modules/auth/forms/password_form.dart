import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class PasswordForm {
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? validatePassword(String? value) {
    return MultiValidator([
      RequiredValidator(errorText: 'A senha é obrigatória.'),
      MinLengthValidator(6, errorText: 'A senha deve ter pelo menos 6 caracteres.'),
    ]).call(value);
  }

  String getPassword() {
    return passwordController.text;
  }

  bool validate() {
    return formKey.currentState?.validate() ?? false;
  }

  void dispose() {
    passwordController.dispose();
  }
} 