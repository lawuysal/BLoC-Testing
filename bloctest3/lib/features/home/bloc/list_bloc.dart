import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'list_event.dart';
part 'list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  ListBloc() : super(const ListInitial([])) {
    on<InitialListEvent>(initialListEvent);
    on<ClickedAddToListEvent>(clickedAddToListEvent);
    on<ClickedDeleteFromListEvent>(clickedDeleteFromListEvent);
  }

  FutureOr<void> initialListEvent(
      InitialListEvent event, Emitter<ListState> emit) async {
    debugPrint("Init Event Triggered");
    emit(ListLoadingState(state.itemList));
    debugPrint("Loading State is Emitted..");
    await Future.delayed(const Duration(seconds: 2));
    //
    emit(ListLoadedSuccessState(state.itemList));
    debugPrint("List Loaded Successfully..");
  }

  FutureOr<void> clickedAddToListEvent(
      ClickedAddToListEvent event, Emitter<ListState> emit) {
    debugPrint("Add to List Button Clicked..");

    emit(ListItemAddedState(event.itemList));
    debugPrint(state.itemList.toString());
    emit(ListLoadedSuccessState(state.itemList));
  }

  FutureOr<void> clickedDeleteFromListEvent(
      ClickedDeleteFromListEvent event, Emitter<ListState> emit) {
    debugPrint("Remove from List Button Clicked..");

    emit(ListItemRemovedState(event.itemList));
    emit(ListLoadedSuccessState(state.itemList));
  }
}
