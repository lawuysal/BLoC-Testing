import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloctest3/data/item_list.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'list_event.dart';
part 'list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  ListBloc() : super(ListInitial()) {
    on<InitialListEvent>(initialListEvent);
    on<ClickedAddToListEvent>(clickedAddToListEvent);
  }

  FutureOr<void> initialListEvent(
      InitialListEvent event, Emitter<ListState> emit) async {
    debugPrint("Init Event Triggered");
    emit(ListLoadingState());
    debugPrint("Loading State is Emitted..");
    await Future.delayed(const Duration(seconds: 2));
    //
    emit(ListLoadedSuccessState());
    debugPrint("List Loaded Successfully..");
  }

  FutureOr<void> clickedAddToListEvent(
      ClickedAddToListEvent event, Emitter<ListState> emit) {
    debugPrint("Add to List Button Clicked..");
  }
}
