part of 'list_bloc.dart';

sealed class ListEvent extends Equatable {
  const ListEvent();

  @override
  List<Object> get props => [];
}

class InitialListEvent extends ListEvent {}

class ClickedAddToListEvent extends ListEvent {
  final List<String> items;

  const ClickedAddToListEvent({required this.items});
}

class ClickedDeleteFromListEvent extends ListEvent {
  final List<String> items;

  const ClickedDeleteFromListEvent({required this.items});
}
