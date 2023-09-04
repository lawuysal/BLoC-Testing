part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

@immutable
sealed class CartActionState {}

final class CartInitial extends CartState {}

class CartLoadedLoadingState extends CartState {}

class CartLoadedSuccessState extends CartState {
  final List<ProductDataModel> cartItems;

  CartLoadedSuccessState({required this.cartItems});
}

class CartLoadedErrorState extends CartState {}

class CartItemDiscardedFromCartActionState extends CartActionState {}
