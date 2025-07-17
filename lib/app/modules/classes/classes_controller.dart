import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infra/models/class_model.dart';
import '../../infra/models/course_model.dart';
import '../../infra/repositories/class_repository.dart';
import '../../infra/repositories/course_repository.dart';
import '../../infra/services/storage_service.dart';
import '../../shared/mixins/loader_manager.dart';
import '../../shared/utils/app_snackbar.dart';

class ClassesController extends GetxController with LoaderManager {
  final _classRepository = ClassRepository();
  final _courseRepository = CourseRepository();

  final classTitleController = TextEditingController();
  final classThumbnailUrlController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadClasses();
    loadCourses();
  }

  @override
  void onClose() {
    searchController.dispose();
    classTitleController.dispose();
    classThumbnailUrlController.dispose();
    super.onClose();
  }

  String selectedSubModule = 'list';
  var classes = <ClassModel>[];
  var courses = <CourseModel>[];
  CourseModel? selectedCourse;

  bool isSearchMode = false;
  final TextEditingController searchController = TextEditingController();
  var filteredClasses = <ClassModel>[];

  ClassModel? classToEdit;
  bool isUploadingImage = false;

  bool get isInListMode => selectedSubModule == 'list';

  Future<void> loadClasses() async {
    changeLoading(true);

    final response = await _classRepository.getAllClasses();

    if (response.success && response.data != null) {
      classes = response.data!;
      filteredClasses = List.from(classes);
    } else {
      classes = [];
      filteredClasses = [];

      AppSnackbar.to.success(response.message);
    }

    changeLoading(false);
  }

  Future<void> loadCourses() async {
    final response = await _courseRepository.getAllCourses();

    if (response.success && response.data != null) {
      courses = response.data!;
    } else {
      courses = [];
      AppSnackbar.to.success(response.message);
    }
    update();
  }

  // Upload de imagem da turma
  Future<String?> uploadClassImage(dynamic file) async {
    try {
      isUploadingImage = true;
      update();

      final response = await StorageService.uploadImage(
        file,
        bucketId: 'class-images',
        folder: 'thumbnails',
      );

      if (response.success && response.data != null) {
        AppSnackbar.to.success('Imagem enviada com sucesso!', success: true);
        classThumbnailUrlController.text = response.data!;
        return response.data;
      } else {
        AppSnackbar.to.success('Erro ao fazer upload da imagem: ${response.message}');
        return null;
      }
    } catch (e) {
      AppSnackbar.to.success('Erro inesperado no upload: $e');
      return null;
    } finally {
      isUploadingImage = false;
      update();
    }
  }

  // Criar nova turma
  Future<void> createClass() async {
    changeLoadingCreating(true);

    try {
      final newClass = ClassModel(
        title: classTitleController.text.trim(),
        courseId: selectedCourse?.id,
        thumbnailUrl: _getOptionalFieldValue(classThumbnailUrlController),
        sendWelcomeEmail: false,
        createdAt: DateTime.now(),
      );

      final response = await _classRepository.createClass(newClass);

      if (response.success && response.data != null) {
        final createdClass = response.data!;

        // Adiciona à lista local
        classes.add(createdClass);
        filteredClasses.add(createdClass);

        AppSnackbar.to.success('Turma criada com sucesso', success: true);
        backToList();
      } else {
        AppSnackbar.to.success('Erro ao criar turma');
      }
    } catch (e) {
      AppSnackbar.to.success('Erro ao criar turma: $e');
    } finally {
      changeLoadingCreating(false);
    }
  }

  // Editar turma existente
  Future<void> updateClass() async {
    if (classToEdit == null) return;

    changeLoadingEditing(true);

    try {
      final updatedClass = classToEdit!.copyWith(
        title: classTitleController.text.trim(),
        courseId: selectedCourse?.id,
        thumbnailUrl: _getOptionalFieldValue(classThumbnailUrlController),
      );

      final response = await _classRepository.updateClass(updatedClass);

      if (response.success && response.data != null) {
        final updatedClassResult = response.data!;

        // Atualiza na lista principal
        final mainIndex = classes.indexWhere(
          (classItem) => classItem.id == updatedClassResult.id,
        );
        if (mainIndex != -1) {
          classes[mainIndex] = updatedClassResult;
        }

        // Atualiza na lista filtrada
        final filteredIndex = filteredClasses.indexWhere(
          (classItem) => classItem.id == updatedClassResult.id,
        );
        if (filteredIndex != -1) {
          filteredClasses[filteredIndex] = updatedClassResult;
        }

        AppSnackbar.to.success('Turma atualizada com sucesso', success: true);
        backToList();
      } else {
        AppSnackbar.to.success('Erro ao atualizar turma');
      }
    } catch (e) {
      AppSnackbar.to.success('Erro ao atualizar turma: $e');
    } finally {
      changeLoadingEditing(false);
    }
  }

  Future<void> goToDeleteItem(ClassModel classItem) async {
    if (classItem.id == null) return;

    changeLoadingDeleting(true);

    final response = await _classRepository.deleteClass(classItem.id!);

    if (response.success) {
      classes.removeWhere((c) => c.id == classItem.id);
      filteredClasses.removeWhere((c) => c.id == classItem.id);

      AppSnackbar.to.success('Turma excluída com sucesso', success: true);
    } else {
      AppSnackbar.to.success('Erro ao excluir turma: ${response.message}');
    }

    changeLoadingDeleting(false);
  }

  void showDeleteClassConfirmation(ClassModel classItem) {
    Get.dialog(
      AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: Text(
          'Tem certeza que deseja excluir a turma "${classItem.title}"?\n\nEsta ação não pode ser desfeita.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              goToDeleteItem(classItem);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }

  // Métodos de pesquisa
  void toggleSearchMode() {
    isSearchMode = !isSearchMode;
    if (!isSearchMode) {
      searchController.clear();
      filteredClasses = List.from(classes);
    }
    update();
  }

  void searchClasses(String query) {
    if (query.isEmpty) {
      filteredClasses = List.from(classes);
    } else {
      final lowercaseQuery = query.toLowerCase();
      filteredClasses =
          classes
              .where((classItem) => _classMatchesQuery(classItem, lowercaseQuery))
              .toList();
    }
    update();
  }

  // Verifica se uma turma corresponde à consulta de pesquisa
  bool _classMatchesQuery(ClassModel classItem, String lowercaseQuery) {
    return _fieldContainsQuery(classItem.title, lowercaseQuery);
  }

  // Verifica se um campo (nullable) contém a query
  bool _fieldContainsQuery(String? field, String lowercaseQuery) {
    return field?.toLowerCase().contains(lowercaseQuery) ?? false;
  }

  // Navegar para criar nova turma
  void goToCreateClass() {
    selectedSubModule = 'create_class';
    classToEdit = null;
    clearClassForm();
    update();
  }

  // Navegar para editar turma
  void goToEditItem(ClassModel classItem) {
    selectedSubModule = 'edit_class';
    classToEdit = classItem;
    loadClassDataToForm(classItem);
    update();
  }

  // Voltar para a lista
  void backToList() {
    selectedSubModule = 'list';
    classToEdit = null;
    clearClassForm();
    update();
  }

  // Carregar dados da turma no formulário
  void loadClassDataToForm(ClassModel classItem) {
    classTitleController.text = classItem.title;
    // Encontrar o curso correspondente na lista
    selectedCourse = courses.firstWhereOrNull(
      (course) => course.id == classItem.courseId,
    );
    classThumbnailUrlController.text = classItem.thumbnailUrl ?? '';
  }

  // Limpar formulário de turma
  void clearClassForm() {
    classTitleController.clear();
    selectedCourse = null;
    classThumbnailUrlController.clear();
  }

  // Função para quando um curso for selecionado
  void onCourseSelected(CourseModel? course) {
    selectedCourse = course;
    update();
  }

  // Retorna o valor do campo se não estiver vazio, caso contrário retorna null
  String? _getOptionalFieldValue(TextEditingController controller) {
    final value = controller.text.trim();
    return value.isEmpty ? null : value;
  }
} 