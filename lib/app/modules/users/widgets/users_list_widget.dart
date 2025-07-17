import 'package:flutter/material.dart';

import '../../../shared/widgets/generic_grid_widget.dart';
import '../users_controller.dart';
import 'users_card_widget.dart';

class UsersListWidget extends StatelessWidget {
  final UsersController controller;

  const UsersListWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    if (controller.filteredUsers.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_outline, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Nenhum usuário encontrado',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GenericGridWidget(
        items: controller.filteredUsers,
        aspectRatioCalculator: (baseRatio, items) => 2.0,
        itemBuilder: (user) {
          return UsersCardWidget(
            user: user,
            onDelete: () => controller.deleteUser(user),
          );
        },
      ),
    );
  }
} 