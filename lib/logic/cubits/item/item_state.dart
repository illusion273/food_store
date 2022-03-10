part of 'item_cubit.dart';

class ItemState extends Equatable {
  final int quantity;
  final double subTotal;
  final List<Ingredient> ingredients;
  const ItemState({
    this.quantity = 1,
    this.subTotal = 0,
    this.ingredients = const [],
  });

  @override
  List<Object> get props => [quantity, subTotal, ingredients];

  ItemState copyWith({
    int? quantity,
    double? subTotal,
    List<Ingredient>? ingredients,
  }) {
    return ItemState(
      quantity: quantity ?? this.quantity,
      subTotal: subTotal ?? this.subTotal,
      ingredients: ingredients ?? this.ingredients,
    );
  }
}
