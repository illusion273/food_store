import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_store/logic/all_blocs.dart';
import 'package:go_router/go_router.dart';

import '../../shared/small_button.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 179, 178, 178),
            blurRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmallButton(
                      iconData: Icons.remove,
                      onTap: () => context.read<ItemCubit>().increment(false)),
                  SizedBox(
                    width: 47,
                    child: BlocBuilder<ItemCubit, ItemState>(
                      buildWhen: (previous, current) =>
                          previous.quantity != current.quantity,
                      builder: (_, state) {
                        return Text(
                          state.quantity.toString(),
                          style: const TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                  ),
                  SmallButton(
                      iconData: Icons.add,
                      onTap: () => context.read<ItemCubit>().increment(true)),
                ],
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                    child: const Text("Add to cart"),
                    onPressed: () {
                      context.read<ItemCubit>().addToCart();
                      GoRouter.of(context).pop();
                    })),
          ),
        ],
      ),
    );
  }
}
