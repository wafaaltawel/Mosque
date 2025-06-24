import 'package:flutter/material.dart';

class FontStyles {
  // ألوان عامة
  static const Color primaryColor = Color(0xFF1E88E5);
  static const Color secondaryColor = Color(0xFF42A5F5);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color textColor = Colors.black;

  // أحجام
  static const double headingFontSize = 24;
  static const double bodyFontSize = 16;
  static const double smallFontSize = 12;

  static const String fontFamily = 'Almarai';

  // أنماط النصوص

  static const TextStyle bodyText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.bold,

  );

  static const TextStyle smallText = TextStyle(
    fontFamily: fontFamily,
    fontSize: smallFontSize,
    color: textColor,
  );

}
