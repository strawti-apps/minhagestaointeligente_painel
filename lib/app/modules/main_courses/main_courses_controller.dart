import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infra/models/course_model.dart';
import '../../infra/repositories/course_repository.dart';
import '../../infra/services/storage_service.dart';
import '../../shared/mixins/loader_manager.dart';
import '../../shared/utils/app_snackbar.dart';

class MainCoursesController extends GetxController with LoaderManager {
  final _courseRepository = CourseRepository();

  final courseTitleController = TextEditingController();
  final courseDescriptionController = TextEditingController();
  final courseCategoryController = TextEditingController();
  final courseCoverImageUrlController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadMainCourses();
  }

  @override
  void onClose() {
    searchController.dispose();
    courseTitleController.dispose();
    courseDescriptionController.dispose();
    courseCategoryController.dispose();
    courseCoverImageUrlController.dispose();
    super.onClose();
  }

  String selectedSubModule = 'list';
  var mainCourses = <CourseModel>[];

  bool isSearchMode = false;
  final TextEditingController searchController = TextEditingController();
  var filteredMainCourses = <CourseModel>[];

  CourseModel? courseToEdit;
  bool isUploadingImage = false;

  bool get isInListMode => selectedSubModule == 'list';

  Future<void> loadMainCourses() async {
    changeLoading(true);

    final response = await _courseRepository.getAllCourses();

    if (response.success && response.data != null) {
      mainCourses = response.data!;
      filteredMainCourses = List.from(mainCourses);
    } else {
      mainCourses = [];
      filteredMainCourses = [];

      AppSnackbar.to.success(response.message);
    }

    changeLoading(false);
  }

  // Upload de imagem do curso
  Future<String?> uploadCourseImage(dynamic file) async {
    try {
      isUploadingImage = true;
      update();

      final response = await StorageService.uploadImage(
        file,
        bucketId: 'course-images',
        folder: 'covers',
      );

      if (response.success && response.data != null) {
        AppSnackbar.to.success('Imagem enviada com sucesso!', success: true);
        courseCoverImageUrlController.text = response.data!;
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

  // Criar novo curso
  Future<void> createCourse() async {
    changeLoadingCreating(true);

    try {
      final newCourse = CourseModel(
        title: courseTitleController.text.trim(),
        description: _getOptionalFieldValue(courseDescriptionController),
        category: _getOptionalFieldValue(courseCategoryController),
        coverImageUrl: _getOptionalFieldValue(courseCoverImageUrlController),
        createdAt: DateTime.now(),
      );

      final response = await _courseRepository.createCourse(newCourse);

      if (response.success && response.data != null) {
        final createdCourse = response.data!;

        // Adiciona à lista local
        mainCourses.add(createdCourse);
        filteredMainCourses.add(createdCourse);

        AppSnackbar.to.success('Curso criado com sucesso', success: true);
        backToList();
      } else {
        AppSnackbar.to.success('Erro ao criar curso');
      }
    } catch (e) {
      AppSnackbar.to.success('Erro ao criar curso: $e');
    } finally {
      changeLoadingCreating(false);
    }
  }

  // Editar curso existente
  Future<void> updateCourse() async {
    if (courseToEdit == null) return;

    changeLoadingEditing(true);

    try {
      final updatedCourse = courseToEdit!.copyWith(
        title: courseTitleController.text.trim(),
        description: _getOptionalFieldValue(courseDescriptionController),
        category: _getOptionalFieldValue(courseCategoryController),
        coverImageUrl: _getOptionalFieldValue(courseCoverImageUrlController),
      );

      final response = await _courseRepository.updateCourse(updatedCourse);

      if (response.success && response.data != null) {
        final updatedCourseResult = response.data!;

        // Atualiza na lista principal
        final mainIndex = mainCourses.indexWhere(
          (course) => course.id == updatedCourseResult.id,
        );
        if (mainIndex != -1) {
          mainCourses[mainIndex] = updatedCourseResult;
        }

        // Atualiza na lista filtrada
        final filteredIndex = filteredMainCourses.indexWhere(
          (course) => course.id == updatedCourseResult.id,
        );
        if (filteredIndex != -1) {
          filteredMainCourses[filteredIndex] = updatedCourseResult;
        }

        AppSnackbar.to.success('Curso atualizado com sucesso', success: true);
        backToList();
      } else {
        AppSnackbar.to.success('Erro ao atualizar curso');
      }
    } catch (e) {
      AppSnackbar.to.success('Erro ao atualizar curso: $e');
    } finally {
      changeLoadingEditing(false);
    }
  }

  Future<void> goToDeleteItem(CourseModel mainCourse) async {
    if (mainCourse.id == null) return;

    changeLoadingDeleting(true);

    final response = await _courseRepository.deleteCourse(mainCourse.id!);

    if (response.success) {
      mainCourses.removeWhere((mc) => mc.id == mainCourse.id);
      filteredMainCourses.removeWhere((mc) => mc.id == mainCourse.id);

      AppSnackbar.to.success('Curso excluído com sucesso', success: true);
    } else {
      AppSnackbar.to.success('Erro ao excluir curso: ${response.message}');
    }

    changeLoadingDeleting(false);
  }

  void showDeleteCourseConfirmation(CourseModel course) {
    Get.dialog(
      AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: Text(
          'Tem certeza que deseja excluir o curso "${course.title}"?\n\nEsta ação não pode ser desfeita.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              goToDeleteItem(course);
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
      filteredMainCourses = List.from(mainCourses);
    }
    update();
  }

  void searchMainCourses(String query) {
    if (query.isEmpty) {
      filteredMainCourses = List.from(mainCourses);
    } else {
      final lowercaseQuery = query.toLowerCase();
      filteredMainCourses =
          mainCourses
              .where((course) => _courseMatchesQuery(course, lowercaseQuery))
              .toList();
    }
    update();
  }

  // Verifica se um curso corresponde à consulta de pesquisa
  bool _courseMatchesQuery(CourseModel course, String lowercaseQuery) {
    return _fieldContainsQuery(course.title, lowercaseQuery) ||
        _fieldContainsQuery(course.description, lowercaseQuery) ||
        _fieldContainsQuery(course.category, lowercaseQuery);
  }

  // Verifica se um campo (nullable) contém a query
  bool _fieldContainsQuery(String? field, String lowercaseQuery) {
    return field?.toLowerCase().contains(lowercaseQuery) ?? false;
  }

  // Navegar para criar novo curso
  void goToCreateCourse() {
    selectedSubModule = 'create_course';
    courseToEdit = null;
    clearCourseForm();
    update();
  }

  // Navegar para editar curso
  void goToEditItem(CourseModel course) {
    selectedSubModule = 'edit_course';
    courseToEdit = course;
    loadCourseDataToForm(course);
    update();
  }

  // Voltar para a lista
  void backToList() {
    selectedSubModule = 'list';
    courseToEdit = null;
    clearCourseForm();
    update();
  }

  // Carregar dados do curso no formulário
  void loadCourseDataToForm(CourseModel course) {
    courseTitleController.text = course.title;
    courseDescriptionController.text = course.description ?? '';
    courseCategoryController.text = course.category ?? '';
    courseCoverImageUrlController.text = course.coverImageUrl ?? '';
  }

  // Limpar formulário de curso
  void clearCourseForm() {
    courseTitleController.clear();
    courseDescriptionController.clear();
    courseCategoryController.clear();
    courseCoverImageUrlController.clear();
  }

  // Retorna o valor do campo se não estiver vazio, caso contrário retorna null
  String? _getOptionalFieldValue(TextEditingController controller) {
    final value = controller.text.trim();
    return value.isEmpty ? null : value;
  }
}
