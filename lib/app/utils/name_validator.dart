
bool isValidName(String text){
  return RegExp(r"^[a-zA-ZñÑáéíóúÁÉÍÓÚ\s]+$").hasMatch(text);
}

