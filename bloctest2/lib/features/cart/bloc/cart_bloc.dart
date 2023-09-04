import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloctest2/data/cart_items.dart';
import 'package:bloctest2/models/product_data_model.dart';
import 'package:flutter/material.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<CartRemoveFromCartClickedEvent>(cartRemoveFromCartClickedEvent);
  }

  FutureOr<void> cartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) async {
    debugPrint("Init Cart Event Triggered ");
    emit(CartLoadedLoadingState());
    debugPrint("Cart Loading Event");
    await Future.delayed(const Duration(seconds: 1));
    emit(CartLoadedSuccessState(cartItems: cartItems));
    debugPrint("Cart Successfully Loaded Event");
  }

  FutureOr<void> cartRemoveFromCartClickedEvent(
      CartRemoveFromCartClickedEvent event, Emitter<CartState> emit) {
    cartItems.remove(event.clickedProduct);
    emit(CartLoadedSuccessState(cartItems: cartItems));
  }
}
