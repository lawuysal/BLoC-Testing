import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'list_event.dart';
part 'list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  ListBloc() : super(const ListInitial(itemList: [])) {
    on<InitialListEvent>(initialListEvent);
    on<ClickedAddToListButtonEvent>(clickedAddToListButtonEvent);
    on<ClickedRemoveButtonEvent>(clickedRemoveButtonEvent);
    on<ClickedGoToEditingPageButtonEvent>(clickedGoToEditingPageButtonEvent);
    on<ClickedApplyButtonEvent>(clickedApplyButtonEvent);
  }

  FutureOr<void> initialListEvent(
      InitialListEvent event, Emitter<ListState> emit) {
    emit(ListInitial(itemList: state.itemList));
    debugPrint("Init state triggered.");
  }

  FutureOr<void> clickedAddToListButtonEvent(
      ClickedAddToListButtonEvent event, Emitter<ListState> emit) {
    emit(AddedToListActionState(itemList: event.itemList));
    emit(ListLoadedSuccessState(itemList: state.itemList));
    debugPrint("Item added.");
    debugPrint(state.itemList.toString());
  }

  FutureOr<void> clickedRemoveButtonEvent(
      ClickedRemoveButtonEvent event, Emitter<ListState> emit) {
    emit(DeletedFromListActionState(itemList: event.itemList));
    emit(ListLoadedSuccessState(itemList: state.itemList));
    debugPrint('Item deleted');
    debugPrint(state.itemList.toString());
  }

  FutureOr<void> clickedGoToEditingPageButtonEvent(
      ClickedGoToEditingPageButtonEvent event, Emitter<ListState> emit) {
    emit(ItemLoadedSuccessState(itemList: state.itemList));
  }

  FutureOr<void> clickedApplyButtonEvent(
      ClickedApplyButtonEvent event, Emitter<ListState> emit) {
    emit(ItemEditedActionState(itemList: event.itemList));
    emit(ListLoadedSuccessState(itemList: state.itemList));
    debugPrint(state.itemList.toString());
  }
}
