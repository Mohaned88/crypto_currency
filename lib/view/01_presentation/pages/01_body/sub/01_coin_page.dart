import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_currency/controller/cubit/components/coins_states.dart';
import 'package:crypto_currency/view/04_utilities/res/strings.dart';
import 'package:crypto_currency/view/05_styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../../controller/cubit/components/coins_cubit.dart';
import '../../../../../model/currency_model.dart';

class CoinPage extends StatelessWidget {
  CurrencyModel currencyModel;

  CoinPage({
    Key? key,
    required this.currencyModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CoinsCubit cubit = CoinsCubit.get(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              cubit.getCoinsList();
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 10.w,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: Size(double.infinity, 20.h),
            child: SizedBox(
              width: double.infinity,
              height: 20.h,
              child: CachedNetworkImage(
                imageUrl: '${currencyModel.thumbNail}',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 3.w),
            child: BlocConsumer<CoinsCubit,CoinsStates>(
              listener: (context,state){},
              builder: (context,state){

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Text(
                            '${currencyModel.name}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10.w,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 40.w,
                          child: Row(
                            children: [
                              Text(
                                '${AppStrings.rank}: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 9.w,
                                ),
                              ),
                              Container(
                                width: 15.w,
                                height: 15.w,
                                decoration: BoxDecoration(
                                  color: AppColors.boxColor,
                                  borderRadius: BorderRadius.circular(4.w),
                                ),
                                child: Center(
                                  child: Text(
                                    '${currencyModel.rank}',
                                    style: TextStyle(
                                      color: AppColors.kContentColorDarkTheme,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 9.w,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${currencyModel.symbol}',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 9.w,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '${currencyModel.currentPrice}\$',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 7.w,
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          '${double.tryParse('${currencyModel.priceChangePercent}')!.isNegative ? '-' : ''}${currencyModel.priceChangePercent}%',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 7.w,
                            color: double.tryParse(
                                '${currencyModel.priceChangePercent}')!
                                .isNegative
                                ? AppColors.kErrorColor
                                : AppColors.kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        backgroundColor: AppColors.grey,
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <ChartSeries<ChangeValues, String>>[
                          LineSeries<ChangeValues, String>(
                            dataSource: currencyModel.chartData,
                            xValueMapper: (ChangeValues data, index) => data.date,
                            yValueMapper: (ChangeValues data, index) => data.value,
                            dataLabelSettings: const DataLabelSettings(isVisible: true),
                            color: AppColors.kPrimaryColor,
                            width: 1.w,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      AppStrings.coinPageDescription,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 9.w,
                      ),
                    ),
                    Text(
                      cubit.description ?? '...',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      style: TextStyle(
                        fontSize: 4.w,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ChangeValues {
  String date;
  double value;

  ChangeValues(this.date, this.value);
}
