import 'package:bloc/bloc.dart';
import 'package:crypto_currency/controller/local/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/currency_model.dart';
import 'coins_states.dart';


class CoinsCubit extends Cubit<CoinsStates> {
  CoinsCubit() : super(CoinsInitial());

  static CoinsCubit get(context) => BlocProvider.of<CoinsCubit>(context);

  List<CurrencyModel> coins = [];

  CurrencyModel? searchedCoin;

  String? description;

  void getCoinsList() async {
    emit(LoadingCoinsState());
    try {
      var response = await Dio().get(
          '${AppConstants.baseUrl}${AppConstants.coinsDetailsEndPoint}');
      if (response.statusCode == 200) {
        //print('response----------------------${response.data}');
        coins = [];
        response.data.forEach((element) {
          coins.add(CurrencyModel.fromMap(element));
        });
        emit(LoadingCoinsSuccessState());
        //print('coins----------------------${coins}');
      }
      else {
        emit(LoadingCoinsFailState());
        print('**********************${response
            .statusCode}**********************');
        print('//////////////////////${response.statusMessage}');
      }
    } catch (e) {
      print(e);
    }
  }

  getDescription(String id) async {
    description = '...';
    var response = await Dio().get(
        '${AppConstants.baseUrl}${AppConstants.coinsDetailsEndPoint}$id');
    if (response.statusCode == 200) {
      description = response.data["description"]["en"].toString();
      emit(GetDescriptionState());
    }

  }

  List<CurrencyModel> searchList =[];

  getSearchCoinsList(String id) async {
    emit(SearchLoadingState());
    searchList = [];
    coins.forEach((element) {
      if(element.id!.contains(id)){
        searchList.add(element);
        emit(FoundSearchElementState());
      }
    });
  }
}

