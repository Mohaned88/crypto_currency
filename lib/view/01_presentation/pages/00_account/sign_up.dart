
import 'package:crypto_currency/controller/local/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../controller/cubit/account/auth/account_cubit.dart';
import '../../../../controller/cubit/account/auth/account_states.dart';
import '../../../../controller/cubit/account/shared/shared_prefs_cubit.dart';
import '../../../../controller/cubit/account/shared/shared_prefs_states.dart';
import '../../../../controller/cubit/widgets/account/text_field_cubit.dart';
import '../../../../controller/cubit/widgets/account/text_field_states.dart';
import '../../../02_widgets/custom_elevated_button.dart';
import '../../../02_widgets/custom_text_field.dart';
import '../../../02_widgets/text_inkwell.dart';
import '../../../04_utilities/navigation/routes.dart';
import '../../../04_utilities/helper/validation.dart';
import '../../../04_utilities/res/strings.dart';
import '../../../05_styles/app_colors.dart';
import 'package:auth_buttons/auth_buttons.dart'
    show GoogleAuthButton, AuthButtonStyle, AuthButtonType, AuthIconType;

import 'sign_in.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AccountCubit cubit = AccountCubit.get(context);
    TextFieldCubit textFieldCubit = TextFieldCubit.get(context);
    SharedPCubit sharedPCubit = SharedPCubit.get(context);

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.w),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 40.w),
              child: Form(
                key: formKey,
                child: BlocConsumer<AccountCubit, AccountStates>(
                  listener: (context, state) {
                    if (state is SaveDataToFireStoreEmail) {
                      Navigator.pushNamed(context, AppRoutes.homePageRoute);
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          AppStrings.signUp,
                          style: TextStyle(
                            fontSize: 10.w,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6.w),
                        CustomTextField(
                          controller: nameController,
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 6.w, horizontal: 3.w),
                          label: AppStrings.name,
                          prefixIcon: Icons.person,
                          enabledBorderColor: AppColors.grey,
                          focusedBorderColor: AppColors.kPrimaryColor,
                          validator: (value) {
                            return nameValidation(value);
                          },
                        ),
                        SizedBox(height: 5.w),
                        CustomTextField(
                          controller: emailController,
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 6.w, horizontal: 3.w),
                          label: AppStrings.email,
                          prefixIcon: Icons.email,
                          enabledBorderColor: AppColors.grey,
                          focusedBorderColor: AppColors.kPrimaryColor,
                          validator: (value) {
                            return emailValidation(value);
                          },
                        ),
                        SizedBox(height: 5.w),
                        BlocConsumer<TextFieldCubit,TextFieldStates>(
                          listener: (context,state){},
                          builder: (context,state){
                            return CustomTextField(
                              controller: passwordController,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 6.w, horizontal: 3.w),
                              label: AppStrings.password,
                              prefixIcon: Icons.lock,
                              suffixIcon: textFieldCubit.signInPassSuffixIcon,
                              obscureText: textFieldCubit.signInObscure,
                              suffixOnPressed: (){
                                textFieldCubit.visibilityChange(
                                  page: AppConstants.signUpPageName,
                                );
                              },
                              enabledBorderColor: AppColors.grey,
                              focusedBorderColor: AppColors.kPrimaryColor,
                              validator: (value) {
                                return passwordValidation(value);
                              },

                            );
                          },
                        ),
                        SizedBox(height: 5.w),
                        BlocConsumer<SharedPCubit,SharedPStates>(
                          listener: (context,state ){} ,
                          builder:(context,state )=> CustomElevatedButton(
                            width: 80.w,
                            height: 15.w,
                            backgroundColor: AppColors.kPrimaryColor,
                            alignment: Alignment.center,
                            onPressed: () async{
                              if (formKey.currentState!.validate()) {
                                await cubit.registerByEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                );
                                sharedPCubit.storeInSharedPrefs(logState: true);
                                sharedPCubit.setUserDataInPrefs(
                                  email:emailController.text,
                                  name:cubit.registerUser.name,
                                  photo: cubit.registerUser.photo,
                                  id: cubit.registerUser.id,
                                );
                              }
                            },
                            label: AppStrings.signUp,
                            labelFontSize: 7.w,
                            labelFontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 5.w),
                        TextInkwell(
                          labelText: AppStrings.existedAccount,
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInPage(),
                              ),
                            );
                          },
                          directoryText: AppStrings.signIn,
                          labelFontSize: 5.w,
                          directoryFontWeight: FontWeight.bold,
                          directoryColor: AppColors.kPrimaryColor,
                          labelFontWeight: FontWeight.w400,
                          directoryFontSize: 5.w,
                          alignment: MainAxisAlignment.center,
                        ),
                      ],
                    );
                  },
                ),

              ),
            ),
          ),
        ),
      ),
    );
  }
}
