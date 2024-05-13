class InputValidators {
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required!";
    }
    // Regular expression for email validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email address!";
    }
    return null; // Return null if validation passes
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required!";
    }

    final passwordRegex = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).{6,}$');
    if (!passwordRegex.hasMatch(value)) {
      return "Password must contain at least 1 letter, 1 digit, and have a minimum length of 6 characters!";
    }
    return null; // Return null if validation passes
  }
}
