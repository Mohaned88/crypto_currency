abstract class CoinsStates {}

class CoinsInitial extends CoinsStates {}

class LoadingCoinsState extends CoinsStates {}
class LoadingCoinsSuccessState extends CoinsStates {}
class LoadingCoinsFailState extends CoinsStates {}
class GotDescriptionState extends CoinsStates {}
class FoundSearchElementState extends CoinsStates {}
class SearchLoadingState extends CoinsStates {}
class GetDescriptionState extends CoinsStates {}

