import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_store/logic/cubits/item/item_cubit.dart';

class IngredientTile extends StatelessWidget {
  const IngredientTile({
    required this.index,
    required this.name,
    required this.price,
    Key? key,
  }) : super(key: key);

  final int index;
  final String name;
  final double price;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => context.read<ItemCubit>().changeValue(index),
      horizontalTitleGap: 4.5,
      dense: true,
      leading: BlocBuilder<ItemCubit, ItemState>(
        builder: (context, state) {
          return Icon(
            state.ingredients[index].selected
                ? Icons.check_circle
                : Icons.circle_outlined,
            size: 28,
          );
        },
      ),
      title: Text(
        name,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      trailing: Text(
        price.toString() + "\$",
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
// return InkWell(
    //   onTap: () => context.read<ItemCubit>().changeValue(index),
    //   child: Padding(
    //     padding: const EdgeInsets.only(left: xPadding, right: 30),
    //     child: Row(
    //       children: [
    //         BlocBuilder<ItemCubit, ItemState>(
    //             // buildWhen: (previous, current) =>
    //             //     previous.quantity == current.quantity,
    //             builder: (context, state) {
    //           return Icon(
    //             state.ingredients[index].selected
    //                 ? Icons.check_circle
    //                 : Icons.circle_outlined,
    //             size: 28,
    //           );
    //           // Transform.scale(
    //           //   scale: 1.3,
    //           //   child: AbsorbPointer(
    //           //     child: Checkbox(
    //           //       shape: const CircleBorder(),
    //           //       value: state.ingredients[index].selected,
    //           //       onChanged: (v) {},
    //           //     ),
    //           //   ),
    //           // );
    //         }),
    //         Text(
    //           name,
    //           style: Theme.of(context).textTheme.titleMedium,
    //         ),
    //         const Expanded(child: SizedBox()),
    //         Text(
    //           price.toString() + "\$",
    //           style: Theme.of(context).textTheme.titleMedium,
    //         ),
    //       ],
    //     ),
    //   ),
    // );