import 'package:flutter/material.dart';

class PulseTheme {
  static ThemeData lightTheme = ThemeData(
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xffF2F2F7)),
      scaffoldBackgroundColor: const Color(0xffF2F2F7),
      tabBarTheme: const TabBarTheme(
          indicatorColor: Colors.black,
          labelStyle: TextStyle(
            fontFamily: 'SF-Pro',
            fontWeight: FontWeight.w400,
            fontSize: 15,
          ),
          labelColor: Colors.black,
          unselectedLabelColor: Color(0xff8E8E93),
          splashFactory: NoSplash.splashFactory,
          overlayColor: WidgetStatePropertyAll(Colors.transparent)),
      chipTheme: const ChipThemeData(
          labelStyle: TextStyle(
            fontFamily: 'SF-Pro',
            fontWeight: FontWeight.w500,
            fontSize: 13,
            // height: 18 / 13,
          ),
          labelPadding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          side: BorderSide.none,
          shape: StadiumBorder(),
          backgroundColor: Color(0xffF2F2F7)));
}
