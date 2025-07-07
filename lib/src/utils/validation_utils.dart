import '../../../l10n/app_localizations.dart';

class ValidationUtils {
  static String validatePassword(String pass, AppLocalizations l10n) {
    if (pass.isNotEmpty && pass.length < 4) {
      return l10n.passwordMinLength;
    }

    if (pass.isNotEmpty && pass.length > 72) {
      return l10n.passwordMaxLength;
    }
    return '';
  }

  static String validateKatakana(String word, AppLocalizations l10n) {
    if (!RegExp(r'^[ァ-ンヴー\s]+$').hasMatch(word)) {
      return l10n.invalidKatakanaFormat;
    }
    return '';
  }

  static String validateKatakanaAdress(String word, AppLocalizations l10n) {
    if (!RegExp(r'^([0-9０-９]|[ァ-ンヴー-\s])+$').hasMatch(word)) {
      return l10n.katakanaAndNumbersOnly;
    }
    return '';
  }

  static String validateRomeWord(String word, AppLocalizations l10n) {
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(word)) {
      return l10n.invalidRomanFormat;
    }
    return '';
  }

  static String validateEmail(String email, AppLocalizations l10n) {
    final emailRe = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    );
    if (!emailRe.hasMatch(email)) {
      return l10n.invalidEmailFormat;
    }
    return '';
  }

  static String validateDob(String dob, AppLocalizations l10n) {
    final re = RegExp(r'^[0-9]{4}/(0[1-9]|1[0-2])/(0[1-9]|[12][0-9]|3[01])$');
    if (!re.hasMatch(dob)) {
      return l10n.invalidBirthDate;
    }
    return '';
  }

  static String validatePhoneNumber(String phone, AppLocalizations l10n) {
    final phoneStringNew = phone.replaceAll('-', '');
    if (phoneStringNew.length != 10 && phoneStringNew.length != 11) {
      return l10n.invalidPhoneNumber;
    }
    return '';
  }

  static String validateZipcode(String zipcode, AppLocalizations l10n) {
    if (zipcode.length != 8) {
      return l10n.invalidPostalCode;
    }
    return '';
  }
}
