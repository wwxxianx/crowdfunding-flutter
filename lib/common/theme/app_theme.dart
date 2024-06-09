import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:flutter/material.dart';

final appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: CustomColors.primaryGreen),
  useMaterial3: true,
  fontFamily: "Satoshi",
  scaffoldBackgroundColor: Colors.white,
  tabBarTheme: const TabBarTheme(
    indicatorColor: Colors.black,
    labelColor: Colors.black,
  ),
  menuButtonTheme: MenuButtonThemeData(
    style: MenuItemButton.styleFrom(
      textStyle: CustomFonts.bodyMedium,
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    shadowColor: Colors.white,
    modalBackgroundColor: Colors.transparent,
    modalBarrierColor: Colors.black.withOpacity(0.6),
    dragHandleColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.zero),
    ),
  ),
  popupMenuTheme: const PopupMenuThemeData(
    color: Colors.white,
  ),
);
