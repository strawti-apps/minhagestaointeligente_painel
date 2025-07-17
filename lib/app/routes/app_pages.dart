import 'package:get/get.dart';

import '../modules/access/access_routes.dart';
import '../modules/auth/auth_routes.dart';
import '../modules/classes/classes_routes.dart';
import '../modules/contents/contents_routes.dart';
import '../modules/dashboard/dashboard_routes.dart';
import '../modules/main_courses/main_courses_routes.dart';
import '../modules/materials/materials_routes.dart';
import '../modules/people/people_routes.dart';
import '../modules/quizzes/quizzes_routes.dart';
import '../modules/splash/splash_routes.dart';
import '../modules/users/users_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    ...SplashRoutes.routes,
    ...AuthRoutes.routes,
    ...DashboardRoutes.routes,
    ...MainCoursesRoutes.routes,
    ...MaterialsRoutes.routes,
    ...ClassesRoutes.routes,
    ...QuizzesRoutes.routes,
    ...ContentsRoutes.routes,
    ...AccessRoutes.routes,
    ...UsersRoutes.routes,
    ...PeopleRoutes.routes,
  ];
}
