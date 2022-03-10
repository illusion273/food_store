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
  final Item item;
  final Item placeholder;
  final int quantity;
  const CartItemUpdated({
    required this.item,
    required this.placeholder,
    required this.quantity,
  });

  @override
  List<Object> get props => [item, placeholder, quantity];
}
