import 'package:flutter/material.dart';

class AppTheme {
  final Color seedScheme = Colors.deepPurple;
  ThemeData getTheme() => ThemeData(
      useMaterial3: true,
      colorSchemeSeed: seedScheme,
      listTileTheme: ListTileThemeData(iconColor: seedScheme));
      
}
