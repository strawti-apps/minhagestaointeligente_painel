import 'package:strawti_utils/strawti_utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/enrollment_model.dart';
import '../models/enrollment_with_details_model.dart';

class EnrollmentRepository extends StrautilsTryThis {
  static final _enrollmentsTable = Supabase.instance.client.from('enrollments');

  // Criar múltiplos enrollments (para o módulo de acessos)
  FStrautilsResponse<List<EnrollmentModel>> createMultipleEnrollments(
    List<int> userIds,
    int classId,
  ) {
    return tryThis(() async {
      final enrollments =
          userIds
              .map(
                (userId) => EnrollmentModel(
                  userId: userId,
                  classId: classId,
                  createdAt: DateTime.now(),
                ),
              )
              .toList();

      final response =
          await _enrollmentsTable
              .insert(enrollments.map((e) => e.toMap()).toList())
              .select();

      final createdEnrollments =
          (response as List)
              .map((json) => EnrollmentModel.fromMap(json))
              .toList();

      return StrautilsResponse.success(createdEnrollments);
    });
  }

  // Obter todos os enrollments com dados dos usuários e turmas
  FStrautilsResponse<List<EnrollmentWithDetailsModel>> getAllEnrollmentsWithDetails() {
    return tryThis(() async {
      final response = await _enrollmentsTable
          .select('''
            id,
            userId,
            classId,
            createdAt,
            users!inner(id, authUserId, firstName, lastName, email, role, createdAt),
            classes!inner(id, title, courseId, thumbnailUrl, sendWelcomeEmail, createdAt)
          ''')
          .order('createdAt', ascending: false);

      final enrollments = (response as List)
          .map((json) => EnrollmentWithDetailsModel.fromMap(json))
          .toList();

      return StrautilsResponse.success(enrollments);
    });
  }

  // Obter enrollments de uma turma específica com dados dos usuários
  FStrautilsResponse<List<EnrollmentWithDetailsModel>> getEnrollmentsByClass(
    int classId,
  ) {
    return tryThis(() async {
      final response = await _enrollmentsTable
          .select('''
            id,
            userId,
            classId,
            createdAt,
            users!inner(id, authUserId, firstName, lastName, email, role, createdAt),
            classes!inner(id, title, courseId, thumbnailUrl, sendWelcomeEmail, createdAt)
          ''')
          .eq('classId', classId)
          .order('createdAt', ascending: false);

      final enrollments = (response as List)
          .map((json) => EnrollmentWithDetailsModel.fromMap(json))
          .toList();

      return StrautilsResponse.success(enrollments);
    });
  }

  // Obter enrollments de um usuário específico com dados das turmas
  FStrautilsResponse<List<EnrollmentWithDetailsModel>> getEnrollmentsByUser(
    int userId,
  ) {
    return tryThis(() async {
      final response = await _enrollmentsTable
          .select('''
            id,
            userId,
            classId,
            createdAt,
            users!inner(id, authUserId, firstName, lastName, email, role, createdAt),
            classes!inner(id, title, courseId, thumbnailUrl, sendWelcomeEmail, createdAt)
          ''')
          .eq('userId', userId)
          .order('createdAt', ascending: false);

      final enrollments = (response as List)
          .map((json) => EnrollmentWithDetailsModel.fromMap(json))
          .toList();

      return StrautilsResponse.success(enrollments);
    });
  }

  // Verificar se usuários já estão inscritos em uma turma
  FStrautilsResponse<List<int>> getAlreadyEnrolledUsers(
    List<int> userIds,
    int classId,
  ) {
    return tryThis(() async {
      final response = await _enrollmentsTable
          .select('userId')
          .eq('classId', classId)
          .inFilter('userId', userIds);

      final enrolledUserIds =
          (response as List).map((item) => item['userId'] as int).toList();

      return StrautilsResponse.success(enrolledUserIds);
    });
  }

  // Remover enrollment específico
  FStrautilsResponse<bool> removeEnrollment(int enrollmentId) {
    return tryThis(() async {
      await _enrollmentsTable.delete().eq('id', enrollmentId);
      return StrautilsResponse.success(true);
    });
  }

  // Remover múltiplos enrollments
  FStrautilsResponse<bool> removeMultipleEnrollments(List<int> enrollmentIds) {
    return tryThis(() async {
      await _enrollmentsTable.delete().inFilter('id', enrollmentIds);
      return StrautilsResponse.success(true);
    });
  }

  // Buscar enrollments por texto (nome do usuário ou turma)
  FStrautilsResponse<List<EnrollmentWithDetailsModel>> searchEnrollments(
    String query,
  ) {
    return tryThis(() async {
      // Buscar todos os enrollments primeiro
      final allEnrollmentsResponse = await getAllEnrollmentsWithDetails();
      
      if (!allEnrollmentsResponse.success) {
        return StrautilsResponse.error(allEnrollmentsResponse.message);
      }
      
      final allEnrollments = allEnrollmentsResponse.data!;
      final queryLower = query.toLowerCase();
      
      // Filtrar no lado do cliente para maior flexibilidade
      final filteredEnrollments = allEnrollments.where((enrollment) {
        final userFullName = enrollment.userFullName.toLowerCase();
        final className = enrollment.className.toLowerCase();
        
        return userFullName.contains(queryLower) || 
               className.contains(queryLower);
      }).toList();

      return StrautilsResponse.success(filteredEnrollments);
    });
  }
}
