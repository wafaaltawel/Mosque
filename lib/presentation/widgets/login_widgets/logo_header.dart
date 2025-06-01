import 'package:flutter/material.dart';

class LogoHeader extends StatelessWidget {
  const LogoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.mosque, size: 48, color: Colors.white),
        SizedBox(width: 10),
        Text(
          "منصة حلقات",
          style: TextStyle(
            fontSize: 28,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
          ),
          textDirection: TextDirection.rtl,
        ),
      ],
    );
  }
}
