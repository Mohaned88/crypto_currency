import 'package:easy_localization/easy_localization.dart';

import '../../../translations/locale_keys.g.dart';

class AppStrings{

  static const String emailRegExp = "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9+_.-]+.[a-z]";
  static const String nameRegExp = "^[a-zA-Z0-9]";
  static const String rank = "Rank";
  static const String coinPageDescription = 'Description';

  //--------------Titles
  static const String signIn = 'Sign in';
  static const String signUp = 'Sign up';

  //--------------Account labels
  static const String email = 'Email';
  static const String password = 'Password';
  static const String name = 'Name';

  //--------------Complementary phrases
  static const String or = 'Or';
  static const String existedAccount = 'Already have an account? ';
  static const String newAccount = 'Create new account? ';

  //--------------Validation messages
  static const String shortName = "The name is too short";
  static const String emptyName = "The name can not be empty";
  static const String shortPassword = "Short Password";
  static const String emailEmpty = "the email can not be empty ";
  static const String validEmail = "the email you entered is not valid ";

  //--------------Body titles
  static String cryptoCurrencyTitle = LocaleKeys.crypto_currency.tr();
}