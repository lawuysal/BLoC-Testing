import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloctest2/data/grocery_data.dart';
import 'package:bloctest2/models/product_data_model.dart';
import 'package:flutter/material.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    /// Here we're saying bloc to call the specific func for this spesific event
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeNavigateToWishlistClickedEvent>(homeNavigateToWishlistClickedEvent);
    on<HomeNavigateToCartClickedEvent>(homeNavigateToCartClickedEvent);
    on<HomeProductWishlistButtonClickedEvent>(
        homeProductWishlistButtonClickedEvent);
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    debugPrint("Init Event Triggered");
    emit(HomeLoadedLoadingState());
    debugPrint("Loading State...");
    await Future.delayed(const Duration(seconds: 1));

    // The main product list will be initialized here
    emit(HomeLoadedSuccessState(
        products: GroceryData.groceryProducts
            .map((e) => ProductDataModel(
                id: e['id'],
                name: e['name'],
                description: e['description'],
                price: e['price'],
                imageUrl: e['imageUrl']))
            .toList()));
    debugPrint("Success State...");
  }

  FutureOr<void> homeNavigateToWishlistClickedEvent(
      HomeNavigateToWishlistClickedEvent event, Emitter<HomeState> emit) {
    debugPrint("Navigate to Wishlist Button Clicked");

    /// This emit code will inform the app to say "take action" :)
    emit(HomeNavigateToWishlistPageActionState());
  }

  FutureOr<void> homeNavigateToCartClickedEvent(
      HomeNavigateToCartClickedEvent event, Emitter<HomeState> emit) {
    debugPrint("Navigate to Cart Button Clicked");

    /// This emit code will inform the app to say "take action" :)
    emit(HomeNavigateToCartPageActionState());
  }

  FutureOr<void> homeProductWishlistButtonClickedEvent(
      HomeProductWishlistButtonClickedEvent event, Emitter<HomeState> emit) {
    debugPrint("Add to Wishlist Button Clicked");
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
    debugPrint("Add to Cart Button Clicked");
  }
}
