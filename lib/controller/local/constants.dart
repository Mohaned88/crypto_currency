class AppConstants {

  //----------------------URLs----------------------
  static const String baseUrl = "https://api.coingecko.com/api/v3/";
  static const String allCoinEndPoint =
      "coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false";
  static const String coinsDetailsEndPoint = "coins/";
  static const String searchCoinEndPoint = "search?query=";

  //----------------------Pages names----------------------
  //-------------------------------account pages
  static const String signInPageName = 'signInPage';
  static const String signUpPageName = 'signUpPage';

  //-------------------------------body pages
  static const String homePageName = 'homePage';
  static const String coinPageName = 'coinPage';
}
