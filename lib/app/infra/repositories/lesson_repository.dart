import 'package:strawti_utils/strawti_utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/lesson_model.dart';

class LessonRepository extends StrautilsTryThis {
  static final _lessonsTable = Supabase.instance.client.from('content_lessons');

  FStrautilsResponse<LessonModel?> getLessonById(int id) {
    return tryThis(() async {
      final response = await _lessonsTable.select().eq('id', id).maybeSingle();
      if (response == null) {
        return StrautilsResponse.warning('Aula não encontrada');
      }
      return StrautilsResponse.success(LessonModel.fromMap(response));
    });
  }

  FStrautilsResponse<List<LessonModel>> getAllLessons() {
    return tryThis(() async {
      final response = await _lessonsTable.select().order('orderIndex', ascending: true);
      final list = (response as List).map((json) => LessonModel.fromMap(json)).toList();
      return StrautilsResponse.success(list);
    });
  }

  FStrautilsResponse<List<LessonModel>> getLessonsByModuleId(int moduleId) {
    return tryThis(() async {
      final response = await _lessonsTable.select().eq('moduleId', moduleId).order('orderIndex', ascending: true);
      final list = (response as List).map((json) => LessonModel.fromMap(json)).toList();
      return StrautilsResponse.success(list);
    });
  }

  FStrautilsResponse<LessonModel> createLesson(LessonModel lesson) {
    return tryThis(() async {
      final response = await _lessonsTable.insert(lesson.toMap()).select().single();
      return StrautilsResponse.success(LessonModel.fromMap(response));
    });
  }

  FStrautilsResponse<LessonModel> updateLesson(LessonModel lesson) {
    return tryThis(() async {
      if (lesson.id == null) {
        return StrautilsResponse.warning('ID da aula não fornecido para atualização');
      }
      final response = await _lessonsTable.update(lesson.toMap()).eq('id', lesson.id!).select().single();
      return StrautilsResponse.success(LessonModel.fromMap(response));
    });
  }

  FStrautilsResponse<bool> deleteLesson(int id) {
    return tryThis(() async {
      await _lessonsTable.delete().eq('id', id);
      return StrautilsResponse.success(true);
    });
  }

  FStrautilsResponse<bool> updateLessonOrder(List<LessonModel> lessons) {
    return tryThis(() async {
      final updates = lessons.map((lesson) => {
        'id': lesson.id,
        'orderIndex': lesson.orderIndex,
      }).toList();
      await _lessonsTable.upsert(updates);
      return StrautilsResponse.success(true);
    });
  }
}