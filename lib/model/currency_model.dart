import 'package:crypto_currency/view/01_presentation/pages/01_body/sub/01_coin_page.dart';

class CurrencyModel {
  String? id;
  String? rank;
  String? thumbNail;
  String? name;
  String? symbol;
  String? currentPrice;
  String? priceChange;
  String? priceChangePercent;
  List<ChangeValues> chartData;

  CurrencyModel({
    this.id,
    this.rank,
    this.thumbNail,
    this.name,
    this.symbol,
    this.currentPrice,
    this.priceChange,
    this.priceChangePercent,
    required this.chartData,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};

    var loc = data['market_data'];

    data['id'] = id;
    loc['market_cap_rank'] = rank;
    data['image']['large'] = thumbNail;
    data['name'] = name;
    data['symbol'] = symbol;
    loc['current_price']['usd'] = currentPrice;
    loc['price_change_24h'] = priceChange;
    loc['price_change_percentage_24h'] = priceChangePercent;
    loc['price_change_percentage_7d'] = chartData[1].value;
    loc['price_change_percentage_14d'] = chartData[2].value;
    loc['price_change_percentage_30d'] = chartData[3].value;
    loc['price_change_percentage_60d'] = chartData[4].value;
    loc['price_change_percentage_200d'] = chartData[5].value;
    loc['price_change_percentage_1y'] = chartData[6].value;

    return data;
  }

  factory CurrencyModel.fromMap(Map<String, dynamic> map) {
    var loc = map['market_data'];
    return CurrencyModel(
      id: map['id'],
      rank: loc['market_cap_rank'].toString(),
      thumbNail: map['image']['large'].toString(),
      name: map['name'].toString(),
      symbol: map['symbol'].toString(),
      currentPrice: loc['current_price']['usd'].toString(),
      priceChange: loc['price_change_24h'].toString(),
      priceChangePercent: loc['price_change_percentage_24h'].toString(),
      chartData: [
        ChangeValues('24h',loc['price_change_percentage_24h']),
        ChangeValues('7d',loc['price_change_percentage_7d']),
        ChangeValues('14d',loc['price_change_percentage_14d']),
        ChangeValues('30d',loc['price_change_percentage_30d']),
        ChangeValues('60d',loc['price_change_percentage_60d']),
        ChangeValues('200d',loc['price_change_percentage_200d']),
        ChangeValues('1y',loc['price_change_percentage_1y']),
      ],
    );
  }

}
