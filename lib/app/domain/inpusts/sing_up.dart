import 'package:firebase_auth/firebase_auth.dart';


class SingUpData {
  final String name, lastname, email, password;

  SingUpData({
    required this.name, 
    required this.lastname, 
    required this.email, 
    required this.password,
});
}
