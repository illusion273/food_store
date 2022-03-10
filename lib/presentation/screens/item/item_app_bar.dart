import 'package:flutter/material.dart';

class ItemAppBar extends StatelessWidget {
  const ItemAppBar({
    Key? key,
    required this.img,
  }) : super(key: key);
  final String img;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      stretch: true,
      expandedHeight: MediaQuery.of(context).size.width * 9 / 16 -
          MediaQuery.of(context).padding.top,
      flexibleSpace:
          FlexibleSpaceBar(background: Image.network(img, fit: BoxFit.cover)),
    );
  }
}
