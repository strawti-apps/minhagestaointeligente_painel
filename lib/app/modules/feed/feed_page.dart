import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/navbar/navbar_desktop_widget.dart';
import 'feed_controller.dart';
import 'widgets/feed_comments_widget.dart';
import 'widgets/feed_header_widget.dart';
import 'widgets/feed_list_widget.dart';

class FeedPage extends StatelessWidget {
  static const String route = '/feed';
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: const NavbarMobileWidget(),
      body: Row(
        children: [
          const NavbarDesktopWidget(),
          Expanded(
            child: GetBuilder<FeedController>(
              builder: (controller) {
                return Column(
                  children: [
                    const FeedHeaderWidget(),
                    Expanded(
                      child:
                          controller.mostrarComentarios &&
                                  controller.postSelecionado != null
                              ? FeedCommentsWidget(
                                post: controller.postSelecionado!,
                              )
                              : FeedListWidget(),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
