import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData buildThemeData() {
  return ThemeData(
    brightness: Brightness.light,
    // primaryColor: Colors.blue.shade700,
    primaryColor: Colors.black,
    accentColor: Colors.orange.shade500,
    // scaffoldBackgroundColor: Colors.blue.shade700,
    scaffoldBackgroundColor: Colors.white,
    textSelectionHandleColor: Colors.white,
    textSelectionColor: Colors.black12,
    cursorColor: Colors.black,
    toggleableActiveColor: Colors.black,
    inputDecorationTheme: InputDecorationTheme(
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black.withOpacity(0.1)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
      labelStyle: const TextStyle(
        color: Colors.black,
      ),
    ),
  );
}

const SystemUiOverlayStyle lightSystemUiOverlayStyle = SystemUiOverlayStyle(
  statusBarColor: Colors.white,
  systemNavigationBarColor: Colors.white,
  systemNavigationBarDividerColor: Colors.black,
  systemNavigationBarIconBrightness: Brightness.dark,
);
