import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infra/models/class_model.dart';
import '../../infra/models/enrollment_with_details_model.dart';
import '../../infra/models/user_model.dart';
import '../../infra/repositories/class_repository.dart';
import '../../infra/repositories/enrollment_repository.dart';
import '../../infra/repositories/user_repository.dart';
import '../../shared/mixins/loader_manager.dart';
import '../../shared/utils/app_snackbar.dart';

class AccessController extends GetxController with LoaderManager {
  final _enrollmentRepository = EnrollmentRepository();
  final _userRepository = UserRepository();
  final _classRepository = ClassRepository();

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  String selectedSubModule = 'list';
  
  // Dados principais - agora tipados corretamente
  var enrollments = <EnrollmentWithDetailsModel>[];
  var users = <UserModel>[];
  var classes = <ClassModel>[];

  // Pesquisa
  bool isSearchMode = false;
  final TextEditingController searchController = TextEditingController();
  var filteredEnrollments = <EnrollmentWithDetailsModel>[];

  // Formulário de criação
  var selectedUsers = <UserModel>[];
  ClassModel? selectedClass;

  bool get isInListMode => selectedSubModule == 'list';

  // Carregar todos os dados necessários
  Future<void> loadData() async {
    await Future.wait([
      loadEnrollments(),
      loadUsers(),
      loadClasses(),
    ]);
  }

  // Carregar enrollments
  Future<void> loadEnrollments() async {
    changeLoading(true);

    final response = await _enrollmentRepository.getAllEnrollmentsWithDetails();

    if (response.success && response.data != null) {
      enrollments = response.data!;
      filteredEnrollments = List.from(enrollments);
    } else {
      enrollments = [];
      filteredEnrollments = [];
      AppSnackbar.to.error(response.message);
    }

    changeLoading(false);
  }

  // Carregar usuários
  Future<void> loadUsers() async {
    final response = await _userRepository.getAllUsers();

    if (response.success && response.data != null) {
      users = response.data!;
    } else {
      users = [];
      AppSnackbar.to.error(response.message);
    }
    update();
  }

  // Carregar turmas
  Future<void> loadClasses() async {
    final response = await _classRepository.getAllClasses();

    if (response.success && response.data != null) {
      classes = response.data!;
    } else {
      classes = [];
      AppSnackbar.to.error(response.message);
    }
    update();
  }

  // Alternar modo de pesquisa
  void toggleSearchMode() {
    isSearchMode = !isSearchMode;
    if (!isSearchMode) {
      searchController.clear();
      filteredEnrollments = List.from(enrollments);
    }
    update();
  }

  // Pesquisar enrollments
  void searchEnrollments(String query) async {
    if (query.isEmpty) {
      filteredEnrollments = List.from(enrollments);
    } else {
      final response = await _enrollmentRepository.searchEnrollments(query);
      if (response.success && response.data != null) {
        filteredEnrollments = response.data!;
      }
    }
    update();
  }

  // Navegação de submódulos
  void selectSubModule(String subModule) {
    selectedSubModule = subModule;
    if (subModule == 'create_access') {
      clearForm();
    }
    update();
  }

  // Limpar formulário
  void clearForm() {
    selectedUsers.clear();
    selectedClass = null;
    update();
  }

  // Adicionar usuário selecionado
  void addSelectedUser(UserModel? user) {
    if (user != null && !selectedUsers.any((u) => u.id == user.id)) {
      selectedUsers.add(user);
      update();
    }
  }

  // Remover usuário selecionado
  void removeSelectedUser(UserModel user) {
    selectedUsers.removeWhere((u) => u.id == user.id);
    update();
  }

  // Selecionar turma
  void selectClass(ClassModel? classModel) {
    selectedClass = classModel;
    update();
  }

  // Criar acessos
  Future<void> createAccess() async {
    if (selectedUsers.isEmpty) {
      AppSnackbar.to.warning('Selecione pelo menos um usuário');
      return;
    }

    if (selectedClass == null) {
      AppSnackbar.to.warning('Selecione uma turma');
      return;
    }

    changeLoadingCreating(true);

    try {
      // Verificar se algum usuário já está inscrito
      final userIds = selectedUsers.map((u) => u.id!).toList();
      final alreadyEnrolledResponse = await _enrollmentRepository
          .getAlreadyEnrolledUsers(userIds, selectedClass!.id!);

      if (alreadyEnrolledResponse.success && alreadyEnrolledResponse.data!.isNotEmpty) {
        final alreadyEnrolledIds = alreadyEnrolledResponse.data!;
        final alreadyEnrolledUsers = selectedUsers
            .where((u) => alreadyEnrolledIds.contains(u.id))
            .map((u) => '${u.firstName} ${u.lastName ?? ''}')
            .join(', ');

        AppSnackbar.to.warning(
          'Os seguintes usuários já estão inscritos nesta turma: $alreadyEnrolledUsers'
        );
        
        // Remover usuários já inscritos da lista
        selectedUsers.removeWhere((u) => alreadyEnrolledIds.contains(u.id));
        update();
        
        if (selectedUsers.isEmpty) {
          changeLoadingCreating(false);
          return;
        }
      }

      // Criar enrollments para usuários não inscritos
      final remainingUserIds = selectedUsers.map((u) => u.id!).toList();
      final response = await _enrollmentRepository
          .createMultipleEnrollments(remainingUserIds, selectedClass!.id!);

      if (response.success) {
        AppSnackbar.to.success(
          'Acesso criado com sucesso para ${selectedUsers.length} usuário(s)'
        );
        
        clearForm();
        selectSubModule('list');
        await loadEnrollments();
      } else {
        AppSnackbar.to.error(response.message);
      }
    } catch (e) {
      AppSnackbar.to.error('Erro ao criar acesso: $e');
    }

    changeLoadingCreating(false);
  }

  // Remover acesso
  Future<void> removeAccess(int enrollmentId) async {
    final response = await _enrollmentRepository.removeEnrollment(enrollmentId);

    if (response.success) {
      AppSnackbar.to.success('Acesso removido com sucesso');
      await loadEnrollments();
    } else {
      AppSnackbar.to.error(response.message);
    }
  }

  // Métodos simplificados usando o modelo tipado
  String getUserFullName(EnrollmentWithDetailsModel enrollment) {
    return enrollment.userFullName;
  }

  String getClassName(EnrollmentWithDetailsModel enrollment) {
    return enrollment.className;
  }

  String getUserRole(EnrollmentWithDetailsModel enrollment) {
    return enrollment.userRole;
  }

  String getUserEmail(EnrollmentWithDetailsModel enrollment) {
    return enrollment.userEmail;
  }

  String getFormattedDate(EnrollmentWithDetailsModel enrollment) {
    return enrollment.formattedDate;
  }
} 