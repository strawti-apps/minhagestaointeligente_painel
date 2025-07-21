import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'app/modules/splash/splash_page.dart';
import 'app/routes/app_pages.dart';
import 'app/shared/navbar/navbar_navigation_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await SupabaseConfig.initialize();
  // await UserService.initialize();
  // Get.put(AuthService(), permanent: true);
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDHSd0h8tl_0yRWADzwMw_4PIvu-UXyfb0",
      appId: "1:817244558564:web:ee8fc5a0a181406ce308f1",
      messagingSenderId: "817244558564",
      projectId: "minhagestaointeligente-painel",
    ),
  );

  Get.put(NavbarNavigationController(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Minha Gestão Inteligente',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
      ),
      initialRoute: SplashPage.route,
      getPages: AppPages.pages,
      defaultTransition: kIsWeb ? Transition.noTransition : Transition.fadeIn,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR'), Locale('en', 'US')],
    );
  }
}
