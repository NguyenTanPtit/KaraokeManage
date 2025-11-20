extension StringExtension on String {
  /// Kiểm tra xem string có pattern giống email không
  bool get isEmail {
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return emailRegex.hasMatch(trim());
  }
}