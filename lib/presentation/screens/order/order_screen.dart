import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_store/logic/blocs/cart/cart_bloc.dart';
import 'package:food_store/logic/cubits/order/order_cubit.dart';
import 'package:food_store/presentation/config/constants.dart';

import 'cart_tile.dart';
import 'user_info.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(title: Text("Cart"), pinned: true),
            const UserInfo(),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: xPadding),
              sliver: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return SliverList(
                      delegate: SliverChildBuilderDelegate((_, i) {
                    return Align(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CartTile(
                              item: state.itemMap.keys.elementAt(i),
                              quantity: state.itemMap.values.elementAt(i)),
                          const SizedBox(height: 20),
                        ],
                      ),
                    );
                  }, childCount: state.itemMap.length));
                },
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: xPadding),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const Divider(color: Colors.black),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order total:",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      BlocBuilder<CartBloc, CartState>(
                        builder: (context, state) {
                          return Text(state.totalPrice + "\u{20AC}",
                              style: Theme.of(context).textTheme.titleLarge);
                        },
                      ),
                    ],
                  ),
                ]),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          height: 60,
          color: Colors.white,
          padding: EdgeInsets.all(16),
          child: ElevatedButton(
              onPressed: () {
                context.read<OrderCubit>().postOrderData();
              },
              child: Text("Checkout")),
        ));
  }
}
