import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color.fromARGB(255, 5, 166, 18), // プライマリカラー
    onPrimary: Colors.white, // プライマリカラーの上にあるテキストやアイコンの色
    secondary: Color(0xFF76FF03), // セカンダリカラー
    onSecondary: Colors.black, // セカンダリカラーの上にあるテキストやアイコンの色
    error: Colors.red, // エラーカラー
    onError: Colors.white, // エラーカラーの上にあるテキストやアイコンの色
    background: Colors.white, // 背景色
    onBackground: Colors.black, // 背景色の上にあるテキストやアイコンの色
    surface: Colors.white, // カードやダイアログなどの表面色
    onSurface: Colors.black, // 表面色の上にあるテキストやアイコンの色
  ),
  useMaterial3: true,
);

// Custom darkmode
// ThemeData darkMode = ThemeData(
//   brightness: Brightness.dark,
//   colorScheme: ColorScheme.dark(
//     background: Colors.grey.shade900,
//     primary: Colors.grey.shade800,
//     secondary: Colors.grey.shade700,
//   ),
// );
// Simple darkmode
ThemeData darkMode = ThemeData.dark();
