extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
            .hasMatch(this) &&
        isNotEmpty &&
        length > 6;
  }
}

extension PasswordValidator on String {
  bool isValidPassword() {
    return RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
            .hasMatch(this) &&
        isNotEmpty &&
        length >= 8;
  }
}

extension UserCodeValidator on String {
  bool isValidUserCode() {
    return RegExp(r'^(?=.*[a-zA-Z])(?=.*[0-9]).{6}$').hasMatch(this) &&
        isNotEmpty &&
        length == 6;
  }
}

extension PhoneNumberValidator on String {
  bool isValidPhoneNumber() {
    return RegExp(r'^\+\d{1,3}\d{6,14}$').hasMatch(this) && isNotEmpty;
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');

  String capitalizeWords(String text) {
    if (text.isEmpty) {
      return text;
    }

    // Split the text into words
    List<String> words = text.split(' ');

    // Capitalize the first letter of each word
    List<String> capitalizedWords = words.map((word) {
      if (word.isEmpty) {
        return word;
      }
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).toList();

    // Join the capitalized words back into a sentence
    return capitalizedWords.join(' ');
  }
}
