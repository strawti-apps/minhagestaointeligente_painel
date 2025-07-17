import 'package:get/get.dart';

import '../../shared/middlewares/auth_middleware.dart';
import 'quizzes_controller.dart';
import 'quizzes_page.dart';

class QuizzesRoutes {
  static List<GetPage> get routes => [
    GetPage(
      name: QuizzesPage.route,
      page: () => const QuizzesPage(),
      binding: BindingsBuilder(() {
        Get.put<QuizzesController>(QuizzesController());
      }),
      middlewares: [
        AdminMiddleware(),
      ],
    ),
  ];
} 