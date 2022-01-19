import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/domain/responses/sing_in_response.dart';
import 'package:flutter_application_1/app/ui/global_widgets/dialogs/dialogs.dart';
import 'package:flutter_application_1/app/ui/global_widgets/dialogs/progress_dialog.dart';
import 'package:flutter_application_1/app/ui/routes/routes.dart';
import '../login_page.dart' show loginProvider;
import 'package:flutter_meedu/router.dart' as router;

Future<void> sendLoginForm(BuildContext context) async {
  final controller = loginProvider.read;
  final isValidForm = controller.formkey.currentState!.validate();
  if (isValidForm) {
    ProgressDialog.show(context);
    final response = await controller.submit();
    router.pop();
    if (response.error != null) {
     late String errorMessage;

      switch (response.error){
        
        case SingInError.networkRequestFailed:
          errorMessage = "Revise la conexion a internet";
          break;
        case SingInError.userDisabled:
          errorMessage = "Usuario Desabilitado";
          break;
        case SingInError.userNotFound:
          errorMessage = "Revise la conexion a internet";
          break;
        case SingInError.wrongPassword:
          errorMessage = "Contraseña incorrecta";
          break;
        case SingInError.tooManyRequests:
          errorMessage = "Demasiada peticiones al servidor, intente mas tarde";
          break;
        case SingInError.unknown:
        default:
          errorMessage = "Error desconocido, intente mas tarde";
          break;
      }

      Dialogs.alert(context, title: "Error", content: errorMessage);
    } else {
      router.pushReplacementNamed(Routes.HOME);
    }
  }
}
