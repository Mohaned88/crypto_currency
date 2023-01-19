import 'package:crypto_currency/controller/cubit/widgets/account/text_field_cubit.dart';
import 'package:crypto_currency/controller/cubit/widgets/account/text_field_states.dart';
import 'package:crypto_currency/controller/local/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:auth_buttons/auth_buttons.dart'
    show GoogleAuthButton, AuthButtonStyle, AuthButtonType, AuthIconType;

import '../../../../controller/cubit/account/auth/account_cubit.dart';
import '../../../../controller/cubit/account/auth/account_states.dart';
import '../../../../controller/cubit/account/shared/shared_prefs_cubit.dart';
import '../../../../controller/cubit/account/shared/shared_prefs_states.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../../02_widgets/custom_elevated_button.dart';
import '../../../02_widgets/custom_text_field.dart';
import '../../../02_widgets/text_inkwell.dart';
import '../../../04_utilities/navigation/routes.dart';
import '../../../04_utilities/res/strings.dart';
import '../../../04_utilities/helper/validation.dart';
import '../../../05_styles/app_colors.dart';
import 'sign_up.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                    if (state is LoginSuccessfully) {
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
                          LocaleKeys.sign_in,
                          style: TextStyle(
                            fontSize: 10.w,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ).tr(),
                        SizedBox(height: 4.w),
                        CustomTextField(
                          controller: emailController,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 6.w, horizontal: 3.w),
                          label: AppStrings.email,
                          prefixIcon: Icons.email,
                          enabledBorderColor: AppColors.grey,
                          focusedBorderColor: AppColors.kPrimaryColor,
                          validator: (value) {
                            return emailValidation(value);
                          },
                        ),
                        SizedBox(height: 2.w),
                        BlocConsumer<TextFieldCubit,TextFieldStates>(
                          listener: (context,state){},
                          builder: (context,state){
                            return CustomTextField(
                              controller: passwordController,
                              contentPadding: EdgeInsets.symmetric(vertical: 6.w, horizontal: 3.w),
                              label: AppStrings.password,
                              prefixIcon: Icons.lock,
                              suffixIcon: textFieldCubit.signInPassSuffixIcon,
                              obscureText: textFieldCubit.signInObscure,
                              suffixOnPressed: (){
                                textFieldCubit.visibilityChange(
                                  page: AppConstants.signInPageName,
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
                        SizedBox(height: 2.w),
                        BlocConsumer<SharedPCubit,SharedPStates>(
                          listener: (context,state ){} ,
                          builder:(context,state )=> CustomElevatedButton(
                            width: 80.w,
                            height: 15.w,
                            backgroundColor: AppColors.kPrimaryColor,
                            alignment: Alignment.center,
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                await cubit.login(
                                  email:emailController.text,
                                  password:passwordController.text,
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
                            label: AppStrings.signIn,
                            labelFontSize: 7.w,
                            labelFontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 3.w),
                        Text(
                          AppStrings.or,
                          style: TextStyle(
                            fontSize: 6.w,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 3.w),
                        GoogleAuthButton(
                          onPressed: () async {
                            await cubit.signInByGoogle();
                            sharedPCubit.storeInSharedPrefs(logState: true);
                            sharedPCubit.setUserDataInPrefs(
                              email:cubit.registerUser.email,
                              name:cubit.registerUser.name,
                              photo: cubit.registerUser.photo,
                              id: cubit.registerUser.id,
                            );
                          },
                          style: AuthButtonStyle(
                            //iconType: AuthIconType.outlined,
                            buttonColor: Colors.white,
                            borderColor: Colors.black,
                            borderWidth: (1 / 5).w,
                            width: double.infinity,
                            height: 12.w,
                            borderRadius: 4.w,
                            textStyle: TextStyle(
                              fontSize: 5.w,
                              fontWeight: FontWeight.w400,
                            ),
                            elevation: 0,
                          ),
                        ),
                        SizedBox(height: 3.w),
                        TextInkwell(
                          labelText: AppStrings.newAccount,
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpPage(),
                              ),
                            );
                          },
                          directoryText: AppStrings.signUp,
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
