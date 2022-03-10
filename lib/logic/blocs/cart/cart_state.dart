part of 'cart_bloc.dart';

enum CartStatus { initial, loaded }

class CartState extends Equatable {
  final CartStatus status;
  final Map<Item, int> itemMap;
  final String totalPrice;
  final String totalQuantity;

  const CartState({
    this.status = CartStatus.initial,
    this.itemMap = const {},
    this.totalPrice = "0.00",
    this.totalQuantity = "0",
  });

  CartState copyWith({
    CartStatus? status,
    Map<Item, int>? itemMap,
    String? totalPrice,
    String? totalQuantity,
  }) {
    return CartState(
      status: status ?? this.status,
      itemMap: itemMap ?? this.itemMap,
      totalPrice: totalPrice ?? this.totalPrice,
      totalQuantity: totalQuantity ?? this.totalQuantity,
    );
  }

  @override
  List<Object> get props => [status, itemMap, totalPrice, totalQuantity];
}
