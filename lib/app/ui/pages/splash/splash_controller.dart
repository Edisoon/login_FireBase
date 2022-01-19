
import 'package:flutter_application_1/app/domain/repositories/authentication_repository.dart';
import 'package:flutter_application_1/app/ui/global_controllers/session_controller.dart';
import 'package:flutter_application_1/app/ui/routes/routes.dart';
import 'package:flutter_meedu/meedu.dart';

class SplashContoller extends SimpleNotifier{
  final SessionController _sessionController;
  final _authRepository = Get.i.find<AuthenticationRepository>();

  String? _routeName;
  String? get routeName => _routeName;


  SplashContoller(this._sessionController){
    _init();
  }

 void _init() async {
    final user = await _authRepository.user;
    if(user != null){
      _routeName = Routes.HOME;
      _sessionController.setUser(user); 
    }else{
      _routeName = Routes.LOGIN;
    }
    notify();
  }
}