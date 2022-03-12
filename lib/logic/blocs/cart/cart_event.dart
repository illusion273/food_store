part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartStarted extends CartEvent {}

class CartItemRemoved extends CartEvent {
  final Item item;
  const CartItemRemoved(this.item);
}

class CartItemAdded extends CartEvent {
  final Item item;
  final int quantity;
  const CartItemAdded({
    required this.item,
    required this.quantity,
  });

  @override
  List<Object> get props => [item, quantity];
}

class CartItemUpdated extends CartEvent {
  final Item oldItem;
  final Item newItem;
  final int quantity;
  const CartItemUpdated({
    required this.oldItem,
    required this.newItem,
    required this.quantity,
  });

  @override
  List<Object> get props => [oldItem, newItem, quantity];
}
