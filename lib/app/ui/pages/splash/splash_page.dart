import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/app/ui/global_controllers/session_controller.dart';
import 'package:flutter_application_1/app/ui/pages/splash/splash_controller.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_meedu/screen_utils.dart';
import 'package:flutter_meedu/router.dart' as router;

final splashProvider = SimpleProvider(
  (_) => SplashContoller(sessionProvider.read),
);

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<SplashContoller>(
      provider: splashProvider,
      onAfterFirstLayout: (_, __) {
        if (!context.isTablet) {
          SystemChrome.setPreferredOrientations(
            [
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
            ],
          );
        }
      },
      onChange: (_, controller) {
        final routeName = controller.routeName;
        if (routeName != null) {
          router.pushReplacementNamed(routeName);
        }
      },
      builder: (_, __) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          ),
        );
      },
    );
  }
}
