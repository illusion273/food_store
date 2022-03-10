import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Function authAction;

  const AuthButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.color,
    required this.authAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 210,
      child: ElevatedButton.icon(
        icon: Icon(icon, color: Colors.white, size: 20),
        style: ElevatedButton.styleFrom(primary: color
            // padding: const EdgeInsets.all(24),
            //backgroundColor: color,
            ),
        onPressed: () => authAction(),
        label: Text(label),
      ),
    );
  }
}
