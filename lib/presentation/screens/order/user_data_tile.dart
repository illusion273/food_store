import 'package:flutter/material.dart';

class UserDataTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? subtitlePlus;
  final IconData icon;
  final Function onTap;
  const UserDataTile({
    Key? key,
    required this.title,
    required this.subtitle,
    this.subtitlePlus,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      borderRadius: BorderRadius.circular(7),
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        width: double.maxFinite,
        decoration: ShapeDecoration(
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(
              width: 2,
              color: Colors.black12,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 5),
                Text(
                  subtitlePlus == null ? subtitle : "$subtitle\n$subtitlePlus",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            Icon(
              icon,
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}
