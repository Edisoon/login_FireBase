import 'package:firebase_auth/firebase_auth.dart';

class SingInResponse {
  final SingInError? error;
  final User? user;

  SingInResponse(this.error, this.user);
}

enum SingInError {
  networkRequestFailed,
  userDisabled,
  userNotFound,
  wrongPassword,
  tooManyRequests,
  unknown
}
SingInError stringToSingInError(String code) {
  switch (code) {
    case "user-disabled":
      return SingInError.userDisabled;
    case "user-not-found":
      return SingInError.userNotFound;
    case "network-request-failed":
      return SingInError.networkRequestFailed;
    case "wrong-password":
      return SingInError.wrongPassword;
    case "too-many-requests":
      return SingInError.tooManyRequests;
    default:
      return SingInError.unknown;
  }
}
