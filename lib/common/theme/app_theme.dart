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
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    shadowColor: Colors.white,
    modalBackgroundColor: Colors.white,
    modalBarrierColor: Colors.white,
    dragHandleColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.zero),
    ),
  ),
  popupMenuTheme: const PopupMenuThemeData(
    color: Colors.white,
  ),
);
