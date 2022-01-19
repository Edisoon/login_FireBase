import 'package:flutter/widgets.dart' show FormState, GlobalKey;
import 'package:flutter_application_1/app/domain/repositories/authentication_repository.dart';
import 'package:flutter_application_1/app/domain/responses/sing_in_response.dart';
import 'package:flutter_application_1/app/ui/global_controllers/session_controller.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

class LoginController extends SimpleNotifier {
  final SessionController _sessionController;
  String _email = '', _password = '';
  final _authenticationRepository = Get.i.find<AuthenticationRepository>();
  final GlobalKey<FormState> formkey = GlobalKey();

  LoginController(this._sessionController);

  void onEmailChanged(String text) {
    _email = text;
  }

  void onPasswordChanged(String text) {
    _password = text;
  }

  Future<SingInResponse> submit() async{
    final response= await _authenticationRepository.singInWithEmailAndPassword(
      _email,
      _password,
    );

    if(response.error == null){
      _sessionController.setUser(response.user!);
    }

    return response;
  }
}
