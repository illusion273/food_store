part of 'order_cubit.dart';

enum OrderStatus { initial, posting, posted, noLocation, error }

class OrderState extends Equatable {
  const OrderState({this.status = OrderStatus.initial});

  final OrderStatus status;

  @override
  List<Object> get props => [status];
}
