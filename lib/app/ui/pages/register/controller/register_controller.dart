import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/app/domain/inpusts/sing_up.dart';
import 'package:flutter_application_1/app/domain/repositories/sing_up_repository.dart';
import 'package:flutter_application_1/app/domain/responses/sing_up_response.dart';
import 'package:flutter_application_1/app/ui/global_controllers/session_controller.dart';
import 'package:flutter_application_1/app/ui/pages/register/controller/register_state.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

class RegisterController extends StateNotifier<RegisterState> {
  final SessionController _sessionController; 
  RegisterController(this._sessionController) : super(RegisterState.initialState);

  final GlobalKey<FormState> formKey = GlobalKey();


  final _singUnRepository = Get.i.find<SingUpRepository>();

  Future<SingUpResponse> submit() async {
    final response = await _singUnRepository.register(
      SingUpData(
        name: state.name,
        lastname: state.lastname,
        email: state.email,
        password: state.password,
      ),
    );
    if(response.error == null ){
      _sessionController.setUser(response.user!);
    }

    return response;
  }

  void onNameChanged(String text) {
    state = state.copyWith(name: text);
  }

  void onLastNameChanged(String text) {
    state = state.copyWith(lastname: text);
  }

  void onEmailChanged(String text) {
    state = state.copyWith(email: text);
  }

  void onPasswordChanged(String text) {
    state = state.copyWith(password: text);
  }

  void onvPasswordChanged(String text) {
    state = state.copyWith(vPassword: text);
  }
}
