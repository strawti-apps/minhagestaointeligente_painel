import 'package:strawti_utils/strawti_utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/option_model.dart';
import '../models/question_model.dart';
import '../models/quiz_model.dart';

class QuizRepository extends StrautilsTryThis {
  late final SupabaseQueryBuilder _quizzesTable;
  late final SupabaseQueryBuilder _questionsTable;
  late final SupabaseQueryBuilder _optionsTable;

  QuizRepository() {
    _quizzesTable = Supabase.instance.client.from('questionnaire_quizzes');
    _questionsTable = Supabase.instance.client.from('questionnaire_questions');
    _optionsTable = Supabase.instance.client.from('questionnaire_options');
  }
  
  // Obter um questionário pelo ID
  FStrautilsResponse<QuizModel?> getQuizById(int id) {
    return tryThis(() async {
      final response = await _quizzesTable.select().eq('id', id).maybeSingle();
      if (response == null) {
        return StrautilsResponse.warning('Questionário não encontrado');
      }
      return StrautilsResponse.success(QuizModel.fromMap(response));
    });
  }
  
  // Obter todos os questionários
  FStrautilsResponse<List<QuizModel>> getAllQuizzes() {
    return tryThis(() async {
      final response = await _quizzesTable.select().order('title', ascending: true);
      return StrautilsResponse.success((response as List).map((json) => QuizModel.fromMap(json)).toList());
    });
  }
  
  // Obter questionários pelo ID do curso
  FStrautilsResponse<List<QuizModel>> getQuizzesByCourseId(int courseId) {
    return tryThis(() async {
      final response = await _quizzesTable.select().eq('courseId', courseId).order('title', ascending: true);
      return StrautilsResponse.success((response as List).map((json) => QuizModel.fromMap(json)).toList());
    });
  }
  
  // Criar questionário
  FStrautilsResponse<QuizModel> createQuiz(QuizModel quiz) {
    return tryThis(() async {
      final response = await _quizzesTable.insert(quiz.toMap()).select().single();
      return StrautilsResponse.success(QuizModel.fromMap(response));
    });
  }
  
  // Atualizar questionário
  FStrautilsResponse<QuizModel> updateQuiz(QuizModel quiz) {
    return tryThis(() async {
      if (quiz.id == null) {
        return StrautilsResponse.warning('ID do questionário não fornecido para atualização');
      }
      final response = await _quizzesTable.update(quiz.toMap()).eq('id', quiz.id!).select().single();
      return StrautilsResponse.success(QuizModel.fromMap(response));
    });
  }
  
  // Deletar questionário
  FStrautilsResponse<bool> deleteQuiz(int id) {
    return tryThis(() async {
      await _quizzesTable.delete().eq('id', id);
      return StrautilsResponse.success(true);
    });
  }
  
  // Obter questões de um questionário
  FStrautilsResponse<List<QuestionModel>> getQuestionsByQuizId(int quizId) {
    return tryThis(() async {
      final response = await _questionsTable.select().eq('quizId', quizId).order('orderIndex', ascending: true);
      return StrautilsResponse.success((response as List).map((json) => QuestionModel.fromMap(json)).toList());
    });
  }
  
  // Criar questão
  FStrautilsResponse<QuestionModel> createQuestion(QuestionModel question) {
    return tryThis(() async {
      final response = await _questionsTable.insert(question.toMap()).select().single();
      return StrautilsResponse.success(QuestionModel.fromMap(response));
    });
  }
  
  // Atualizar questão
  FStrautilsResponse<QuestionModel> updateQuestion(QuestionModel question) {
    return tryThis(() async {
      if (question.id == null) {
        return StrautilsResponse.warning('ID da questão não fornecido para atualização');
      }
      final response = await _questionsTable.update(question.toMap()).eq('id', question.id!).select().single();
      return StrautilsResponse.success(QuestionModel.fromMap(response));
    });
  }
  
  // Deletar questão
  FStrautilsResponse<bool> deleteQuestion(int id) {
    return tryThis(() async {
      await _questionsTable.delete().eq('id', id);
      return StrautilsResponse.success(true);
    });
  }
  
  // Obter opções de uma questão
  FStrautilsResponse<List<OptionModel>> getOptionsByQuestionId(int questionId) {
    return tryThis(() async {
      final response = await _optionsTable.select().eq('questionId', questionId);
      return StrautilsResponse.success((response as List).map((json) => OptionModel.fromMap(json)).toList());
    });
  }
  
  // Criar opção
  FStrautilsResponse<OptionModel> createOption(OptionModel option) {
    return tryThis(() async {
      final response = await _optionsTable.insert(option.toMap()).select().single();
      return StrautilsResponse.success(OptionModel.fromMap(response));
    });
  }
  
  // Atualizar opção
  FStrautilsResponse<OptionModel> updateOption(OptionModel option) {
    return tryThis(() async {
      if (option.id == null) {
        return StrautilsResponse.warning('ID da opção não fornecido para atualização');
      }
      final response = await _optionsTable.update(option.toMap()).eq('id', option.id!).select().single();
      return StrautilsResponse.success(OptionModel.fromMap(response));
    });
  }
  
  // Deletar opção
  FStrautilsResponse<bool> deleteOption(int id) {
    return tryThis(() async {
      await _optionsTable.delete().eq('id', id);
      return StrautilsResponse.success(true);
    });
  }
} 