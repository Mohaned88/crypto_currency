import 'package:crypto_currency/view/05_styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../../controller/cubit/account/shared/shared_prefs_cubit.dart';
import '../../../../../controller/cubit/components/coins_cubit.dart';
import '../../../../../controller/cubit/widgets/body/bottom_bar_cubit.dart';
import '../../../../../controller/cubit/widgets/body/bottom_bar_states.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CoinsCubit coinsCubit = CoinsCubit.get(context);
    BottomBarCubit barCubit = BottomBarCubit().get(context);
    coinsCubit.getCoinsList();
    SharedPCubit sharedPCubit = SharedPCubit.get(context);
    sharedPCubit.getUserDataInPrefs();
    return BlocConsumer<BottomBarCubit, BottomBarStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: barCubit.mainPages[barCubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            fixedColor: AppColors.kPrimaryColor,
            unselectedItemColor: AppColors.kPrimaryColor,
            currentIndex: barCubit.currentIndex,
            onTap: (index) {
              barCubit.changeIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: barCubit.home,
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: barCubit.search,
                label: 'search',
              ),
              BottomNavigationBarItem(
                icon: barCubit.profile,
                label: 'profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
