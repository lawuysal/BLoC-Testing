part of 'home_bloc.dart';

/// This state is resposible for building the page
@immutable
sealed class HomeState {}

/// This state is resposible for changing the page according to actions
@immutable
sealed class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

/// These three classes are the events of the home page
/// They responsible for building stage of the home page
class HomeLoadedLoadingState extends HomeState {}

// When SuccessState is emitted we want the list of products
class HomeLoadedSuccessState extends HomeState {
  final List<ProductDataModel> products;

  HomeLoadedSuccessState({required this.products});
}

class HomeLoadedErrorState extends HomeState {}

//
/// These two events are responsible for navigating from home page
class HomeNavigateToWishlistPageActionState extends HomeActionState {}

class HomeNavigateToCartPageActionState extends HomeActionState {}
