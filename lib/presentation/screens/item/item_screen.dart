import 'package:flutter/material.dart';
import 'package:food_store/data/models/item_model.dart';
import 'package:food_store/presentation/config/constants.dart';

import 'bottom_bar.dart';
import 'ingredient_tile.dart';
import 'item_app_bar.dart';
import 'item_header.dart';

//import 'bottom_bar.dart';
class ItemScreen extends StatelessWidget {
  const ItemScreen({required this.item, Key? key}) : super(key: key);
  final Item item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            ItemAppBar(img: item.img),
            ItemHeader(title: item.title, description: item.description),
            const SliverToBoxAdapter(child: SizedBox(height: xPadding)),
            SliverList(
              delegate: SliverChildBuilderDelegate((_, i) {
                return IngredientTile(
                  index: i,
                  name: item.ingredients[i].name,
                  price: item.ingredients[i].price,
                );
              }, childCount: item.ingredients.length),
            ),
          ],
        ),
        bottomNavigationBar: SafeArea(child: const BottomBar()));
  }
}






  
                      // return CheckboxListTile(
                      //   value: true,
                      //   onChanged: (v) {
                      //     context.read<ItemCubit>().changeValue(i);
                      //   },
                      //   controlAffinity: ListTileControlAffinity.leading,
                      //   title: Text(item.ingredients[i].name),
                      //   secondary: Text(
                      //       item.ingredients[i].price.toStringAsFixed(2) + ' \u{20ac}'),
                      // );
// class ItemScreen extends StatelessWidget {
//   final Item item;
//   const ItemScreen({required this.item, Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         physics: const BouncingScrollPhysics(),
//         slivers: [
//           SliverAppBar(
//               stretch: true,
//               expandedHeight: MediaQuery.of(context).size.width * 9 / 16 -
//                   MediaQuery.of(context).padding.top,
//               flexibleSpace: const FlexibleSpaceBar(
//                   // background:
//                   //     Image.network(state.item.img, fit: BoxFit.cover)
//                   )),
//           SliverToBoxAdapter(
//               child: Container(
//                   padding: const EdgeInsets.only(
//                       left: 10, top: 10, right: 10, bottom: 10),
//                   decoration: const BoxDecoration(
//                     color: Colors.grey,
//                     //borderRadius: BorderRadius.vertical(bottom: Radius.circular(7))
//                   ),
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Title", //state.item.title,
//                           style: Theme.of(context).textTheme.titleLarge,
//                         ),
//                         Text(
//                           "description", //state.item.description,
//                           style: Theme.of(context).textTheme.bodySmall,
//                         ),
//                         Text(
//                           "basePrice", //state.item.basePrice.toString() + " \u{20AC}",
//                           style: Theme.of(context).textTheme.titleMedium,
//                         ),
//                       ]))),

//           const SliverToBoxAdapter(child: SizedBox(height: 20)),
//           BlocBuilder<ItemBloc, ItemState>(
//             builder: (context, state) {
//               print("BUILDED");
//               if (state is ItemLoaded) {
//                 return SliverList(
//                   delegate: SliverChildBuilderDelegate((_, i) {
//                     return CheckboxListTile(
//                       value: state.ingredients[i]
//                           .selected, //state.item.ingredients[i].selected,
//                       onChanged: (v) {
//                         context
//                             .read<ItemBloc>()
//                             .add(ItemIngredientChanged(v!, i));
//                         //state.item.ingredients[i].selected = v;
//                       },
//                       controlAffinity: ListTileControlAffinity.leading,
//                       title: Text(state.item.ingredients[i].name),
//                       secondary: Text(
//                           state.item.ingredients[i].price.toStringAsFixed(2) +
//                               ' \u{20ac}'),
//                     );
//                   }, childCount: state.item.ingredients.length),
//                 );
//               } else {
//                 return SliverToBoxAdapter(child: CircularProgressIndicator());
//               }
//             },
//           ),
//           // BlocBuilder<ItemBloc, ItemState>(
//           //   builder: (context, state) {
//           //     if (state is ItemLoaded) {
//           //       return SliverList(
//           //         delegate: SliverChildBuilderDelegate((_, i) {
//           //           bool? value = state.item.ingredients[i].selected;
//           //           return StatefulBuilder(
//           //             builder: (_, setState) {
//           //               return CheckboxListTile(
//           //                 value: value, //state.item.ingredients[i].selected,
//           //                 onChanged: (v) {
//           //                   //state.item.ingredients[i].selected = v;
//           //                   value = v;
//           //                   setState(() {});
//           //                 },
//           //                 controlAffinity: ListTileControlAffinity.leading,
//           //                 title: Text(state.item.ingredients[i].name),
//           //                 secondary: Text(state.item.ingredients[i].price
//           //                         .toStringAsFixed(2) +
//           //                     ' \u{20ac}'),
//           //               );
//           //             },
//           //           );
//           //         }, childCount: state.item.ingredients.length),
//           //       );
//           //     } else {
//           //       return CircularProgressIndicator();
//           //     }
//           //   },
//           // ),
//           // SliverList(
//           //   delegate: SliverChildBuilderDelegate((_, i) {
//           //     return StatefulBuilder(
//           //       builder: (_, setState) {
//           //         return CheckboxListTile(
//           //           value: state.item.ingredients[i].selected,
//           //           onChanged: (v) {
//           //             state.item.ingredients[i].selected = v;
//           //             setState(() {});
//           //           },
//           //           controlAffinity: ListTileControlAffinity.leading,
//           //           title: Text(state.item.ingredients[i].name),
//           //           secondary: Text(
//           //               state.item.ingredients[i].price.toStringAsFixed(2) +
//           //                   ' \u{20ac}'),
//           //         );
//           //       },
//           //     );
//           //   }, childCount: state.item.ingredients.length),
//           // ),
//         ],
//       ),
//       //bottomNavigationBar: BottomBar(),
//     );
//   }
// }
