import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infra/models/user_model.dart';
import '../../../shared/mixins/loader_manager.dart';

class RecentActivity {
  final String userName;
  final String initials;
  final String description;
  final DateTime date;
  final String status;
  final Color statusColor;

  RecentActivity({
    required this.userName,
    required this.initials,
    required this.description,
    required this.date,
    required this.status,
    required this.statusColor,
  });
}

class AdminDashboardController extends GetxController with LoaderManager {
  // Estados principais
  String? _errorMessage;
  UserModel? _currentUser;
  final int _totalCourses = 5;
  final int _totalStudents = 120;
  final int _totalQuizzes = 8;
  final String _averageProgress = '75%';

  // Getters
  String? get errorMessage => _errorMessage;
  UserModel? get currentUser => _currentUser;
  int get totalCourses => _totalCourses;
  int get totalStudents => _totalStudents;
  int get totalQuizzes => _totalQuizzes;
  String get averageProgress => _averageProgress;

  bool get hasError => _errorMessage != null;

  @override
  void onInit() {
    super.onInit();
    _mockCurrentUser();
  }

  void _mockCurrentUser() {
    _currentUser = UserModel(
      id: 1,
      authUserId: 'mocked',
      firstName: 'Admin',
      lastName: null,
      email: 'admin@mock.com',
      role: 'admin',
      createdAt: DateTime.now(),
      mustChangePassword: false,
    );
    update(['currentUser']);
  }

  void refreshData() {
    // Apenas mock, não faz nada
    update();
  }

  void refreshTotals() {
    // Apenas mock, não faz nada
    update();
  }

  void refreshRecentActivities() {
    // Apenas mock, não faz nada
    update();
  }

  void navigateToSection(String section) {
    // Mock: apenas printa
    debugPrint('Navegar para seção: $section');
  }

  void logout() {
    Get.offAllNamed('/login_email');
  }

  void _clearError() {
    _errorMessage = null;
    update(['error']);
  }

  void _setError(String errorMessage) {
    _errorMessage = errorMessage;
    update(['error']);
  }

  void retry() {
    // Apenas mock, não faz nada
    update();
  }
}
