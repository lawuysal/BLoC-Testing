part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

/// This classes will be used as events that enter the bloc

/// This event will be responsible for three starting states of the app: loading, success, error
class HomeInitialEvent extends HomeEvent {}

/// We're using events to send data
class HomeProductWishlistButtonClickedEvent extends HomeEvent {
  final ProductDataModel clickedProduct;

  HomeProductWishlistButtonClickedEvent({required this.clickedProduct});
}

class HomeProductCartButtonClickedEvent extends HomeEvent {
  final ProductDataModel clickedProduct;

  HomeProductCartButtonClickedEvent({required this.clickedProduct});
}

class HomeNavigateToWishlistClickedEvent extends HomeEvent {}

class HomeNavigateToCartClickedEvent extends HomeEvent {}
