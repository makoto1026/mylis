class CharacterFormatter {
  static String wordBreak({
    required String text,
    bool? isLower,
  }) {
    return isLower ?? false
        ? toLowerCamelCase(text).replaceAllMapped(RegExp(r'([a-z])([A-Z])'),
            (match) => "${match.group(1)} ${match.group(2)}")
        : toCamelCase(text).replaceAllMapped(RegExp(r'([a-z])([A-Z])'),
            (match) => "${match.group(1)} ${match.group(2)}");
  }

  static String toCamelCase(String text) =>
      "${text[0].toUpperCase()}${text.substring(1)}";

  static String toLowerCamelCase(String text) => text.toLowerCase();
}
