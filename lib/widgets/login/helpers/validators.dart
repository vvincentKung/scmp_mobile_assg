bool validateEmail(value) {
  if (value == null || value.isEmpty) {
    return false;
  }
  if (!RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  ).hasMatch(value)) {
    return false;
  }
  return true;
}

bool validatePassword(value) {
  if (value == null || value.isEmpty) {
    return false;
  }
  if (!RegExp(r'^[a-zA-Z0-9]{6,10}$').hasMatch(value)) {
    return false;
  }
  return true;
}
