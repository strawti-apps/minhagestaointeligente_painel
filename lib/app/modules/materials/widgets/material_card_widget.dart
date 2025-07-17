import 'package:flutter/material.dart';

import '../../../infra/models/material_model.dart';
import '../../../themes/app_colors.dart';
import '../materials_controller.dart';
import 'material_card_actions_widget.dart';

class MaterialCardWidget extends StatelessWidget {
  final MaterialModel material;
  final MaterialsController controller;

  const MaterialCardWidget({
    super.key,
    required this.material,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            MaterialBackgroundWidget(),
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topRight,
                  colors: [
                    Colors.black.withValues(alpha: 0.8),
                    Colors.black.withValues(alpha: 0.4),
                    AppColors.primaryDark.withValues(alpha: 0.2),
                  ],
                ),
              ),
            ),
            MaterialContentOverlayWidget(material: material),
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: MaterialCardActionsWidget(
                  item: material,
                  controller: controller,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MaterialBackgroundWidget extends StatelessWidget {
  const MaterialBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryDark.withValues(alpha: 0.8),
            AppColors.primaryDark.withValues(alpha: 0.6),
          ],
        ),
      ),
      child: const Icon(Icons.description, color: Colors.white, size: 48),
    );
  }
}

class MaterialContentOverlayWidget extends StatelessWidget {
  final MaterialModel material;

  const MaterialContentOverlayWidget({super.key, required this.material});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      right: 16,
      bottom: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Título
          Text(
            material.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 8),

          // Data de criação
          Text(
            'Criado em ${_formatDate(material.createdAt)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Data não disponível';

    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();

    return '$day/$month/$year';
  }
} 