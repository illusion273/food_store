import 'package:flutter/material.dart';

class CatalogTile extends StatelessWidget {
  final String img;
  final String title;
  final String description;
  final double price;
  final Function onTap;

  const CatalogTile({
    Key? key,
    required this.img,
    required this.title,
    required this.description,
    required this.price,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        InkWell(
          onTap: (() => onTap()),
          child: SizedBox(
            height: 90,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Image.network(
                    img,
                    fit: BoxFit.fill,
                    width: 120,
                    height: 90,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    mainAxisAlignment: (description.isEmpty)
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        price.toString() + "\u{20AC}",
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        const Divider(),
      ],
    );
  }
}
