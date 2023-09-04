part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class CartInitialEvent extends CartEvent {}

class CartRemoveFromCartClickedEvent extends CartEvent {
  final ProductDataModel clickedProduct;

  CartRemoveFromCartClickedEvent({required this.clickedProduct});
}
