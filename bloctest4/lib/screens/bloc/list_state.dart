part of 'list_bloc.dart';

sealed class ListState extends Equatable {
  const ListState({required this.itemList});

  final List<String> itemList;

  @override
  List<Object> get props => [];
}

class ListActionState extends ListState {
  const ListActionState({required super.itemList});
}

final class ListInitial extends ListState {
  const ListInitial({required super.itemList});
}

/// Add Screen
class AddedToListActionState extends ListActionState {
  const AddedToListActionState({required super.itemList});
}

/// Listing Screen
class ListLoadedSuccessState extends ListState {
  const ListLoadedSuccessState({required super.itemList});
}

class DeletedFromListActionState extends ListActionState {
  const DeletedFromListActionState({required super.itemList});
}

/// Editing Screen
class ItemLoadedSuccessState extends ListState {
  const ItemLoadedSuccessState({required super.itemList});
}

class ItemEditedActionState extends ListActionState {
  const ItemEditedActionState({required super.itemList});
}
