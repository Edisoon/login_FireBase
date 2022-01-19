import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/app/domain/responses/reset_password_response.dart';
import 'package:flutter_application_1/app/domain/responses/sing_in_response.dart';

abstract class AuthenticationRepository {
  Future<User?> get user;
  Future<void> singOut();
  Future<SingInResponse> singInWithEmailAndPassword(
    String email,
    String password,
  );

  Future<ResetPasswordResponse> sendResetPasswordLink(String email);
}
