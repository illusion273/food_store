import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  final IconData iconData;
  final Function onTap;
  const SmallButton({
    required this.iconData,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      width: 35,
      child: TextButton(
        onPressed: () => onTap(),
        child: Icon(iconData),
        style: TextButton.styleFrom(
          primary: Colors.black,
          backgroundColor: const Color(0xffe8eaf6),
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        ),
      ),
    );
  }
}
