import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minha_gestao_inteligente_painel/app/themes/app_colors.dart';

import '../../../shared/widgets/generic_grid_widget.dart';
import '../feed_controller.dart';

class FeedListWidget extends StatelessWidget {
  const FeedListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FeedController>();
    if (controller.posts.isEmpty) {
      return const Center(child: Text('Nenhum item no feed.'));
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GenericGridWidget<FeedPost>(
        items: controller.posts,
        aspectRatioCalculator: (baseRatio, items) => 1.1,
        itemBuilder: (post) {
          return InkWell(
            highlightColor: Colors.transparent,
            onTap: () => controller.selecionarPost(post),
            child: Card(
              color: post.bloqueado ? Colors.grey[200] : Colors.white,
              elevation: post.bloqueado ? 0 : 2,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: post.bloqueado ? AppColors.error : AppColors.card,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (post.imagemUrl != null && post.imagemUrl!.isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          post.imagemUrl!,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    const SizedBox(height: 8),
                    Text(
                      post.conteudo,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Por: ${post.autor}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      'Comentários: ${post.comentarios.length}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                    if (post.bloqueado)
                      const Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text(
                          'BLOQUEADO',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(
                            post.bloqueado ? Icons.lock_open : Icons.lock,
                          ),
                          tooltip: post.bloqueado ? 'Desbloquear' : 'Bloquear',
                          onPressed:
                              () => controller.bloquearOuDesbloquearPost(post),
                        ),
                        IconButton(
                          icon: const Icon(Icons.comment),
                          tooltip: 'Ver comentários',
                          onPressed: () => controller.selecionarPost(post),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
