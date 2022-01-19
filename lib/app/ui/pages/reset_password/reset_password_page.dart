import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/domain/responses/reset_password_response.dart';
import 'package:flutter_application_1/app/ui/global_widgets/custom_input_field.dart';
import 'package:flutter_application_1/app/ui/global_widgets/dialogs/dialogs.dart';
import 'package:flutter_application_1/app/ui/global_widgets/dialogs/progress_dialog.dart';
import 'package:flutter_application_1/app/ui/pages/reset_password/controller/reset_password_controller.dart';
import 'package:flutter_application_1/app/ui/routes/routes.dart';
import 'package:flutter_application_1/app/utils/email_validator.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_meedu/router.dart' as router;

import 'package:flutter_meedu/meedu.dart';

final resetPasswordProvider = SimpleProvider(
  (_) => ResetPasswordController(),
);

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<ResetPasswordController>(
      provider: resetPasswordProvider,
      builder: (_, controller) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
        ),
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomInputField(
                    label: "Email",
                    onChanged: controller.onEmailChaged,
                    inputType: TextInputType.emailAddress,
                  ),
                  ElevatedButton(
                    onPressed: () => _submit(context),
                    child: const Text("Enviar"),
                  ),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submit(BuildContext context) async {
    final controller = resetPasswordProvider.read;

    if (isValidEmail(controller.email)) {
      ProgressDialog.show(context);
      final response = await controller.submit();
      Navigator.pop(context);
      if (response == ResetPasswordResponse.ok) {
        // String emailInputDelete = "";
        Dialogs.alert(context,
            title: "Listo!",
            content: "Email enviado, revisa tu bandeja de entrada");
            // controller.onEmailChaged(emailInputDelete);
      } else {
        String errorMessage = '';
        switch (response) {
          case ResetPasswordResponse.networkRequestFailed:
            errorMessage = "Revisa tu conexion a internet";
            break;
          case ResetPasswordResponse.userDisabled:
            errorMessage = "Usuario Desabilitado";
            break;
          case ResetPasswordResponse.userNotFound:
            errorMessage = "Usuario no encontrado";
            break;
          case ResetPasswordResponse.tooManyRequests:
            errorMessage = "Demasiadas peticiones al servidor";
            break;
          default:
            errorMessage = "Error desconocido";
            break;
        }
        Dialogs.alert(context, title: "Error", content: errorMessage);
      }
    } else {
      Dialogs.alert(context, content: "Email invalido");
    }
  }
}
