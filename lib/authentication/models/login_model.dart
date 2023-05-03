class LoginModel {
  String? phone;

  LoginModel({
    this.phone,
  });

  Map<String, dynamic> toJson() => {'phone': phone};
}

  // String? validatePassword(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Password is required.';
  //   }
  //   // Check length
  //   if (value.length < 8) {
  //     return 'Password must be at least 8 characters long.';
  //   }
  //   // Check for at least one uppercase letter
  //   if (!value.contains(RegExp(r'[A-Z]'))) {
  //     return 'Password must contain at least one uppercase letter.';
  //   }
  //   // Check for at least one lowercase letter
  //   if (!value.contains(RegExp(r'[a-z]'))) {
  //     return 'Password must contain at least one lowercase letter.';
  //   }
  //   // Check for at least one number
  //   if (!value.contains(RegExp(r'[0-9]'))) {
  //     return 'Password must contain at least one number.';
  //   }
  //   // Check for at least one special character
  //   if (!value.contains(RegExp(r'[!@#\$&*~-]'))) {
  //     return 'Password must contain at least one special character.';
  //   }
  //   // All checks passed
  //   return null;
  // }

  // Map<String, dynamic> toJson() {
  //   return {'phone': phone};
  // }

