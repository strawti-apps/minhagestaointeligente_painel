import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minha_gestao_inteligente_painel/app/themes/app_colors.dart';

import '../notifications_controller.dart';

class NotificationsListWidget extends StatelessWidget {
  const NotificationsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NotificationsController>();
    if (controller.notifications.isEmpty) {
      return const Center(child: Text('Nenhuma notificação.'));
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: controller.notifications.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final notification = controller.notifications[index];
        return Card(
          color: notification.lida ? Colors.grey[100] : Colors.white,
          child: ListTile(
            leading: Icon(
              notification.lida
                  ? Icons.notifications_none
                  : Icons.notifications_active,
              color: notification.lida ? Colors.black : Colors.green,
            ),
            title: Text(
              notification.titulo,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notification.mensagem),
                const SizedBox(height: 4),
                Text(
                  'Enviada em: ${notification.data.day.toString().padLeft(2, '0')}/${notification.data.month.toString().padLeft(2, '0')}/${notification.data.year} ${notification.data.hour.toString().padLeft(2, '0')}:${notification.data.minute.toString().padLeft(2, '0')}',
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
            trailing:
                notification.lida
                    ? const Text('Lida', style: TextStyle(color: Colors.green))
                    : TextButton(
                      onPressed: () => controller.marcarComoLida(notification),
                      child: const Text(
                        'Marcar como lida',
                        style: TextStyle(color: AppColors.textPrimary),
                      ),
                    ),
          ),
        );
      },
    );
  }
}
