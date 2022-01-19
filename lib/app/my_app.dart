import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/app/ui/global_controllers/theme_controller.dart';
import 'package:flutter_application_1/app/ui/routes/app_routes.dart';
import 'package:flutter_application_1/app/ui/routes/routes.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_meedu/router.dart' as router;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return Consumer(builder: (_,ref,__){
      final theme = ref.watch(themeProvider);
      return MaterialApp(
        title: 'Flutter Login',
        navigatorKey: router.navigatorKey,
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.SPLASH,
        darkTheme: theme.darkTheme,
        theme: theme.lightTheme,
        themeMode: theme.mode,
        navigatorObservers: [router.observer],
        routes: appRoutes,
      );
    });
  }
}
