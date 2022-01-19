import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/domain/inpusts/sing_up.dart';
import 'package:flutter_application_1/app/domain/responses/sing_up_response.dart';
import 'package:flutter_application_1/app/ui/global_widgets/dialogs/dialogs.dart';
import 'package:flutter_application_1/app/ui/global_widgets/dialogs/progress_dialog.dart';
import 'package:flutter_application_1/app/ui/routes/routes.dart';
import '../register_page.dart' show registerProvider;
import 'package:flutter_meedu/router.dart' as router;

Future<void> sendRegisterForm(BuildContext context) async {
  final controller = registerProvider.read;
  final isValidForm = controller.formKey.currentState!.validate();

  if (isValidForm) {
    ProgressDialog.show(context);
    final response = await controller.submit();
    router.pop();
    if (response.error != null) {
      late String errorMessage;

      switch(response.error){
        
        case SingUpError.emailAlreadyInUse:
          errorMessage = "El email colocado ya esta en uso";
          break;
        case SingUpError.weakPassword:
          errorMessage = "La contraseña es muy debil";
          break;
        case SingUpError.networkRequestFailed:
          errorMessage = "Revise la conexion a internet";
          break;
        case SingUpError.tooManyRequests:
          errorMessage = "Demasiados intentos al servidor";
          break;
        case SingUpError.unknown:
        default:
          errorMessage = "Error desconocido, intenta de nuevo";
          break;
      }
      Dialogs.alert(context, title: "Error", content:errorMessage);
    } else {
      router.pushNamedAndRemoveUntil(
        Routes.HOME,
      );
    }
  } else {
    Dialogs.alert(context, title: "Error",content: "Campos invalidos");
  }
}
