import 'sharek_utills.dart';

enum PasswordStrength {
  notValid,
  weak,
  medium,
  strong,
}

extension GetStringUtils on String {
  /// Discover if the String is a valid number
  bool get isNum => SharekUtils.isNum(this);

  /// Discover if the String is numeric only
  bool get isNumericOnly => SharekUtils.isNumericOnly(this);

  String numericOnly({bool firstWordOnly = false}) =>
      SharekUtils.numericOnly(this, firstWordOnly: firstWordOnly);

  ///Method that that takes a[String] password and returns it's strength from 0 to 8 as 8 is the highest
  int measurePasswordStrength() {
    // Define the criteria for each strength level
    final hasLowercase = RegExp(r'[a-z]').hasMatch(this);
    final hasUppercase = RegExp(r'[A-Z]').hasMatch(this);
    final hasDigits = RegExp(r'\d').hasMatch(this);
    final hasSpecialChars = RegExp(r'[!@#\$%\^&\*]').hasMatch(this);

    int points = 0;

    if (length < 8) {
      points += 1;
    } else if (length < 12) {
      points += 3;
    } else {
      points += 4;
    }

    if (hasLowercase) {
      points += 1;
    }
    if (hasUppercase) {
      points += 1;
    }
    if (hasDigits) {
      points += 1;
    }
    if (hasSpecialChars) {
      points += 1;
    }

    return points;
  }

  /// Discover if the String is alphanumeric only
  bool get isAlphabetOnly => SharekUtils.isAlphabetOnly(this);

  /// Discover if the String is a boolean
  bool get isBool => SharekUtils.isBool(this);

  /// Discover if the String is a vector
  bool get isVectorFileName => SharekUtils.isVector(this);

  /// Discover if the String is a ImageFileName
  bool get isImageFileName => SharekUtils.isImage(this);

  /// Discover if the String is a AudioFileName
  bool get isAudioFileName => SharekUtils.isAudio(this);

  /// Discover if the String is a VideoFileName
  bool get isVideoFileName => SharekUtils.isVideo(this);

  /// Discover if the String is a TxtFileName
  bool get isTxtFileName => SharekUtils.isTxt(this);

  /// Discover if the String is a Document Word
  bool get isDocumentFileName => SharekUtils.isWord(this);

  /// Discover if the String is a Document Excel
  bool get isExcelFileName => SharekUtils.isExcel(this);

  /// Discover if the String is a Document Powerpoint
  bool get isPPTFileName => SharekUtils.isPPT(this);

  /// Discover if the String is a APK File
  bool get isAPKFileName => SharekUtils.isAPK(this);

  /// Discover if the String is a PDF file
  bool get isPDFFileName => SharekUtils.isPDF(this);

  /// Discover if the String is a HTML file
  bool get isHTMLFileName => SharekUtils.isHTML(this);

  /// Discover if the String is a URL file
  bool get isURL => SharekUtils.isURL(this);

  /// Discover if the String is a Email
  bool get isEmail => SharekUtils.isEmail(this);

  /// Discover if the String is a Phone Number
  bool get isPhoneNumber => SharekUtils.isPhoneNumber(this);

  /// Discover if the String is a DateTime
  bool get isDateTime => SharekUtils.isDateTime(this);

  /// Discover if the String is a MD5 Hash
  bool get isMD5 => SharekUtils.isMD5(this);

  /// Discover if the String is a SHA1 Hash
  bool get isSHA1 => SharekUtils.isSHA1(this);

  /// Discover if the String is a SHA256 Hash
  bool get isSHA256 => SharekUtils.isSHA256(this);

  /// Discover if the String is a bynary value
  bool get isBinary => SharekUtils.isBinary(this);

  /// Discover if the String is a ipv4
  bool get isIPv4 => SharekUtils.isIPv4(this);

  bool get isIPv6 => SharekUtils.isIPv6(this);

  /// Discover if the String is a Hexadecimal
  bool get isHexadecimal => SharekUtils.isHexadecimal(this);

  /// Discover if the String is a palindrom
  bool get isPalindrom => SharekUtils.isPalindrom(this);

  /// Discover if the String is a passport number
  bool get isPassport => SharekUtils.isPassport(this);

  /// Discover if the String is a currency
  bool get isCurrency => SharekUtils.isCurrency(this);

  /// Discover if the String is a CPF number
  bool get isCpf => SharekUtils.isCpf(this);

  /// Discover if the String is a CNPJ number
  bool get isCnpj => SharekUtils.isCnpj(this);

  /// Discover if the String is a case insensitive
  bool isCaseInsensitiveContains(String b) =>
      SharekUtils.isCaseInsensitiveContains(this, b);

  /// Discover if the String is a case sensitive and contains any value
  bool isCaseInsensitiveContainsAny(String b) =>
      SharekUtils.isCaseInsensitiveContainsAny(this, b);

  /// capitalize the String
  String? get capitalize => SharekUtils.capitalize(this);

  /// Capitalize the first letter of the String
  String? get capitalizeFirst => SharekUtils.capitalizeFirst(this);

  /// remove all whitespace from the String
  String get removeAllWhitespace => SharekUtils.removeAllWhitespace(this);

  /// converter the String
  String? get camelCase => SharekUtils.camelCase(this);

  /// Discover if the String is a valid URL
  String? get paramCase => SharekUtils.paramCase(this);

  /// add segments to the String
  String createPath([Iterable? segments]) {
    final path = startsWith('/') ? this : '/$this';
    return SharekUtils.createPath(path, segments);
  }

  /// capitalize only first letter in String words to upper case
  String capitalizeAllWordsFirstLetter() =>
      SharekUtils.capitalizeAllWordsFirstLetter(this);
}
