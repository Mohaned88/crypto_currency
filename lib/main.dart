import 'package:crypto_currency/controller/cubit/widgets/body/bottom_bar_cubit.dart';
import 'package:crypto_currency/translations/codegen_loader.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'controller/cubit/account/auth/account_cubit.dart';
import 'controller/cubit/account/shared/shared_prefs_cubit.dart';
import 'controller/cubit/account/shared/shared_prefs_states.dart';
import 'controller/cubit/components/coins_cubit.dart';
import 'controller/cubit/widgets/account/text_field_cubit.dart';
import 'firebase_options.dart';
import 'view/01_presentation/pages/00_account/sign_in.dart';
import 'view/04_utilities/navigation/router.dart';
import 'view/04_utilities/navigation/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AccountCubit(),
      ),
      BlocProvider(
        create: (context) => CoinsCubit(),
      ),
      BlocProvider(
        create: (context) => TextFieldCubit(),
      ),
      BlocProvider(
        create: (context) => BottomBarCubit(),
      ),
      BlocProvider(
        create: (context) => SharedPCubit(),
      ),
    ],
    child: EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      fallbackLocale: const Locale('ar'),
      path: 'assets/translation',
      child: const MyApp(),
      assetLoader: CodegenLoader(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SharedPCubit>(context).getFromSharedPrefs();
    BlocProvider.of<SharedPCubit>(context).getUserDataInPrefs();
    return Sizer(
      builder: (context, orientation, deviceType) =>
          BlocConsumer<SharedPCubit, SharedPStates>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          title: 'Flutter Demo',
          onGenerateRoute: onGenerate,
          //initialRoute: AppRoutes.signInRoute,
          locale: context.locale,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
        ),
      ),
    );
  }
}
