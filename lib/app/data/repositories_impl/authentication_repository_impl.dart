import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/app/domain/repositories/authentication_repository.dart';
import 'package:flutter_application_1/app/domain/responses/reset_password_response.dart';
import 'package:flutter_application_1/app/domain/responses/sing_in_response.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final FirebaseAuth _auth;
  User? _user;

  final Completer<void> _completer = Completer();

  AuthenticationRepositoryImpl(this._auth) {
    _init();
  }

  @override
  Future<User?> get user async {
    await _completer.future;
    return _user;
  }

  void _init() async {
    _auth.authStateChanges().listen(
      (User? user) {
        if (!_completer.isCompleted) {
          _completer.complete();
        }
        _user = user;
      },
    );
  }

  @override
  Future<void> singOut() {
    return _auth.signOut();
  }

  @override
  Future<SingInResponse> singInWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user!;
      return SingInResponse(null, user);
    } on FirebaseAuthException catch (e) {
      return SingInResponse(stringToSingInError(e.code), null);
    }
  }

  @override
  Future<ResetPasswordResponse> sendResetPasswordLink(String email) async {
   try {
    await _auth.sendPasswordResetEmail(email: email);
    return ResetPasswordResponse.ok;
   }on FirebaseAuthException catch (e) {
    return stringToResetPasswordResponse(e.code);
   }
  }
}
