import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_currency/controller/cubit/account/auth/account_cubit.dart';
import 'package:crypto_currency/controller/cubit/account/auth/account_states.dart';
import 'package:crypto_currency/controller/cubit/account/shared/shared_prefs_cubit.dart';
import 'package:crypto_currency/controller/cubit/widgets/body/bottom_bar_cubit.dart';
import 'package:crypto_currency/translations/locale_keys.g.dart';
import 'package:crypto_currency/view/02_widgets/custom_elevated_button.dart';
import 'package:crypto_currency/view/02_widgets/custom_label_icon_button.dart';
import 'package:crypto_currency/view/04_utilities/navigation/routes.dart';
import 'package:crypto_currency/view/05_styles/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../controller/cubit/account/shared/shared_prefs_states.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    AccountCubit accountCubit = AccountCubit.get(context);
    SharedPCubit sharedPCubit = SharedPCubit.get(context);
    BottomBarCubit bottomBarCubit = BottomBarCubit().get(context);
    return BlocConsumer<AccountCubit, AccountStates>(
      listener: (context, state) {
        if (state is SignOutState) {
          Navigator.pushReplacementNamed(context, AppRoutes.signUpRoute);
          BlocProvider.of<BottomBarCubit>(context).currentIndex = 0;
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: BlocConsumer<SharedPCubit, SharedPStates>(
                listener: (context, state) {},
                builder: (context, state) => Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 25.w,
                        backgroundImage: CachedNetworkImageProvider(
                          sharedPCubit.userModel!.photo ??
                              'https://png.pngtree.com/png-vector/20190710/ourmid/pngtree-user-vector-avatar-png-image_1541962.jpg',
                        ),
                      ),
                    ),
                    Text(
                      sharedPCubit.userModel!.name ?? '...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.kLightThemeTextColor,
                        fontSize: 6.w,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      sharedPCubit.userModel!.email ?? '...@gmail.com',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.kLightThemeTextColor,
                        fontSize: 5.w,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomLabelIconButton(
                          onPressed: () {
                            accountCubit.images(source: 'gal');
                          },
                          label: 'From Gallery',
                          width: 44.w,
                          backgroundColor: AppColors.blueGrey,
                          icon: Icons.photo_outlined,
                          alignment: Alignment.centerLeft,
                        ),
                        SizedBox(width: 2.w),
                        CustomLabelIconButton(
                          onPressed: () {
                            accountCubit.images(source: 'cam');
                          },
                          label: LocaleKeys.choose_photo.tr(),
                          width: 44.w,
                          backgroundColor: AppColors.blueGrey,
                          icon: Icons.camera_alt,
                          alignment: Alignment.centerLeft,
                        ),
                      ],
                    ),
                    CustomElevatedButton(
                      onPressed: () {},
                      label: 'Change Theme',
                      backgroundColor: AppColors.blueGrey,
                      alignment: Alignment.centerLeft,
                    ),
                    /*CustomElevatedButton(
                    onPressed: () {
                      context.setLocale(Locale('en'));
                    },
                    label: 'Change Language',
                    backgroundColor: AppColors.blueGrey,
                    alignment: Alignment.centerLeft,
                  ),*/
                    PopupMenuButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(),
                      ),
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem(
                          child: IconButton(
                            onPressed: () {
                              context.setLocale(Locale('en'));
                              setState((){});
                            },
                            icon: Text('en'),
                          ),
                        ),
                        PopupMenuItem(
                          child: IconButton(
                            onPressed: () {
                              context.setLocale(Locale('ar'));
                              setState((){});
                            },
                            icon: Text('ar'),
                          ),
                        ),
                      ],
                      child: Container(
                        width: double.infinity,
                        height: 10.w,
                        color: AppColors.blueGrey,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Change Language',
                              style: TextStyle(
                                fontSize: 4.w,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    CustomLabelIconButton(
                      onPressed: () {
                        accountCubit.logOut();
                        sharedPCubit.storeInSharedPrefs(logState: false);
                        bottomBarCubit.changeIndex(0);
                      },
                      label: 'Logout',
                      backgroundColor: AppColors.blueGrey,
                      icon: Icons.logout,
                      alignment: Alignment.centerLeft,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
