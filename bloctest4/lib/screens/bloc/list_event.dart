part of 'list_bloc.dart';

sealed class ListEvent extends Equatable {
  const ListEvent();

  @override
  List<Object> get props => [];
}

class InitialListEvent extends ListEvent {}

/// Add Screen
class ClickedAddToListButtonEvent extends ListEvent {
  final List<String> itemList;

  const ClickedAddToListButtonEvent({required this.itemList});
}

class ClickedGoToListPageButtonEvent extends ListEvent {}

/// Listing Screen
class ClickedRemoveButtonEvent extends ListEvent {
  final List<String> itemList;

  const ClickedRemoveButtonEvent({required this.itemList});
}

class ClickedGoToEditingPageButtonEvent extends ListEvent {}

/// Editing Screen
class ClickedApplyButtonEvent extends ListEvent {
  final List<String> itemList;

  const ClickedApplyButtonEvent({required this.itemList});
}
