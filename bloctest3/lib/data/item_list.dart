import 'package:equatable/equatable.dart';

class ItemList extends Equatable {
  const ItemList({required this.items});

  final List<String> items;

  @override
  List<Object?> get props => [items];

  ItemList copyWith({List<String>? items}) {
    return ItemList(items: items ?? this.items);
  }
}
