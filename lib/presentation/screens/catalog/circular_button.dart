import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  final IconData iconData;
  final Function onTap;
  const CircularButton({
    Key? key,
    required this.iconData,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.grey.shade200,
      foregroundColor: Colors.black,
      child: IconButton(
        onPressed: () => onTap(),
        icon: Icon(iconData),
      ),
    );
  }
}
