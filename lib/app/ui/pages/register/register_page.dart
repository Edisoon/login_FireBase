import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/app/ui/global_controllers/session_controller.dart';
import 'package:flutter_application_1/app/ui/global_widgets/custom_input_field.dart';
import 'package:flutter_application_1/app/ui/global_widgets/rounded_button.dart';
import 'package:flutter_application_1/app/ui/pages/register/controller/register_state.dart';
import 'package:flutter_application_1/app/ui/pages/register/utils/send_register_form.dart';
import 'package:flutter_application_1/app/ui/utils/colors.dart';
import 'package:flutter_application_1/app/utils/email_validator.dart';
import 'package:flutter_application_1/app/utils/name_validator.dart';
import 'package:flutter_application_1/app/utils/password_validator.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

import 'controller/register_controller.dart';

final registerProvider = StateProvider<RegisterController, RegisterState>(
  (_) => RegisterController(sessionProvider.read),
);

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      elevation: 0,
    );
    final padding = context.mediaQueryPadding;
    final height = context.height -
        padding.top -
        padding.bottom -
        appBar.preferredSize.height;
    final isDark = context.isDarkMode;
    final statusBarColor = isDark ? primaryDarkColor : primaryLigthColor;
    final elevatedButtonStyle = ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 15),
    );
    return ProviderListener<RegisterController>(
      provider: registerProvider,
      builder: (_, controller) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: const Text("Registro de Usuario"),
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: statusBarColor,
              systemNavigationBarColor: statusBarColor,
              systemNavigationBarDividerColor: statusBarColor,
            ),
          ),
          body: ListView(
            children: [
              SizedBox(
                height: height,
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Container(
                    color: Colors.transparent,
                    width: double.infinity,
                    height: double.infinity,
                    padding: const EdgeInsets.all(15),
                    child: Align(
                      child: Form(
                        key: controller.formKey,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 360),
                          child: Column(
                            mainAxisAlignment: context.isTablet
                                ? MainAxisAlignment.center
                                : MainAxisAlignment.end,
                            children: [
                              CustomInputField(
                                label: "Nombre",
                                onChanged: controller.onNameChanged,
                                validator: (text) {
                                  return isValidName(text!)
                                      ? null
                                      : "Nombre invalido";
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomInputField(
                                label: "Apellido",
                                onChanged: controller.onLastNameChanged,
                                validator: (text) {
                                  return isValidName(text!)
                                      ? null
                                      : "Apellido invalido";
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomInputField(
                                label: "E-mail",
                                validator: (text) {
                                  return isValidEmail(text!)
                                      ? null
                                      : "Email Invalido";
                                },
                                inputType: TextInputType.emailAddress,
                                onChanged: controller.onEmailChanged,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomInputField(
                                label: "Contraseña",
                                isPassword: true,
                                onChanged: controller.onPasswordChanged,
                                validator: (text) {
                                  // if (text.trim().length >= 6) {
                                  //   return null;
                                  // }
                                  // return "Invalid Password";
                                  return isValidPassword(text!)
                                      ? null
                                      : "La contraseña debe contener mayusculas, minusculas, un numero y ser mayor a 6 digitos";
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Consumer(
                                builder: (_, ref, __) {
                                  ref.watch(registerProvider
                                      .select((state) => state.password));
                                  return CustomInputField(
                                    label: "Verificar Contraseña",
                                    isPassword: true,
                                    onChanged: controller.onvPasswordChanged,
                                    validator: (text) {
                                      if (controller.state.password != text) {
                                        return "Las contraseñas no coninciden";
                                      }
                                      // if (text.trim().length >= 6) {
                                      //   return null;
                                      // }
                                      // return "Invalid Password";
                                      return isValidPassword(text!)
                                          ? null
                                          : "La contraseña debe contener mayusculas, minusculas, un numero y ser mayor a 6 digitos";
                                    },
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              RoundedButton(
                                text: "Registar",
                                onPressed: () => sendRegisterForm(context),
                              ),
                              if(!context.isTablet)const SizedBox(height: 20,)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
