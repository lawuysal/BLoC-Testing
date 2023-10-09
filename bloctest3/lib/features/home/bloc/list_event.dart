part of 'list_bloc.dart';

sealed class ListEvent extends Equatable {
  const ListEvent();

  @override
  List<Object> get props => [];
}

class InitialListEvent extends ListEvent {}

class ClickedAddToListEvent extends ListEvent {
  final List<String> itemList;

  const ClickedAddToListEvent({required this.itemList});
}

class ClickedDeleteFromListEvent extends ListEvent {
  final List<String> itemList;

  const ClickedDeleteFromListEvent({required this.itemList});
}
