extension StringExtensions on String {
  String get toLowerCaseTr =>
      replaceAll('I', 'ı').replaceAll('İ', 'i').toLowerCase();
}
