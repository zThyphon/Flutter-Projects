import 'package:flutter/material.dart';

class AppStyle {
  static Color mainColor = const Color(0xFF1321E0);
  static Color classicWhite = const Color(0xFFFFFFFF);
  static Color lightPink = const Color(0xFFF28B81);
  static Color yellow = const Color(0xFFF7BD02);
  static Color lightYellow = const Color(0xFFFBF476);
  static Color lightGreen = const Color(0xFFCDFF90);
  static Color turquoise = const Color(0xFFA7FEEB);
  static Color lightCyan = const Color(0xFFCBF0F8);
  static Color lightBlue = const Color(0xFFAFCBFA);
  static Color plum = const Color(0xFFD7AEFC);
  static Color mistyRose = const Color(0xFFFBCFE9);
  static Color lightBrown = const Color(0xFFE6C9A9);
  static Color lightGray = const Color(0xFFE9EAEE);

  static List<Color> cardsColor = [
    classicWhite,
    lightPink,
    yellow,
    lightYellow,
    lightGreen,
    turquoise,
    lightCyan,
    plum,
    mistyRose,
    lightBrown,
    lightGray,
  ];

  static const TextStyle headerStyle = TextStyle(
    fontFamily: "Open Sans",
    fontWeight: FontWeight.w500,
    fontSize: 24.0,
  );

  static const TextStyle titleStyle = TextStyle(
      fontFamily: "Open Sans",
      fontWeight: FontWeight.bold,
      fontSize: 28.0,
      color: Colors.black);

  static const TextStyle contentStyle = TextStyle(
      fontFamily: "Open Sans", fontWeight: FontWeight.w500, fontSize: 22.0);

  static const TextStyle dateStyle = TextStyle(
    fontFamily: "Open Sans",
    fontSize: 16.0,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle threedotitemsStyle = TextStyle(
    fontFamily: "Open Sans",
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );
}
