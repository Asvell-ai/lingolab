class Validators {
  static bool isEmailValid(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  static bool isPasswordValid(String password) {
    return password.length >= 6;
  }

  static bool isPhoneValid(String phone) {
    final phoneRegex = RegExp(r'^\+?[0-9]{7,15}$');
    return phoneRegex.hasMatch(phone.replaceAll(' ', ''));
  }

  static bool isNotEmpty(String value) {
    return value.trim().isNotEmpty;
  }

  static bool isNameValid(String name) {
    return name.trim().length >= 2;
  }
}
