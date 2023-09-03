part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

/// This classes will be used as events that enter the bloc

/// This event will be responsible for three starting states of the app: loading, success, error
class HomeInitialEvent extends HomeEvent {}

class HomeProductWishlistButtonClickedEvent extends HomeEvent {}

class HomeProductCartButtonClickedEvent extends HomeEvent {}

class HomeNavigateToWishlistClickedEvent extends HomeEvent {}

class HomeNavigateToCartClickedEvent extends HomeEvent {}
