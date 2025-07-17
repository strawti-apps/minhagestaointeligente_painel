import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SignUpForm {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? validateFirstName(String? value) {
    return RequiredValidator(errorText: 'O nome é obrigatório.').call(value);
  }

  String? validateLastName(String? value) {
    return RequiredValidator(errorText: 'O sobrenome é obrigatório.').call(value);
  }

  String? validateEmail(String? value) {
    return MultiValidator([
      RequiredValidator(errorText: 'O email é obrigatório.'),
      EmailValidator(errorText: 'Digite um email válido.'),
    ]).call(value);
  }

  String? validatePassword(String? value) {
    return MultiValidator([
      RequiredValidator(errorText: 'A senha é obrigatória.'),
      MinLengthValidator(6, errorText: 'A senha deve ter pelo menos 6 caracteres.'),
    ]).call(value);
  }

  String? validateConfirmPassword(String? value) {
    if (value != passwordController.text) {
      return 'As senhas não coincidem.';
    }
    return null;
  }

  String getFirstName() {
    return firstNameController.text.trim();
  }

  String getLastName() {
    return lastNameController.text.trim();
  }

  String getEmail() {
    return emailController.text.trim().toLowerCase();
  }

  String getPassword() {
    return passwordController.text;
  }

  bool validate() {
    return formKey.currentState?.validate() ?? false;
  }

  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
} 