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
}
