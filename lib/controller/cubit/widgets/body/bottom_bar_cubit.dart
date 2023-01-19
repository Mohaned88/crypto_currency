import 'package:bloc/bloc.dart';
import 'package:crypto_currency/controller/cubit/widgets/body/bottom_bar_states.dart';
import 'package:crypto_currency/view/01_presentation/pages/01_body/main/01_coins_list.dart';
import 'package:crypto_currency/view/01_presentation/pages/01_body/main/02_search.dart';
import 'package:crypto_currency/view/01_presentation/pages/01_body/main/03_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../view/05_styles/app_colors.dart';

class BottomBarCubit extends Cubit<BottomBarStates> {
  BottomBarCubit() : super(InitialBottomBarState());

  BottomBarCubit get(context) => BlocProvider.of<BottomBarCubit>(context);

  List<Widget> mainPages = [
    const CoinsList(),
    SearchPage(),
    const ProfilePage(),
  ];

  List<Icon> barIcons = [
    const Icon(Icons.home),
    const Icon(Icons.search),
    const Icon(Icons.person),
  ];

  List<Text> barTexts = [
    Text(
      'Home',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: AppColors.kPrimaryColor,
        fontSize: 5.w,
      ),
    ),
    Text(
      'Search',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: AppColors.kPrimaryColor,
        fontSize: 5.w,
      ),
    ),
    Text(
      'Profile',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: AppColors.kPrimaryColor,
        fontSize: 5.w,
      ),
    ),
  ];

  Widget home = Text(
    'Home',
    style: TextStyle(
      fontWeight: FontWeight.bold,
      color: AppColors.kPrimaryColor,
      fontSize: 5.w,
    ),
  );
  Widget search = const Icon(Icons.search);
  Widget profile = const Icon(Icons.person);

  int currentIndex = 0;

  changeIndex(index) {
    currentIndex = index;
    switch (index) {
      case 0:
        {
          home = barTexts[0];
          search = barIcons[1];
          profile = barIcons[2];
        }
        break;
      case 1:
        {
          home = barIcons[0];
          search = barTexts[1];
          profile = barIcons[2];
        }
        break;
      case 2:
        {
          home = barIcons[0];
          search = barIcons[1];
          profile = barTexts[2];
        }
        break;
      default:
        {
          home = barTexts[0];
          search = barIcons[1];
          profile = barIcons[2];
        }
        break;
    }
    emit(ChangeBottomNavState());
  }
}
