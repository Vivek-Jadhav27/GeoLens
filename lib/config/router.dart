import 'package:flutter/material.dart';
import '../model/app_route.dart';
import '../screen/history_screen.dart';
import '../screen/main_screen.dart';
import '../screen/result_screen.dart';
import '../screen/setting_screen.dart';
import '../screen/splash_screen.dart';
import '../screen/upload_screen.dart';
import '../screen/home_page.dart';

class AppRouter {
  static List<AppRoute> routes() => [
    AppRoute(route: Routes.history, view: const HistoryScreen()),
    AppRoute(route: Routes.home, view: const HomePage()),
    AppRoute(route: Routes.main, view: const MainScreen()),
    AppRoute(route: Routes.result, view: const ResultScreen()),
    AppRoute(route: Routes.settings, view: const SettingScreen()),
    AppRoute(route: Routes.splash, view: const SplashScreen()),
    AppRoute(route: Routes.upload, view: const UploadScreen()),

  ];
  static List allProviders() => [];
  static Route<dynamic> generateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => routes()
          .firstWhere(
            (element) => element.route == settings.name,
            orElse: () => AppRoute(
              route: Routes.home,
              view: const HomePage(),
            ),
          )
          .view,
    );
  }
}

class Routes {
  static const String history = '/history';
  static const String home = '/home';
  static const String main = '/main';
  static const String result = '/result';
  static const String splash = '/splash';
  static const String settings = '/settings';
  static const String upload = '/upload';
}
