
import 'package:flutter_application_1/app/domain/repositories/authentication_repository.dart';
import 'package:flutter_application_1/app/domain/responses/reset_password_response.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

class ResetPasswordController extends SimpleNotifier{
  String _email = "";
  String get email => _email;

  final _authenticationRepository =  Get.i.find<AuthenticationRepository>();

  void onEmailChaged(String text){
    _email = text;
  }

  Future<ResetPasswordResponse> submit(){
    return _authenticationRepository.sendResetPasswordLink(email);
  }
}