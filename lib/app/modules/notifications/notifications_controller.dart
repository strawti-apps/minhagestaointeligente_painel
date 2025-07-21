import 'package:get/get.dart';

class NotificationItem {
  final int id;
  final String titulo;
  final String mensagem;
  final DateTime data;
  bool lida;
  NotificationItem({
    required this.id,
    required this.titulo,
    required this.mensagem,
    required this.data,
    this.lida = false,
  });
}

class NotificationsController extends GetxController {
  List<NotificationItem> notifications = [
    NotificationItem(
      id: 1,
      titulo: 'Vacinação contra gripe',
      mensagem: 'Campanha de vacinação contra gripe começa amanhã nas UBS.',
      data: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    NotificationItem(
      id: 2,
      titulo: 'Obras na Av. Central',
      mensagem:
          'Avenida Central estará interditada para recapeamento nos próximos dias.',
      data: DateTime.now().subtract(const Duration(days: 1)),
    ),
    NotificationItem(
      id: 3,
      titulo: 'Novo horário da coleta de lixo',
      mensagem:
          'A coleta de lixo passará a ser realizada às 7h a partir da próxima semana.',
      data: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ];

  void marcarComoLida(NotificationItem item) {
    item.lida = true;
    update();
  }
}
