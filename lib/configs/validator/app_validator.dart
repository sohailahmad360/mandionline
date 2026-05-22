/// Shared validation helpers for forms. Views call these; orchestration stays in ViewModels.
class AppValidator {
  AppValidator._();

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final email = value.trim();
    final ok = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
    if (!ok) return 'Enter a valid email';
    return null;
  }

  static String? required(String? value, [String field = 'This field']) {
    if (value == null || value.trim().isEmpty) {
      return '$field is required';
    }
    return null;
  }

  /// Accepts email or a simple phone (digits / + prefix).
  static String? emailOrPhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email or phone is required';
    }
    final v = value.trim();
    if (email(v) == null) return null;
    final digits = v.replaceAll(RegExp(r'\D'), '');
    if (digits.length >= 10 && digits.length <= 15) return null;
    return 'Enter a valid email or phone number';
  }
}
