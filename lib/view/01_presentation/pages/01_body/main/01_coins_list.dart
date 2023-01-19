import 'package:crypto_currency/controller/cubit/components/coins_states.dart';
import 'package:crypto_currency/controller/cubit/widgets/body/bottom_bar_cubit.dart';
import 'package:crypto_currency/controller/cubit/widgets/body/bottom_bar_states.dart';
import 'package:crypto_currency/view/01_presentation/pages/01_body/sub/01_coin_page.dart';
import 'package:crypto_currency/view/03_components/coin_card.dart';
import 'package:crypto_currency/view/04_utilities/res/strings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../../controller/cubit/components/coins_cubit.dart';
import '../../../../../translations/locale_keys.g.dart';

class CoinsList extends StatelessWidget {
  const CoinsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CoinsCubit coinsCubit = CoinsCubit.get(context);
    coinsCubit.getCoinsList();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.crypto_currency,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 9.w,
                  decoration: TextDecoration.underline,
                  fontStyle: FontStyle.italic,
                ),
              ).tr(),
              BlocConsumer<CoinsCubit, CoinsStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is LoadingCoinsState) {
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is LoadingCoinsSuccessState) {
                    return Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(vertical: 3.w),
                        itemCount: coinsCubit.coins.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CoinCard(
                            currencyModel: coinsCubit.coins[index],
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CoinPage(
                                    currencyModel: coinsCubit.coins[index],
                                  ),
                                ),
                              );
                              coinsCubit.getDescription('${coinsCubit.coins[index].id}');
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider();
                        },
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
