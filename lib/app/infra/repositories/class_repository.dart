import 'package:strawti_utils/strawti_utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/class_model.dart';
import '../models/enrollment_model.dart';

class ClassRepository extends StrautilsTryThis {
  static final _classesTable = Supabase.instance.client.from('classes');
  static final _enrollmentsTable = Supabase.instance.client.from('enrollments');

  FStrautilsResponse<ClassModel?> getClassById(int id) {
    return tryThis(() async {
      final response = await _classesTable.select().eq('id', id).maybeSingle();
      if (response == null) {
        return StrautilsResponse.warning('Turma não encontrada');
      }
      return StrautilsResponse.success(ClassModel.fromMap(response));
    });
  }

  FStrautilsResponse<List<ClassModel>> getAllClasses() {
    return tryThis(() async {
      final response = await _classesTable.select().order('title', ascending: true);
      final list = (response as List).map((json) => ClassModel.fromMap(json)).toList();
      return StrautilsResponse.success(list);
    });
  }

  FStrautilsResponse<List<ClassModel>> getClassesByCourseId(int courseId) {
    return tryThis(() async {
      final response = await _classesTable.select().eq('courseId', courseId).order('title', ascending: true);
      final list = (response as List).map((json) => ClassModel.fromMap(json)).toList();
      return StrautilsResponse.success(list);
    });
  }

  FStrautilsResponse<ClassModel> createClass(ClassModel classModel) {
    return tryThis(() async {
      final response = await _classesTable.insert(classModel.toMap()).select().single();
      return StrautilsResponse.success(ClassModel.fromMap(response));
    });
  }

  FStrautilsResponse<ClassModel> updateClass(ClassModel classModel) {
    return tryThis(() async {
      if (classModel.id == null) {
        return StrautilsResponse.warning('ID da turma não fornecido para atualização');
      }
      final response = await _classesTable.update(classModel.toMap()).eq('id', classModel.id!).select().single();
      return StrautilsResponse.success(ClassModel.fromMap(response));
    });
  }

  FStrautilsResponse<bool> deleteClass(int id) {
    return tryThis(() async {
      await _classesTable.delete().eq('id', id);
      return StrautilsResponse.success(true);
    });
  }

  FStrautilsResponse<EnrollmentModel> enrollUserInClass(int userId, int classId) {
    return tryThis(() async {
      final enrollment = EnrollmentModel(userId: userId, classId: classId);
      final response = await _enrollmentsTable.insert(enrollment.toMap()).select().single();
      return StrautilsResponse.success(EnrollmentModel.fromMap(response));
    });
  }

  FStrautilsResponse<bool> unenrollUserFromClass(int userId, int classId) {
    return tryThis(() async {
      await _enrollmentsTable.delete().eq('userId', userId).eq('classId', classId);
      return StrautilsResponse.success(true);
    });
  }

  FStrautilsResponse<List<EnrollmentModel>> getClassEnrollments(int classId) {
    return tryThis(() async {
          final response = await _enrollmentsTable.select().eq('classId', classId);
    final list = (response as List).map((json) => EnrollmentModel.fromMap(json)).toList();
    return StrautilsResponse.success(list);
    });
  }

  FStrautilsResponse<bool> isUserEnrolledInClass(int userId, int classId) {
    return tryThis(() async {
      final response = await _enrollmentsTable.select('id').eq('userId', userId).eq('classId', classId);
      return StrautilsResponse.success(response.isNotEmpty);
    });
  }
} 