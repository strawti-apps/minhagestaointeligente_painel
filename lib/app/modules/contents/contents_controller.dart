import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infra/models/course_model.dart';
import '../../infra/models/module_model.dart';
import '../../infra/models/lesson_model.dart';
import '../../infra/models/material_model.dart';
import '../../infra/models/quiz_model.dart';
import '../../infra/repositories/course_repository.dart';
import '../../infra/repositories/module_repository.dart';
import '../../infra/repositories/lesson_repository.dart';
import '../../infra/repositories/material_repository.dart';
import '../../infra/repositories/quiz_repository.dart';
import '../../shared/mixins/loader_manager.dart';
import '../../shared/utils/app_snackbar.dart';

class ContentsController extends GetxController with LoaderManager {
  final _courseRepository = CourseRepository();
  final _moduleRepository = ModuleRepository();
  final _lessonRepository = LessonRepository();
  final _materialRepository = MaterialRepository();
  final _quizRepository = QuizRepository();

  // Controllers para formulários
  final courseSearchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadCourses();
    loadMaterials();
    loadQuizzes();
  }

  @override
  void onClose() {
    searchController.dispose();
    courseSearchController.dispose();
    super.onClose();
  }

  String selectedSubModule = 'list';
  
  var courses = <CourseModel>[];
  var materials = <MaterialModel>[];
  var quizzes = <QuizModel>[];
  
  var filteredCourses = <CourseModel>[];
  var filteredMaterials = <MaterialModel>[];
  var filteredQuizzes = <QuizModel>[];

  bool isSearchMode = false;
  final TextEditingController searchController = TextEditingController();

  // Dados para criação/edição de conteúdo
  CourseModel? selectedCourse;
  CourseModel? courseToEdit;
  var currentModules = <ModuleModel>[];
  var currentLessons = <int, List<LessonModel>>{};
  
  // Tipos de aula
  final List<String> lessonTypes = ['video', 'material', 'quiz'];
  
  // Cache do número de módulos por curso
  Map<int, int> modulesCount = {};

  bool get isInListMode => selectedSubModule == 'list';

  Future<void> loadCourses() async {
    changeLoading(true);

    final response = await _courseRepository.getAllCourses();

    if (response.success && response.data != null) {
      courses = response.data!;
      filteredCourses = List.from(courses);
      
      // Carregar número de módulos para cada curso
      await _loadModulesCount();
    } else {
      courses = [];
      filteredCourses = [];
      AppSnackbar.to.success(response.message);
    }

    changeLoading(false);
  }

  Future<void> _loadModulesCount() async {
    modulesCount.clear();
    
    for (final course in courses) {
      if (course.id != null) {
        final modulesResponse = await _moduleRepository.getModulesByCourseId(course.id!);
        if (modulesResponse.success && modulesResponse.data != null) {
          modulesCount[course.id!] = modulesResponse.data!.length;
        } else {
          modulesCount[course.id!] = 0;
        }
      }
    }
    update();
  }

  int getModulesCount(int? courseId) {
    if (courseId == null) return 0;
    return modulesCount[courseId] ?? 0;
  }

  Future<void> loadMaterials() async {
    final response = await _materialRepository.getAllMaterials();
    if (response.success && response.data != null) {
      materials = response.data!;
      filteredMaterials = List.from(materials);
    }
  }

  Future<void> loadQuizzes() async {
    final response = await _quizRepository.getAllQuizzes();
    if (response.success && response.data != null) {
      quizzes = response.data!;
      filteredQuizzes = List.from(quizzes);
    }
  }

  // Buscar cursos
  void searchCourses(String query) {
    if (query.isEmpty) {
      filteredCourses = List.from(courses);
    } else {
      filteredCourses = courses
          .where((course) =>
              course.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    update();
  }

  // Buscar materiais
  void searchMaterials(String query) {
    if (query.isEmpty) {
      filteredMaterials = List.from(materials);
    } else {
      filteredMaterials = materials
          .where((material) =>
              material.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    update();
  }

  // Buscar quizzes
  void searchQuizzes(String query) {
    if (query.isEmpty) {
      filteredQuizzes = List.from(quizzes);
    } else {
      filteredQuizzes = quizzes
          .where((quiz) =>
              quiz.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    update();
  }

  // Navegação
  void goToCreateContent() {
    selectedSubModule = 'create_content';
    clearContentForm();
    update();
  }

  void goToEditContent(CourseModel course) {
    selectedSubModule = 'edit_content';
    courseToEdit = course;
    loadContentFormDataForEdit(course);
    update();
  }

  void backToList() {
    selectedSubModule = 'list';
    clearContentForm();
    update();
  }

  // Adicionar novo módulo
  void addModule() {
    final newModule = ModuleModel(
      title: '',
      orderIndex: currentModules.length + 1,
      courseId: selectedCourse?.id,
    );
    currentModules.add(newModule);
    currentLessons[currentModules.length - 1] = [];
    update();
  }

  // Remover módulo
  void removeModule(int index) {
    if (index < currentModules.length) {
      currentModules.removeAt(index);
      currentLessons.remove(index);
      // Reordenar índices
      for (int i = 0; i < currentModules.length; i++) {
        currentModules[i] = currentModules[i].copyWith(orderIndex: i + 1);
      }
      update();
    }
  }

  // Adicionar aula ao módulo
  void addLesson(int moduleIndex) {
    if (currentLessons[moduleIndex] == null) {
      currentLessons[moduleIndex] = [];
    }
    currentLessons[moduleIndex]!.add(
      LessonModel(
        title: '',
        type: 'video',
        orderIndex: currentLessons[moduleIndex]!.length + 1,
        moduleId: 0, // Será definido quando salvar
      ),
    );
    update();
  }

  // Remover aula
  void removeLesson(int moduleIndex, int lessonIndex) {
    if (currentLessons[moduleIndex] != null &&
        lessonIndex < currentLessons[moduleIndex]!.length) {
      currentLessons[moduleIndex]!.removeAt(lessonIndex);
      update();
    }
  }

  // Atualizar título do módulo
  void updateModuleTitle(int index, String title) {
    if (index < currentModules.length) {
      currentModules[index] = currentModules[index].copyWith(title: title);
      update();
    }
  }

  // Atualizar dados da aula
  void updateLessonTitle(int moduleIndex, int lessonIndex, String title) {
    if (currentLessons[moduleIndex] != null &&
        lessonIndex < currentLessons[moduleIndex]!.length) {
      currentLessons[moduleIndex]![lessonIndex] = 
          currentLessons[moduleIndex]![lessonIndex].copyWith(title: title);
      update();
    }
  }

  // Método removido pois LessonModel não tem description

  void updateLessonType(int moduleIndex, int lessonIndex, String type) {
    if (currentLessons[moduleIndex] != null &&
        lessonIndex < currentLessons[moduleIndex]!.length) {
      currentLessons[moduleIndex]![lessonIndex] = 
          currentLessons[moduleIndex]![lessonIndex].copyWith(type: type);
      update(); // Atualizar UI para mostrar campos corretos
    }
  }

  void updateLessonVideoId(int moduleIndex, int lessonIndex, String videoId) {
    if (currentLessons[moduleIndex] != null &&
        lessonIndex < currentLessons[moduleIndex]!.length) {
      currentLessons[moduleIndex]![lessonIndex] = 
          currentLessons[moduleIndex]![lessonIndex].copyWith(videoId: videoId);
      update();
    }
  }

  void updateLessonMaterialId(int moduleIndex, int lessonIndex, int? materialId) {
    if (currentLessons[moduleIndex] != null &&
        lessonIndex < currentLessons[moduleIndex]!.length) {
      currentLessons[moduleIndex]![lessonIndex] = 
          currentLessons[moduleIndex]![lessonIndex].copyWith(materialId: materialId);
      update();
    }
  }

  void updateLessonQuizId(int moduleIndex, int lessonIndex, int? quizId) {
    if (currentLessons[moduleIndex] != null &&
        lessonIndex < currentLessons[moduleIndex]!.length) {
      currentLessons[moduleIndex]![lessonIndex] = 
          currentLessons[moduleIndex]![lessonIndex].copyWith(quizId: quizId);
      update();
    }
  }

  // Criar novo conteúdo
  Future<void> createContent() async {
    changeLoadingCreating(true);

    try {
      // Criar os módulos e aulas
      for (int i = 0; i < currentModules.length; i++) {
        final moduleWithCourseId = currentModules[i].copyWith(
          courseId: selectedCourse?.id,
          orderIndex: i + 1,
        );

        final moduleResponse = await _moduleRepository.createModule(moduleWithCourseId);
        
        if (moduleResponse.success && moduleResponse.data != null) {
          final createdModule = moduleResponse.data!;
          
          // Criar as aulas para este módulo
          if (currentLessons[i] != null) {
            for (int j = 0; j < currentLessons[i]!.length; j++) {
              final lessonWithModuleId = currentLessons[i]![j].copyWith(
                moduleId: createdModule.id,
                orderIndex: j + 1,
              );

              await _lessonRepository.createLesson(lessonWithModuleId);
            }
          }
        }
      }

      AppSnackbar.to.success('Conteúdo criado com sucesso!');
      backToList();
      loadCourses(); // Recarregar para atualizar contadores
    } catch (e) {
      AppSnackbar.to.error('Erro ao criar conteúdo: $e');
    }

    changeLoadingCreating(false);
  }

  // Carregar conteúdo para edição
  Future<void> loadContentFormDataForEdit(CourseModel course) async {
    changeLoading(true);
    
    selectedCourse = course;
    
    // Carregar módulos do curso
    final modulesResponse = await _moduleRepository.getModulesByCourseId(course.id!);
    if (modulesResponse.success && modulesResponse.data != null) {
      currentModules = modulesResponse.data!;
      
      // Carregar aulas para cada módulo
      currentLessons.clear();
      for (int i = 0; i < currentModules.length; i++) {
        final moduleId = currentModules[i].id!;
        final lessonsResponse = await _lessonRepository.getLessonsByModuleId(moduleId);
        if (lessonsResponse.success && lessonsResponse.data != null) {
          currentLessons[i] = lessonsResponse.data!;
        } else {
          currentLessons[i] = [];
        }
      }
    }
    
    changeLoading(false);
    update();
  }

  // Atualizar conteúdo
  Future<void> updateContent() async {
    changeLoadingEditing(true);

    try {
      // Atualizar módulos e aulas
      for (int i = 0; i < currentModules.length; i++) {
        final module = currentModules[i];
        
        if (module.id != null) {
          // Atualizar módulo existente
          final updatedModule = module.copyWith(orderIndex: i + 1);
          await _moduleRepository.updateModule(updatedModule);
          
          // Atualizar aulas
          if (currentLessons[i] != null) {
            for (int j = 0; j < currentLessons[i]!.length; j++) {
              final lesson = currentLessons[i]![j];
              final updatedLesson = lesson.copyWith(
                moduleId: module.id,
                orderIndex: j + 1,
              );
              
              if (lesson.id != null) {
                await _lessonRepository.updateLesson(updatedLesson);
              } else {
                await _lessonRepository.createLesson(updatedLesson);
              }
            }
          }
        } else {
          // Criar novo módulo
          final newModule = module.copyWith(
            courseId: selectedCourse?.id,
            orderIndex: i + 1,
          );
          
          final moduleResponse = await _moduleRepository.createModule(newModule);
          if (moduleResponse.success && moduleResponse.data != null) {
            final createdModule = moduleResponse.data!;
            
            // Criar aulas para este novo módulo
            if (currentLessons[i] != null) {
              for (int j = 0; j < currentLessons[i]!.length; j++) {
                final lessonWithModuleId = currentLessons[i]![j].copyWith(
                  moduleId: createdModule.id,
                  orderIndex: j + 1,
                );
                await _lessonRepository.createLesson(lessonWithModuleId);
              }
            }
          }
        }
      }

      AppSnackbar.to.success('Conteúdo atualizado com sucesso!');
      backToList();
      loadCourses(); // Recarregar para atualizar contadores
    } catch (e) {
      AppSnackbar.to.error('Erro ao atualizar conteúdo: $e');
    }

    changeLoadingEditing(false);
  }

  // Selecionar curso e carregar dados existentes
  Future<void> selectCourse(CourseModel? course) async {
    if (course == null) return;
    
    selectedCourse = course;
    
    // Se estiver editando, carregar módulos e aulas existentes
    if (selectedSubModule == 'edit_content' || course.id != null) {
      await loadContentDataForCourse(course);
    } else {
      // Se estiver criando novo, limpar dados
      currentModules.clear();
      currentLessons.clear();
    }
    
    update();
  }

  // Carregar dados existentes do curso
  Future<void> loadContentDataForCourse(CourseModel course) async {
    if (course.id == null) return;
    
    changeLoading(true);
    
    try {
      // Carregar módulos do curso
      final modulesResponse = await _moduleRepository.getModulesByCourseId(course.id!);
      if (modulesResponse.success && modulesResponse.data != null) {
        currentModules = modulesResponse.data!;
        
        // Carregar aulas para cada módulo
        currentLessons.clear();
        for (int i = 0; i < currentModules.length; i++) {
          final moduleId = currentModules[i].id!;
          final lessonsResponse = await _lessonRepository.getLessonsByModuleId(moduleId);
          if (lessonsResponse.success && lessonsResponse.data != null) {
            currentLessons[i] = lessonsResponse.data!;
          } else {
            currentLessons[i] = [];
          }
        }
      } else {
        currentModules.clear();
        currentLessons.clear();
      }
    } catch (e) {
      debugPrint('Erro ao carregar dados do curso: $e');
      currentModules.clear();
      currentLessons.clear();
    }
    
    changeLoading(false);
    update();
  }

  // Limpar formulário
  void clearContentForm() {
    selectedCourse = null;
    courseToEdit = null;
    currentModules.clear();
    currentLessons.clear();
    courseSearchController.clear();
  }
} 