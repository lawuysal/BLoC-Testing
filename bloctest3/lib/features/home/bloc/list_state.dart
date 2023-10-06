part of 'list_bloc.dart';

sealed class ListState extends Equatable {
  const ListState();

  @override
  List<Object> get props => [];
}

sealed class ListActionState extends ListState {}

final class ListInitial extends ListState {}

class ListLoadingState extends ListState {}

class ListLoadedSuccessState extends ListState {
  final items = const ItemList(items: []);
}

class ListLoadedFailedState extends ListState {}

class ListItemAddedState extends ListActionState {}

class ListItemRemovedState extends ListActionState {}
