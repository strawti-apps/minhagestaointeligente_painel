import 'package:strawti_utils/strawti_utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/course_model.dart';

class CourseRepository extends StrautilsTryThis {
  static final _coursesTable = Supabase.instance.client.from('content_courses');

  FStrautilsResponse<CourseModel?> getCourseById(int id) {
    return tryThis(() async {
      final response = await _coursesTable.select().eq('id', id).maybeSingle();
      if (response == null) {
        return StrautilsResponse.warning('Curso não encontrado');
      }
      return StrautilsResponse.success(CourseModel.fromMap(response));
    });
  }

  FStrautilsResponse<List<CourseModel>> getAllCourses() {
    return tryThis(() async {
      final response = await _coursesTable.select().order('title', ascending: true);
      final list = (response as List).map((json) => CourseModel.fromMap(json)).toList();
      return StrautilsResponse.success(list);
    });
  }

  FStrautilsResponse<CourseModel> createCourse(CourseModel course) {
    return tryThis(() async {
      final response = await _coursesTable.insert(course.toMap()).select().single();
      return StrautilsResponse.success(CourseModel.fromMap(response));
    });
  }

  FStrautilsResponse<CourseModel> updateCourse(CourseModel course) {
    return tryThis(() async {
      if (course.id == null) {
        return StrautilsResponse.warning('ID do curso não fornecido para atualização');
      }
      final response = await _coursesTable.update(course.toMap()).eq('id', course.id!).select().single();
      return StrautilsResponse.success(CourseModel.fromMap(response));
    });
  }

  FStrautilsResponse<bool> deleteCourse(int id) {
    return tryThis(() async {
      await _coursesTable.delete().eq('id', id);
      return StrautilsResponse.success(true);
    });
  }
} 