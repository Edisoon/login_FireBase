

import 'package:flutter/widgets.dart' show Widget,BuildContext;
import 'package:flutter_application_1/app/ui/pages/login/login_page.dart';
import 'package:flutter_application_1/app/ui/pages/splash/splash_page.dart';
import 'routes.dart';

Map<String, Widget Function(BuildContext)> get appRoutes =>{
  Routes.SPLASH: (_)=> const SplashPage(),
  Routes.LOGIN: (_)=> const LoginPage(),
  Routes.HOME: (_)=> const SplashPage(),
};