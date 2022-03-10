import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_store/logic/blocs/cart/cart_bloc.dart';
import 'package:go_router/go_router.dart';

class CartButton extends StatelessWidget {
  const CartButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final y = 2 *
        MediaQuery.of(context).padding.bottom /
        MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment(0.0, 0.95 - y),
      child: InkWell(
        onTap: (() {
          context.push('/order');
        }),
        child: Container(
          height: 44,
          width: 200,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: const ShapeDecoration(
            color: Colors.yellow,
            shape: StadiumBorder(),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: Colors.white,
                child: BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    return Text(
                      state.totalQuantity,
                      style: Theme.of(context).textTheme.titleSmall,
                    );
                  },
                ),
              ),
              Expanded(
                child: BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    return Text(
                      state.totalPrice + "\u{20AC}",
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    );
                  },
                ),
              ),
              const Icon(Icons.shopping_cart_rounded)
            ],
          ),
        ),
      ),
    );
  }
}
