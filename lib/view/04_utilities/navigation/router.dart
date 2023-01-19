import 'package:crypto_currency/view/01_presentation/pages/01_body/main/00_home.dart';
import 'package:crypto_currency/view/01_presentation/pages/01_body/main/02_search.dart';
import 'package:crypto_currency/view/01_presentation/pages/01_body/main/03_profile.dart';
import 'package:flutter/material.dart';
import '../../../controller/cubit/account/shared/shared_prefs_cubit.dart';
import '../../01_presentation/pages/00_account/sign_in.dart';
import '../../01_presentation/pages/00_account/sign_up.dart';
import '../../01_presentation/pages/01_body/main/01_coins_list.dart';
import 'routes.dart';

Route<dynamic> onGenerate(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AppRoutes.signInRoute:
      return MaterialPageRoute(
        builder: (_) => const SignInPage(),
        settings: routeSettings,
      );

    case AppRoutes.signUpRoute:
      return MaterialPageRoute(
        builder: (_) => const SignUpPage(),
        settings: routeSettings,
      );

    case AppRoutes.homePageRoute:
      return MaterialPageRoute(
        builder: (_) => const HomePage(),
        settings: routeSettings,
      );

    case AppRoutes.coinsListPageRoute:
      return MaterialPageRoute(
        builder: (_) => const CoinsList(),
        settings: routeSettings,
      );

    case AppRoutes.searchPageRoute:
      return MaterialPageRoute(
        builder: (_) => SearchPage(),
        settings: routeSettings,
      );

    case AppRoutes.profilePageRoute:
      return MaterialPageRoute(
        builder: (_) => const ProfilePage(),
        settings: routeSettings,
      );

    default:
      return MaterialPageRoute(
        builder: (context)
        {
          SharedPCubit cubit = SharedPCubit.get(context);
          if(cubit.isLoggedIn == true){
            //print('--------------------------------${cubit.isLoggedIn }');

            return const HomePage();
          }
          else{
           // print('--------------------------------${cubit.isLoggedIn }');
            return const SignUpPage();
          }
          /*return (cubit.isLoggedIn == true)
              ? const HomePage()
              : const SignInPage();*/
        },
        settings: routeSettings,
      );
  }
}
