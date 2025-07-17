import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infra/models/quiz_model.dart';
import '../../infra/models/question_model.dart';
import '../../infra/models/option_model.dart';
import '../../infra/repositories/quiz_repository.dart';
import '../../shared/mixins/loader_manager.dart';
import '../../shared/utils/app_snackbar.dart';

class QuizzesController extends GetxController with LoaderManager {
  final _quizRepository = QuizRepository();

  final quizTitleController = TextEditingController();
  
  // Tipos estáticos para questionários
  final List<String> quizTypes = ['Prova', 'Teste'];
  String selectedQuizType = 'Prova';

  @override
  void onInit() {
    super.onInit();
    loadQuizzes();
  }

  @override
  void onClose() {
    searchController.dispose();
    quizTitleController.dispose();
    super.onClose();
  }

  String selectedSubModule = 'list';
  var quizzes = <QuizModel>[];

  bool isSearchMode = false;
  final TextEditingController searchController = TextEditingController();
  var filteredQuizzes = <QuizModel>[];

  QuizModel? quizToEdit;

  // Dados para criação/edição de questionário
  var questions = <QuestionModel>[];
  var questionsOptions = <int, List<OptionModel>>{};
  
  // Cache do número de questões por quiz
  Map<int, int> questionsCount = {};

  bool get isInListMode => selectedSubModule == 'list';

  Future<void> loadQuizzes() async {
    changeLoading(true);

    final response = await _quizRepository.getAllQuizzes();

    if (response.success && response.data != null) {
      quizzes = response.data!;
      filteredQuizzes = List.from(quizzes);
      
      // Carregar número de questões para cada quiz
      await _loadQuestionsCount();
    } else {
      quizzes = [];
      filteredQuizzes = [];

      AppSnackbar.to.success(response.message);
    }

    changeLoading(false);
  }

  Future<void> _loadQuestionsCount() async {
    questionsCount.clear();
    
    for (final quiz in quizzes) {
      if (quiz.id != null) {
        final questionsResponse = await _quizRepository.getQuestionsByQuizId(quiz.id!);
        if (questionsResponse.success && questionsResponse.data != null) {
          questionsCount[quiz.id!] = questionsResponse.data!.length;
        } else {
          questionsCount[quiz.id!] = 0;
        }
      }
    }
    update();
  }

  int getQuestionsCount(int? quizId) {
    if (quizId == null) return 0;
    return questionsCount[quizId] ?? 0;
  }

  // Adicionar nova questão
  void addQuestion() {
    final newQuestion = QuestionModel(
      text: '',
      orderIndex: questions.length + 1,
    );
    questions.add(newQuestion);
    questionsOptions[questions.length - 1] = [];
    update();
  }

  // Remover questão
  void removeQuestion(int index) {
    if (index < questions.length) {
      questions.removeAt(index);
      questionsOptions.remove(index);
      // Reordenar índices
      for (int i = 0; i < questions.length; i++) {
        questions[i] = questions[i].copyWith(orderIndex: i + 1);
      }
      update();
    }
  }

  // Adicionar alternativa à questão
  void addOption(int questionIndex) {
    if (questionsOptions[questionIndex] == null) {
      questionsOptions[questionIndex] = [];
    }
    questionsOptions[questionIndex]!.add(
      OptionModel(text: '', isCorrect: false),
    );
    update();
  }

  // Remover alternativa
  void removeOption(int questionIndex, int optionIndex) {
    if (questionsOptions[questionIndex] != null &&
        optionIndex < questionsOptions[questionIndex]!.length) {
      questionsOptions[questionIndex]!.removeAt(optionIndex);
      update();
    }
  }

  // Atualizar texto da questão
  void updateQuestionText(int index, String text) {
    if (index < questions.length) {
      questions[index] = questions[index].copyWith(text: text);
    }
  }

  // Atualizar texto da alternativa
  void updateOptionText(int questionIndex, int optionIndex, String text) {
    if (questionsOptions[questionIndex] != null &&
        optionIndex < questionsOptions[questionIndex]!.length) {
      questionsOptions[questionIndex]![optionIndex] = 
          questionsOptions[questionIndex]![optionIndex].copyWith(text: text);
    }
  }

  // Marcar alternativa como correta
  void setCorrectOption(int questionIndex, int optionIndex) {
    if (questionsOptions[questionIndex] != null) {
      // Desmarcar todas as alternativas desta questão
      for (int i = 0; i < questionsOptions[questionIndex]!.length; i++) {
        questionsOptions[questionIndex]![i] = 
            questionsOptions[questionIndex]![i].copyWith(isCorrect: false);
      }
      // Marcar apenas a selecionada como correta
      if (optionIndex < questionsOptions[questionIndex]!.length) {
        questionsOptions[questionIndex]![optionIndex] = 
            questionsOptions[questionIndex]![optionIndex].copyWith(isCorrect: true);
      }
      update();
    }
  }

