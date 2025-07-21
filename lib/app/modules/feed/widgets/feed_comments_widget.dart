import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../feed_controller.dart';

class FeedCommentsWidget extends StatelessWidget {
  final FeedPost post;
  const FeedCommentsWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FeedController>();
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: controller.fecharComentarios,
                icon: const Icon(Icons.arrow_back),
                tooltip: 'Voltar',
              ),
              const SizedBox(width: 10),
              const Text(
                'Comentários',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(post.conteudo, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              itemCount: post.comentarios.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final comentario = post.comentarios[index];
                return ListTile(
                  title: Text(comentario.conteudo),
                  subtitle: Text('Por: ${comentario.autor}'),
                  trailing: Text(
                    '${comentario.data.hour.toString().padLeft(2, '0')}:${comentario.data.minute.toString().padLeft(2, '0')}',
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              DropdownButton<String>(
                value: controller.responderComo,
                items:
                    controller.opcoesResposta
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                onChanged: (value) {
                  if (value != null) {
                    controller.responderComo = value;
                    controller.update();
                  }
                },
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: controller.respostaController,
                  decoration: const InputDecoration(
                    hintText: 'Responder...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: controller.responderComentario,
                child: const Text('Responder'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
