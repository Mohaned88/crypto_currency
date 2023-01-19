import 'package:bloc/bloc.dart';
import 'package:crypto_currency/controller/local/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'text_field_states.dart';

class TextFieldCubit extends Cubit<TextFieldStates> {
  TextFieldCubit() : super(InitialTextFieldStates());

  static TextFieldCubit get(context) =>
      BlocProvider.of<TextFieldCubit>(context);

  bool signInObscure = false;
  IconData signInPassSuffixIcon = Icons.visibility;
  bool signUpObscure = false;
  IconData signUpPassSuffixIcon = Icons.visibility;


  visibilityChange({required String page}) {
    if(page == AppConstants.signInPageName){
      if (signInObscure == false) {
        signInObscure = true;
        signInPassSuffixIcon = Icons.visibility_off;
        emit(ObscureText());
      } else {
        signInObscure = false;
        signInPassSuffixIcon = Icons.visibility;
        emit(VisibleText());
      }
    }
    else if(page == AppConstants.signUpPageName){
      if (signUpObscure == false) {
        signUpObscure = true;
        signUpPassSuffixIcon = Icons.visibility_off;
        emit(ObscureText());
      } else {
        signUpObscure = false;
        signUpPassSuffixIcon = Icons.visibility;
        emit(VisibleText());
      }
    }
  }
}
