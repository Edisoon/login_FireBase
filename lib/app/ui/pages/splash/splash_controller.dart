
import 'package:flutter_application_1/app/domain/repositories/authentication_repository.dart';
import 'package:flutter_application_1/app/ui/routes/routes.dart';
import 'package:flutter_meedu/meedu.dart';

class SplashContoller extends SimpleNotifier{
  final _authRepository = Get.i.find<AuthenticationRepository>();

  String? _routeName;
  String? get routeName => _routeName;


  SplashContoller(){
    _init();
  }

 void _init() async {
    final user = await _authRepository.user;
    _routeName = user != null ? Routes.HOME : Routes.LOGIN;
    notify();
  }
}