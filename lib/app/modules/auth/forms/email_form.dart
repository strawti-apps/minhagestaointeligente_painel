import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class EmailForm {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? validateEmail(String? value) {
    return MultiValidator([
      RequiredValidator(errorText: 'O email é obrigatório.'),
      EmailValidator(errorText: 'Digite um email válido.'),
    ]).call(value);
  }

  String getEmail() {
    return emailController.text.trim().toLowerCase();
  }

  bool validate() {
    return formKey.currentState?.validate() ?? false;
  }

  void dispose() {
    emailController.dispose();
  }
} 