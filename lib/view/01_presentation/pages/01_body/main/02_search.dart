import 'package:crypto_currency/controller/cubit/components/coins_cubit.dart';
import 'package:crypto_currency/controller/cubit/components/coins_states.dart';
import 'package:crypto_currency/view/02_widgets/custom_text_field.dart';
import 'package:crypto_currency/view/03_components/coin_card.dart';
import 'package:crypto_currency/view/05_styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CoinsCubit cubit = CoinsCubit.get(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.lightGrey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: CustomTextField(
            controller: searchController,
            width: double.infinity,
            prefixIcon: Icons.search,
            hintText: 'Search...',
            suffixIcon: Icons.highlight_remove_outlined,
            suffixOnPressed: () {
              searchController.clear();
            },
            onChanged: (text) {
              cubit.getSearchCoinsList(text);
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: cubit.searchList.isNotEmpty
            ? Center(
                child: Icon(
                  Icons.search,
                  size: 40.w,
                  color: AppColors.blueGrey,
                ),
              )
            : BlocConsumer<CoinsCubit, CoinsStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  return ListView.separated(
                    padding: EdgeInsets.all(3.w),
                    itemCount: cubit.searchList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CoinCard(
                        currencyModel: cubit.searchList[index],
                        onTap: () {},
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                  );
                },
              ),
      ),
    );
  }
}
