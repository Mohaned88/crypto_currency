// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> ar = {
  "sign_in": "التسجيل",
  "name": "الاسم",
  "account_email": "الايميل",
  "password": "كلمه السر",
  "sign_up": "التسجيل",
  "have_account": "هل لديك حساب بالفعل ؟ ",
  "crypto_currency": "عملات الكترونية",
  "choose_photo": "التقاط صوره"
};
static const Map<String,dynamic> en = {
  "sign_in": "Sign in",
  "name": "Name",
  "account_email": "Email",
  "password": "Password",
  "sign_up": "Sign up",
  "have_account": "Already have an account? ",
  "crypto_currency": "Crypto Currency",
  "choose_photo": "Choose Photo"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar": ar, "en": en};
}
