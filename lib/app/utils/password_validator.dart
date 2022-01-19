

bool isValidPassword(String text){
 return RegExp(r"^(?=.*[A-Z])(?=.*[a-z])(?=.*?[0-9]).{6,}$").hasMatch(text);
}