  // Criar novo questionário
  Future<void> createQuiz() async {
    changeLoadingCreating(true);

    try {
      // Criar o questionário principal
      final newQuiz = QuizModel(
        title: quizTitleController.text.trim(),
        type: selectedQuizType,
        createdAt: DateTime.now(),
      );

      final quizResponse = await _quizRepository.createQuiz(newQuiz);

      if (quizResponse.success && quizResponse.data != null) {
        final createdQuiz = quizResponse.data!;

        // Criar as questões
        for (int i = 0; i < questions.length; i++) {
          final questionWithQuizId = questions[i].copyWith(
            quizId: createdQuiz.id,
            orderIndex: i + 1,
          );

          final questionResponse = await _quizRepository.createQuestion(questionWithQuizId);
          
          if (questionResponse.success && questionResponse.data != null) {
            final createdQuestion = questionResponse.data!;
            
            // Criar as alternativas para esta questão
            if (questionsOptions[i] != null) {
              for (final option in questionsOptions[i]!) {
                final optionWithQuestionId = option.copyWith(
                  questionId: createdQuestion.id,
                );
                await _quizRepository.createOption(optionWithQuestionId);
              }
            }
          }
        }

        // Adiciona à lista local
        quizzes.add(createdQuiz);
        filteredQuizzes.add(createdQuiz);
        
        // Atualiza o cache de questões
        questionsCount[createdQuiz.id!] = questions.length;

        AppSnackbar.to.success('Questionário criado com sucesso', success: true);
        backToList();
      } else {
        AppSnackbar.to.success('Erro ao criar questionário');
      }
    } catch (e) {
      AppSnackbar.to.success('Erro ao criar questionário: $e');
    } finally {
      changeLoadingCreating(false);
    }
  }

  // Editar questionário existente
  Future<void> updateQuiz() async {
    if (quizToEdit == null) return;

    changeLoadingEditing(true);

    try {
      final updatedQuiz = quizToEdit!.copyWith(
        title: quizTitleController.text.trim(),
        type: selectedQuizType,
      );

      final response = await _quizRepository.updateQuiz(updatedQuiz);

      if (response.success && response.data != null) {
        final updatedQuizResult = response.data!;

        // Atualiza na lista principal
        final mainIndex = quizzes.indexWhere(
          (quiz) => quiz.id == updatedQuizResult.id,
        );
        if (mainIndex != -1) {
          quizzes[mainIndex] = updatedQuizResult;
        }

        // Atualiza na lista filtrada
        final filteredIndex = filteredQuizzes.indexWhere(
          (quiz) => quiz.id == updatedQuizResult.id,
        );
        if (filteredIndex != -1) {
          filteredQuizzes[filteredIndex] = updatedQuizResult;
        }

        AppSnackbar.to.success('Questionário atualizado com sucesso', success: true);
        backToList();
      } else {
        AppSnackbar.to.success('Erro ao atualizar questionário');
      }
    } catch (e) {
      AppSnackbar.to.success('Erro ao atualizar questionário: $e');
    } finally {
      changeLoadingEditing(false);
    }
  }

  Future<void> goToDeleteItem(QuizModel quiz) async {
    if (quiz.id == null) return;

    changeLoadingDeleting(true);

    final response = await _quizRepository.deleteQuiz(quiz.id!);

    if (response.success) {
      quizzes.removeWhere((q) => q.id == quiz.id);
      filteredQuizzes.removeWhere((q) => q.id == quiz.id);

      AppSnackbar.to.success('Questionário excluído com sucesso', success: true);
    } else {
      AppSnackbar.to.success('Erro ao excluir questionário: ${response.message}');
    }

    changeLoadingDeleting(false);
  }

  void showDeleteQuizConfirmation(QuizModel quiz) {
    Get.dialog(
      AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: Text(
          'Tem certeza que deseja excluir o questionário "${quiz.title}"?\n\nEsta ação não pode ser desfeita.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              goToDeleteItem(quiz);
            },
            child: const Text(
              'Excluir',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void searchQuizzes(String query) {
    if (query.isEmpty) {
      filteredQuizzes = List.from(quizzes);
      isSearchMode = false;
    } else {
      isSearchMode = true;
      filteredQuizzes = quizzes.where((quiz) {
        return quiz.title.toLowerCase().contains(query.toLowerCase()) ||
               (quiz.type.toLowerCase().contains(query.toLowerCase()));
      }).toList();
    }
    update();
  }

  void goToCreateQuiz() {
    selectedSubModule = 'create_quiz';
    clearForm();
    update();
  }

  void goToEditQuiz(QuizModel quiz) {
    selectedSubModule = 'edit_quiz';
    quizToEdit = quiz;
    loadFormDataForEdit(quiz);
    update();
  }

  void backToList() {
    selectedSubModule = 'list';
    clearForm();
    update();
  }

  void clearForm() {
    quizTitleController.clear();
    selectedQuizType = 'Prova';
    questions.clear();
    questionsOptions.clear();
    quizToEdit = null;
  }

  Future<void> loadFormDataForEdit(QuizModel quiz) async {
    quizTitleController.text = quiz.title;
    selectedQuizType = quiz.type;
    
    // Carregar questões e alternativas existentes
    if (quiz.id != null) {
      changeLoading(true);
      
      // Carregar questões
      final questionsResponse = await _quizRepository.getQuestionsByQuizId(quiz.id!);
      if (questionsResponse.success && questionsResponse.data != null) {
        questions = questionsResponse.data!;
        questionsOptions.clear();
        
        // Carregar alternativas para cada questão
        for (int i = 0; i < questions.length; i++) {
          final question = questions[i];
          if (question.id != null) {
            final optionsResponse = await _quizRepository.getOptionsByQuestionId(question.id!);
            if (optionsResponse.success && optionsResponse.data != null) {
              questionsOptions[i] = optionsResponse.data!;
            }
          }
        }
      }
      
      changeLoading(false);
      update();
    }
  }


} 