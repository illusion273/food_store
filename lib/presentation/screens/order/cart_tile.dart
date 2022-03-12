import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_store/data/models/item_model.dart';
import 'package:food_store/logic/all_blocs.dart';
import 'package:food_store/presentation/config/constants.dart';
import 'package:food_store/presentation/shared/small_button.dart';
import 'package:go_router/go_router.dart';

class CartTile extends StatefulWidget {
  final Item item;
  final int quantity;

  const CartTile({
    Key? key,
    required this.item,
    required this.quantity,
  }) : super(key: key);

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> with TickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<Offset> _imageAnimation;
  late Animation<Offset> _iconsAnimation;
  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _imageAnimation =
        Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0, 1, curve: Curves.easeIn),
      ),
    );
    _iconsAnimation =
        Tween<Offset>(begin: const Offset(1.2, 0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.3, 1, curve: Curves.easeIn),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          context.push('/order/${widget.item.id}',
              extra: {widget.item: widget.quantity});
        },
        onLongPress: () async {
          _animController.forward();
          await Future.delayed(const Duration(milliseconds: 2000));
          _animController.reverse();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.all(10),
                decoration: ShapeDecoration(
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(borderRad),
                      borderSide: const BorderSide(color: Colors.grey)),
                ),
                child: SizedBox(
                  width: 16,
                  height: 16,
                  child: Text(
                    widget.quantity.toString(),
                    textAlign: TextAlign.center,
                  ),
                )),
            const SizedBox(width: xPadding),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.item.title,
                    style: Theme.of(context).textTheme.titleSmall),
                if (widget.item.ingredients.isNotEmpty)
                  Text(widget.item.ingredientsToSingleString(),
                      style: Theme.of(context).textTheme.bodySmall)
                else
                  const SizedBox(height: 6),
                Text(widget.item.subTotal.toStringAsFixed(2) + "\u{20AC}"),
              ],
            ),
            const Expanded(child: SizedBox()),
            Row(
              children: [
                SlideTransition(
                  position: _imageAnimation,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: Image.network(
                      widget.item.img,
                      fit: BoxFit.cover,
                      width: 80,
                      height: 60,
                    ),
                  ),
                ),
                SlideTransition(
                  position: _iconsAnimation,
                  child: Row(
                    children: [
                      const SizedBox(width: 5),
                      SmallButton(
                          iconData: Icons.delete,
                          onTap: () => context
                              .read<CartBloc>()
                              .add(CartItemRemoved(widget.item))),
                      const SizedBox(width: 5),
                      SmallButton(
                          iconData: Icons.clear,
                          onTap: () => _animController.reverse()),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
