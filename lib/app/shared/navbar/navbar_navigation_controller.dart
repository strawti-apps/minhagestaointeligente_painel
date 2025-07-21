import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infra/services/user_service.dart';
import 'navbar_navigation_items.dart';

class NavbarNavigationController extends GetxController {
  int currentIndex = 0;
  List<SidebarNavItem> _currentNavItems = [];

  List<SidebarNavItem> get currentNavItems => _currentNavItems;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateNavItems();
      _syncCurrentIndexFromRoute();
    });
  }

  void _updateNavItems() {
    final previousCount = _currentNavItems.length;
    _currentNavItems = sidebarNavItems;
    debugPrint(
      'NavbarController: Items atualizados. Anterior: $previousCount, Atual: ${_currentNavItems.length}',
    );
    update();
  }

  void changeTab(int index) {
    if (index >= _currentNavItems.length) return;
    if (index == currentIndex) return;

    final targetRoute = _currentNavItems[index].route;

    currentIndex = index;
    update();
    Get.toNamed(targetRoute);
  }

  void _syncCurrentIndexFromRoute() {
    final currentRoute = Get.currentRoute;

    // Atualizar lista de itens baseado no role atual
    _updateNavItems();

    // Encontra o índice correspondente à rota atual
    for (int i = 0; i < _currentNavItems.length; i++) {
      if (_currentNavItems[i].route == currentRoute) {
        currentIndex = i;
        update();
        return;
      }
    }
  }

  // Método para atualizar navbar quando o role do usuário muda
  void updateNavbarForRole() {
    final user = UserService.currentUser;
    debugPrint(
      'NavbarController: Atualizando navbar para usuário: ${user?.email} - Role: ${user?.role}',
    );

    _updateNavItems();
    _syncCurrentIndexFromRoute();

    debugPrint(
      'NavbarController: Navbar atualizada com ${_currentNavItems.length} itens',
    );
  }
}
