import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_store/data/models/item_model.dart';
import 'package:food_store/logic/all_blocs.dart';

part 'item_state.dart';

class ItemCubit extends Cubit<ItemState> {
  late Item _item;
  late List<Ingredient> _ingredients;
  late double _subTotal;
  final CartBloc _cartBloc;
  ItemCubit(CartBloc cartBloc)
      : _cartBloc = cartBloc,
        super(const ItemState());

  void passItem(Item item) {
    _item = item;
    _subTotal = _item.subTotal;
    _ingredients = List.from(_item.ingredients);

    emit(ItemState(subTotal: _subTotal, ingredients: _ingredients));
  }

  void passItemForEdit(Item item, int quantity) {
    _item = item;
    _subTotal = _item.subTotal;
    _ingredients = List.from(_item.ingredients);

    emit(ItemState(
        status: ItemStatus.editing,
        subTotal: _subTotal,
        ingredients: _ingredients,
        quantity: quantity));
  }

  void changeValue(int index) {
    List<Ingredient> ingredients = List.from(state.ingredients);
    bool value = !ingredients[index].selected;

    ingredients[index] = ingredients[index].copyWith(selected: value);
    double price = ingredients[index].price;
    value ? _subTotal += price : _subTotal -= price;

    emit(state.copyWith(ingredients: ingredients, subTotal: _subTotal));
  }

  void increment(bool increment) {
    int? quantity;
    if (increment) {
      quantity = state.quantity + 1;
    } else {
      if (state.quantity != 1) {
        quantity = state.quantity - 1;
      }
    }
    emit(state.copyWith(quantity: quantity));
  }

  void addToCart() {
    _item.copyWith(ingredients: state.ingredients);
    _cartBloc.add(CartItemAdded(
        item: _item.copyWith(ingredients: state.ingredients),
        quantity: state.quantity));
  }

  void updateToCart() {
    _item.copyWith(ingredients: state.ingredients);
    _cartBloc.add(CartItemUpdated(
        oldItem: _item,
        newItem: _item.copyWith(ingredients: state.ingredients),
        quantity: state.quantity));
  }
}
