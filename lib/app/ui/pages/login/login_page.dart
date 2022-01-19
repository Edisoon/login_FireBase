import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/ui/global_controllers/session_controller.dart';
import 'package:flutter_application_1/app/ui/pages/login/controller/login_controller.dart';
import 'package:flutter_application_1/app/ui/pages/login/widgets/login_form.dart';
import 'package:flutter_application_1/app/ui/utils/colors.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_svg/flutter_svg.dart';

final loginProvider = SimpleProvider(
  (_) => LoginController(sessionProvider.read),
);

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    return ProviderListener<LoginController>(
      provider: loginProvider,
      builder: (_, controller) {
        return Scaffold(
          body: OrientationBuilder(
            builder: (_, orientation) {
              if (orientation == Orientation.portrait) {
                return LoginForm();
              }
              return Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 16 / 9,
                            child: SvgPicture.asset(
                                "assets/images/${isDark ? 'dark' : 'light'}/team.svg"),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: LoginForm(),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
