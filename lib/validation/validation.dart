typedef FormFieldValidator = String? Function(String? value);

String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  }
  // Regular expression for email validation
  // This regex checks for a typical email pattern, but it's not exhaustive
  // You might need to adjust it based on your specific requirements
  final RegExp emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  if (!emailRegex.hasMatch(value)) {
    return 'Please enter a valid email address';
  }
  return null;
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  }
  // Password validation criteria: At least 6 characters
  if (value.length < 6) {
    return 'Password must be at least 6 characters long';
  }
  return null;
}
