import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/ui/global_widgets/custom_input_field.dart';
import 'package:flutter_application_1/app/ui/global_widgets/rounded_button.dart';
import 'package:flutter_application_1/app/ui/pages/login/login_page.dart';
import 'package:flutter_application_1/app/ui/pages/login/utils/send_login_form.dart';
import 'package:flutter_application_1/app/utils/email_validator.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:flutter_application_1/app/ui/routes/routes.dart';
import 'package:flutter_meedu/src/utils/screen_utils.dart';
import 'package:flutter_svg/svg.dart';

class LoginForm extends StatelessWidget {
  LoginForm({
    Key? key,
  }) : super(key: key);
  
  final _controller = loginProvider.read;


  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final padding = context.mediaQueryPadding;
    final height = context.height - padding.top - padding.bottom;
    // MediaQuery.of(context).size;
    return ListView(
      children: [
        SizedBox(
          height: height,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _controller.formkey,
                child: Align(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 380,
                    ),
                    child: Column(
                      mainAxisAlignment: context.isTablet
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.end,
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: SvgPicture.asset(
                            'assets/images/${isDark ? 'dark' : 'light'}/welcome.svg',
                            width: 300,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomInputField(
                          label: "Email",
                          onChanged: _controller.onEmailChanged,
                          inputType: TextInputType.emailAddress,
                          validator: (text) {
                            if (isValidEmail(text!)) {
                              return null;
                            }
                            return "Email invalido";
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomInputField(
                          label: "Contraseña",
                          onChanged: _controller.onPasswordChanged,
                          isPassword: true,
                          validator: (text) {
                            if (text!.trim().length >= 6) {
                              return null;
                            }
                            return "Contraseña incorrecta";
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () => router
                                  .pushNamed(Routes.RESET_PASSWORD),
                              child: const Text(
                                  "Olvidaste tu contraseña?"),
                            ),
                            const SizedBox(width: 10),
                            RoundedButton(
                              text: "Iniciar Sesion",
                              onPressed: () => sendLoginForm(context),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Aun no tienes cuenta?",
                            ),
                            TextButton(
                              onPressed: () =>
                                  router.pushNamed(Routes.REGISTER),
                              child: const Text(
                                "Registrate",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                            ),
                          ],
                        ),
                        if (!context.isTablet)
                          const SizedBox(
                            height: 50,
                          )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
