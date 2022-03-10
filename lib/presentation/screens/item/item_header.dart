import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_store/logic/cubits/item/item_cubit.dart';

class ItemHeader extends StatelessWidget {
  const ItemHeader({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
          padding:
              const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 245, 245, 245),
            //borderRadius: BorderRadius.vertical(bottom: Radius.circular(7))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              BlocBuilder<ItemCubit, ItemState>(
                builder: (context, state) {
                  return Text(
                    state.subTotal.toString() + " \u{20AC}",
                    style: Theme.of(context).textTheme.titleMedium,
                  );
                },
              ),
            ],
          )),
    );
  }
}
