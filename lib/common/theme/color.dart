import 'package:flutter/material.dart';

class CustomColors {
  static const primaryGreen = Color(0xFFBCFF8F);
  static const accentGreen = Color(0xFF56BE88);
  static const primaryGreenGradient = LinearGradient(colors: [
    Color(0xFF9DFF9D),
    Color(0xFFE6FF82),
  ]);
  static const containerLightGreen = Color(0xFFF5FFF4);
  static const informationContainerGreen = Color(0xFFECFFEA);

  static const textBlack = Color(0xFF232323);
  static const textGrey = Color(0xFF8D8D8D);
  static const textDarkGreen = Color(0xFF1A3E01);

  static const inputBorder = Color(0xFFC0C4C3);

  static const divider = Color(0xFFD9D9D9);

  static const lightBlue = Color(0xFFEFF6FF);
  static const accentBlue = Color(0xFF1E40AF);

  static const pink = Color(0xFFFFDADD);
  static const alert = Color(0xFFF43F5E);

  static const containerBorderGrey = Color(0xFFE2E2EA);
  static const containerBorderGreen = Color(0xFF235600);

  static final containerLightShadow = [
    BoxShadow(
      blurRadius: 2.0,
      offset: Offset(0, 1),
      color: Colors.black.withOpacity(0.12),
    ),
    BoxShadow(
      blurRadius: 3.0,
      offset: Offset(0, 1),
      color: Colors.black.withOpacity(0.08),
    ),
  ];
  static final cardShadow = [
    BoxShadow(
      blurRadius: 2.0,
      offset: Offset(0, 1),
      color: Colors.black.withOpacity(0.3),
    ),
    BoxShadow(
      blurRadius: 3.0,
      offset: Offset(0, 1),
      color: Colors.black.withOpacity(0.15),
    )
  ];
  static const containerGreenShadow = [
    BoxShadow(
      blurRadius: 7.5,
      offset: Offset(0, 2),
      color: CustomColors.primaryGreen,
    )
  ];

  // Color Theme
  static const amber50 = Color(0xFFFFFFEC);
  static const amber100 = Color(0xFFFEF3C7);
  static const amber500 = Color(0xFFFFEEC3);
  static const amber700 = Color(0xFF92400E);

  static const red100 = Color(0xFFFEE2E2);

  static const slate100 = Color(0xFFF1F5F9);
  static const slate700 = Color(0xFF334155);

  static const purple200 = Color(0xFFE3E9FF);
}
