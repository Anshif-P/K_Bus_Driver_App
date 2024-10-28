class Validations {
  static String? emailOrNumberValidation(String? value) {
    RegExp numberRegExp = RegExp(r'^\d+$');
    RegExp emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

    if (value == null || value.isEmpty) {
      return 'Please enter an email or a phone number';
    }
    if (!emailRegExp.hasMatch(value) && !numberRegExp.hasMatch(value)) {
      return 'Enter a correct email address or phone number';
    }
    return null;
  }

  static String? isPassword(String? value) {
    final hasUppercase = RegExp(r'[A-Z]');
    final hasLowercase = RegExp(r'[a-z]');
    final hasDigit = RegExp(r'\d');
    final hasSpecialCharacter = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    const minLength = 8;
    if (value == null || value.isEmpty) return 'Password is Required';
    if (value.length < minLength) {
      return 'Password must be at least $minLength characters long';
    }
    if (!hasLowercase.hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!hasDigit.hasMatch(value)) {
      return 'Password must contain at least one digit';
    }

    return null;
  }

  static String? emtyValidation(String? value) {
    if (value == null || value.trim() == '') {
      return 'fill the feild ';
    } else {
      return null;
    }
  }

  static String? vehicleNumberValidation(String? value) {
    RegExp vehicleRegExp = RegExp(r'^[A-Z]{2}\s\d{1,2}\s[A-Z]{0,2}\s?\d{4}$');

    if (value == null || value.isEmpty) {
      return 'Vehicle number is required';
    } else if (!vehicleRegExp.hasMatch(value)) {
      return 'Enter a valid vehicle number (e.g., KL 84 2046)';
    }
    return null;
  }

  static String? conformPasswordValidation(password, conPassword) {
    if (password != conPassword || password == null || password == '') {
      return 'enter correct password';
    } else {
      return null;
    }
  }

  static numberValidation(value) {
    RegExp numberRegExp = RegExp(r'^\d+$');
    if (value == null || !numberRegExp.hasMatch(value)) {
      return 'enter correct number';
    } else {
      return null;
    }
  }
}
