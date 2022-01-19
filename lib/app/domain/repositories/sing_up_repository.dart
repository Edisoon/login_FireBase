import 'package:flutter_application_1/app/domain/inpusts/sing_up.dart';
import 'package:flutter_application_1/app/domain/responses/sing_up_response.dart';

abstract class SingUpRepository {
  Future<SingUpResponse> register(SingUpData data);
}
