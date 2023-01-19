import 'package:crypto_currency/model/currency_model.dart';
import 'package:crypto_currency/view/05_styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CoinCard extends StatelessWidget {
  CurrencyModel? currencyModel;
  GestureTapCallback? onTap;

  CoinCard({
    Key? key,
    this.currencyModel,
    this.onTap,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    double pc = double.parse(currencyModel!.priceChange.toString()) ;
    double pcp = double.parse(currencyModel!.priceChangePercent.toString()) ;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 28.w,
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: AppColors.kContentColorLightTheme,
          borderRadius: BorderRadius.circular(8.w),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              '${currencyModel!.rank}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 8.w,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: CachedNetworkImage(
                imageUrl: '${currencyModel!.thumbNail}',
                width: 12.w,
                height: 12.w,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${currencyModel!.name}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 6.w,
                    ),
                  ),
                  Text(
                    '${currencyModel!.symbol}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 5.w,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${double.tryParse('${currencyModel!.currentPrice}')!.toStringAsFixed(3)}\$',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 5.w,
                  ),
                ),
                Text(
                  '${double.tryParse('${currencyModel!.priceChange}')!.toStringAsFixed(5)}\$',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 5.w,
                    color: pc.isNegative ? Colors.red : Colors.green,
                  ),
                ),
                Text(
                  '${double.tryParse('${currencyModel!.priceChange}')!.toStringAsFixed(5)}%',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 5.w,
                    color: pcp.isNegative ? Colors.red : Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
