part of 'list_bloc.dart';

sealed class ListState extends Equatable {
  const ListState(this.itemList);

  final List<String> itemList;

  @override
  List<Object> get props => [];
}

sealed class ListActionState extends ListState {
  const ListActionState(super.itemList);
}

final class ListInitial extends ListState {
  const ListInitial(super.itemList);
}

class ListLoadingState extends ListState {
  const ListLoadingState(super.itemList);
}

class ListLoadedSuccessState extends ListState {
  const ListLoadedSuccessState(super.itemList);
}

class ListLoadedFailedState extends ListState {
  const ListLoadedFailedState(super.itemList);
}

class ListItemAddedState extends ListActionState {
  const ListItemAddedState(super.itemList);
}

class ListItemRemovedState extends ListActionState {
  const ListItemRemovedState(super.itemList);
}
