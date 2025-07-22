import 'package:get/get.dart';

import '../modules/access/access_routes.dart';
import '../modules/auth/auth_routes.dart';
import '../modules/classes/classes_routes.dart';
import '../modules/contents/contents_routes.dart';
import '../modules/dashboard/dashboard_routes.dart';
import '../modules/educacao/educacao_routes.dart';
import '../modules/feed/feed_routes.dart';
import '../modules/materials/materials_routes.dart';
import '../modules/notifications/notifications_routes.dart';
import '../modules/saude/saude_routes.dart';
import '../modules/splash/splash_routes.dart';
import '../modules/users/users_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    ...SplashRoutes.routes,
    ...AuthRoutes.routes,
    ...DashboardRoutes.routes,

    ...MaterialsRoutes.routes,
    ...ClassesRoutes.routes,

    ...ContentsRoutes.routes,
    ...AccessRoutes.routes,
    ...UsersRoutes.routes,
    ...saudeRoutes,
    ...feedRoutes,
    ...notificationsRoutes,
    ...educacaoRoutes,
  ];
}
