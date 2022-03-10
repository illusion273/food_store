import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_store/data/models/cart_model.dart';
import 'package:food_store/data/models/item_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final Cart _cart;
  CartBloc(Cart cart)
      : _cart = cart,
        super(const CartState()) {
    on<CartStarted>(_onCartStarted);
    on<CartItemAdded>(_onCartItemAdded);
    on<CartItemUpdated>(_onCartItemUpdated);
    on<CartItemRemoved>(_onCartItemRemoved);
  }

  void _onCartStarted(CartStarted event, Emitter<CartState> emit) {
    emit(const CartState(status: CartStatus.loaded));
  }

  void _onCartItemAdded(CartItemAdded event, Emitter<CartState> emit) {
    _cart.addItems(event.item, event.quantity);
    var itemMap = _cart.getItemMap();
    for (var x in _cart.items) {
      print(x.title);
      print("\n\n");
      print(x.ingredientsToSingleString());
    }
    emit(CartState(
      status: CartStatus.loaded,
      itemMap: itemMap,
      totalPrice: _cart.total,
      totalQuantity: _cart.items.length.toString(),
    ));
  }

  void _onCartItemUpdated(CartItemUpdated event, Emitter<CartState> emit) {
    _cart.items.removeWhere((item) => item == event.placeholder);

    for (int i = 0; i < event.quantity; i++) {
      _cart.items.add(event.item);
    }
    Map<Item, int> itemMap = {};
    for (var item in _cart.items) {
      if (!itemMap.containsKey(item)) {
        itemMap[item] = 1;
      } else {
        itemMap[item] = itemMap[item]! + 1;
      }
    }

    for (var x in itemMap.entries) {
      print(x.key.title + "\n" + x.value.toString() + "\n");
      print("hi \n");
    }

    emit(CartState(
      status: CartStatus.loaded,
      itemMap: itemMap,
      totalPrice: _cart.total,
      totalQuantity: _cart.items.length.toString(),
    ));
  }

  void _onCartItemRemoved(CartItemRemoved event, Emitter<CartState> emit) {
    _cart.removeItems(event.item);
    var itemMap = _cart.getItemMap();
    for (var x in _cart.items) {
      print(x.title);
      print("\n\n");
      print(x.ingredientsToSingleString());
    }

    emit(CartState(
      status: CartStatus.loaded,
      itemMap: itemMap,
      totalPrice: _cart.total,
      totalQuantity: _cart.items.length.toString(),
    ));
  }
}
