import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infra/models/user_model.dart';
import '../../infra/repositories/user_repository.dart';
import '../../shared/mixins/loader_manager.dart';
import '../../shared/utils/app_snackbar.dart';

class UsersController extends GetxController with LoaderManager {
  late final UserRepository _userRepository;

  // Listas de dados
  List<UserModel> allUsers = [];
  List<UserModel> filteredUsers = [];

  // Estado da interface
  String selectedSubModule = 'users_list';
  bool isSearchMode = false;
  final searchController = TextEditingController();

  // Formulário de criação
  final createUserFormKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  String selectedRole = 'student';

  // Opções de role
  final List<Map<String, String>> roleOptions = [
    {'value': 'student', 'label': 'Aluno'},
    {'value': 'teacher', 'label': 'Professor'},
    {'value': 'admin', 'label': 'Administrador'},
  ];

  // Getters
  bool get isInListMode => selectedSubModule == 'users_list';
  bool get isInCreateMode => selectedSubModule == 'create_user';

  @override
  void onInit() {
    super.onInit();
    _userRepository = UserRepository();
    loadUsers();
  }

  @override
  void onClose() {
    searchController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    super.onClose();
  }

  // Navegação entre submódulos
  void selectSubModule(String subModule) {
    selectedSubModule = subModule;
    
    if (subModule == 'users_list') {
      clearCreateForm();
    }
    
    update();
  }

  // Carregar usuários
  Future<void> loadUsers() async {
    changeLoading(true);
    
    final response = await _userRepository.getAllUsers();
    
    if (response.success) {
      allUsers = response.data ?? [];
      _updateFilteredUsers();
    } else {
      AppSnackbar.to.error('Erro ao carregar usuários: ${response.message}');
    }
    
    changeLoading(false);
  }

  // Atualizar lista filtrada
  void _updateFilteredUsers() {
    if (isSearchMode && searchController.text.isNotEmpty) {
      searchUsers(searchController.text);
    } else {
      filteredUsers = List.from(allUsers);
      update();
    }
  }

  // Toggle modo de pesquisa
  void toggleSearchMode() {
    isSearchMode = !isSearchMode;
    
    if (!isSearchMode) {
      searchController.clear();
      filteredUsers = List.from(allUsers);
    }
    
    update();
  }

  // Pesquisar usuários
  Future<void> searchUsers(String query) async {
    if (query.isEmpty) {
      filteredUsers = List.from(allUsers);
      update();
      return;
    }

    changeLoading(true);
    
    final response = await _userRepository.searchUsers(query);
    
    if (response.success) {
      filteredUsers = response.data ?? [];
    } else {
      AppSnackbar.to.error('Erro na busca: ${response.message}');
      filteredUsers = [];
    }
    
    changeLoading(false);
  }

  // Criar usuário
  Future<void> createUser() async {
    if (!createUserFormKey.currentState!.validate()) return;

    changeLoadingCreating(true);

    // Verificar se email já existe
    final emailExistsResponse = await _userRepository.checkEmailExists(emailController.text.trim());
    
    if (emailExistsResponse.success && emailExistsResponse.data == true) {
      AppSnackbar.to.error('Este email já está em uso');
      changeLoadingCreating(false);
      return;
    }

    // Criar modelo do usuário
    final newUser = UserModel(
      authUserId: '', // Será preenchido pelo createUserWithAuth
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim().isEmpty ? null : lastNameController.text.trim(),
      email: emailController.text.trim(),
      role: selectedRole,
    );

    // Criar usuário com autenticação
    final response = await _userRepository.createUserWithAuth(newUser);

    if (response.success) {
      AppSnackbar.to.success('Usuário criado com sucesso!');
      clearCreateForm();
      selectSubModule('users_list');
      loadUsers(); // Recarregar lista
    } else {
      AppSnackbar.to.error('Erro ao criar usuário: ${response.message}');
    }

    changeLoadingCreating(false);
  }

  // Deletar usuário
  Future<void> deleteUser(UserModel user) async {
    // Mostrar diálogo de confirmação
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: Text('Tem certeza que deseja excluir o usuário "${user.firstName} ${user.lastName ?? ''}"?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    changeLoadingDeleting(true);

    final response = await _userRepository.deleteUser(user.id!);

    if (response.success) {
      AppSnackbar.to.success('Usuário excluído com sucesso');
      loadUsers(); // Recarregar lista
    } else {
      AppSnackbar.to.error('Erro ao excluir usuário: ${response.message}');
    }

    changeLoadingDeleting(false);
  }

  // Limpar formulário de criação
  void clearCreateForm() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    selectedRole = 'student';
  }

  // Validações do formulário
  String? validateFirstName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nome é obrigatório';
    }
    if (value.trim().length < 2) {
      return 'Nome deve ter pelo menos 2 caracteres';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email é obrigatório';
    }
    if (!GetUtils.isEmail(value.trim())) {
      return 'Email inválido';
    }
    return null;
  }

  // Obter label do role
  String getRoleLabel(String role) {
    final roleData = roleOptions.firstWhere(
      (option) => option['value'] == role,
      orElse: () => {'label': role},
    );
    return roleData['label'] ?? role;
  }

  // Obter cor do role
  Color getRoleColor(String role) {
    switch (role) {
      case 'admin':
        return Colors.red;
      case 'teacher':
        return Colors.blue;
      case 'student':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
} 