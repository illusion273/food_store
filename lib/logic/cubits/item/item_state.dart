part of 'item_cubit.dart';

enum ItemStatus { adding, editing }

class ItemState extends Equatable {
  final ItemStatus status;
  final int quantity;
  final double subTotal;
  final List<Ingredient> ingredients;
  const ItemState({
    this.status = ItemStatus.adding,
    this.quantity = 1,
    this.subTotal = 0,
    this.ingredients = const [],
  });

  @override
  List<Object> get props => [status, quantity, subTotal, ingredients];

  ItemState copyWith({
    ItemStatus? status,
    int? quantity,
    double? subTotal,
    List<Ingredient>? ingredients,
  }) {
    return ItemState(
      status: status ?? this.status,
      quantity: quantity ?? this.quantity,
      subTotal: subTotal ?? this.subTotal,
      ingredients: ingredients ?? this.ingredients,
    );
  }
}
