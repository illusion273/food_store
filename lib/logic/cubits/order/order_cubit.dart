import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_store/data/models/cart_model.dart';
import 'package:food_store/data/models/item_model.dart';
import 'package:food_store/data/models/order_model.dart';
import 'package:food_store/data/repositories/all_repos.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final Cart _cart;
  final UserRepository _userRepository;
  final PrefsRepository _prefsRepository;
  OrderCubit(
      Cart cart, UserRepository userRepository, PrefsRepository prefsRepository)
      : _cart = cart,
        _userRepository = userRepository,
        _prefsRepository = prefsRepository,
        super(const OrderState());

  void postOrderData() async {
    emit(const OrderState(status: OrderStatus.posting));
    //try {
    var prefLocation = await _prefsRepository.getPrefLocation();
    if (prefLocation == null) {
      /// Inform User - Show SnackBar
      emit(const OrderState(status: OrderStatus.noLocation));
      return;
    }
    Order order = Order(
        location: prefLocation,
        items: _cart.items,
        total: _cart.total,
        timeStamp: DateTime.now().toString());
    await _userRepository.postOrderData(order);
    emit(const OrderState(status: OrderStatus.posted));
    //} catch (e) {
    //   throw Exception(e);
    //emit(const OrderState(status: OrderStatus.error));
    // }
  }
}
