import 'package:flutter/material.dart';
import 'package:flutter_create/utils/settings_service.dart';

class AppTheme {
  static final AppTheme _singleton = AppTheme._internal();

  factory AppTheme() {
    return _singleton;
  }

  AppTheme._internal();

  static final Color bottomSheetBackgroundColor = Colors.grey.shade800;
  static final Color scaffoldBackgroundColor = Colors.grey.shade900;
  static final Color navbarBackground = Colors.indigo.shade100;

  static TextStyle inputTextStyle = const TextStyle(
    fontSize: 25,
  );
  static TextStyle rupeeStyle = const TextStyle(
    fontSize: 18,
  );

  bool _isDark = false;

  static bool get isDark => _singleton._isDark;

  static set isDark(bool value) {
    _singleton._isDark = value;
  }

  static const _lightFillColor = Colors.black;
  static const _darkFillColor = Colors.white;

  static Color get themeTextColor => isDark ? _lightFillColor : _darkFillColor;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData =
      _themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = _themeData(darkColorScheme, _darkFocusColor);

  static ThemeData _themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      textTheme: textTheme,
      // Matches manifest.json colors and background color.
      primaryColor: const Color(0xFF030303),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.primary),
      ),
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
      canvasColor: colorScheme.surface,
      scaffoldBackgroundColor: colorScheme.surface,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.alphaBlend(
          _lightFillColor.withOpacity(0.80),
          _darkFillColor,
        ),
        contentTextStyle: textTheme.titleMedium!.apply(color: _darkFillColor),
      ),
    );
  }

  Settings appSettings = Settings();

  static ColorScheme get colorScheme =>
      Settings.getTheme == ThemeMode.light ? lightColorScheme : darkColorScheme;

  static ColorScheme lightColorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 126, 120, 211),
    //   primary: Color.fromARGB(255, 87, 138, 206),
    //   primaryContainer: Color(0xFF117378),
    //   secondary: Color(0xFFEFF3F3),
    //   secondaryContainer: Color(0xFFFAFBFB),
    surface: const Color.fromARGB(255, 230, 219, 253),
    //   surface: Color(0xFFFAFBFB),
    //   onBackground: Colors.white,
    //   error: _lightFillColor,
    //   onError: _lightFillColor,
    onPrimary: _lightFillColor,
    //   onSecondary: Color(0xFF322942),
    onSurface: const Color(0xFF241E30),
    //   brightness: Brightness.light,
  );

  static ColorScheme darkColorScheme = const ColorScheme(
    primary: Color(0xFFFF8383),
    primaryContainer: Color(0xFF1CDEC9),
    secondary: Color(0xFF4D1F7C),
    secondaryContainer: Color(0xFF451B6F),
    surface: Color(0xFF1F1929), // White with 0.05 opacity
    error: _darkFillColor,
    onError: _darkFillColor,
    onPrimary: _darkFillColor,
    onSecondary: _darkFillColor,
    onSurface: _darkFillColor,
    brightness: Brightness.dark,
  );

  static FontWeight get regular => _regular;
  static FontWeight get medium => _medium;
  static FontWeight get semiBold => _semiBold;
  static FontWeight get bold => _bold;

  static const _regular = FontWeight.normal;
  static const _medium = FontWeight.w500;
  static const _semiBold = FontWeight.w600;
  static const _bold = FontWeight.w700;

  static const TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(fontWeight: _bold, fontSize: 56.0),
    displayMedium: TextStyle(fontWeight: _bold, fontSize: 48.0),
    displaySmall: TextStyle(fontWeight: _bold, fontSize: 32.0),
    headlineMedium: TextStyle(fontWeight: _bold, fontSize: 20.0),
    headlineSmall: TextStyle(fontWeight: _bold, fontSize: 16.0),
    titleLarge: TextStyle(fontWeight: _bold, fontSize: 16.0),
    bodySmall: TextStyle(fontWeight: _semiBold, fontSize: 16.0),
    titleMedium: TextStyle(fontWeight: _medium, fontSize: 16.0),
    titleSmall: TextStyle(fontWeight: _medium, fontSize: 14.0),
    labelSmall: TextStyle(fontWeight: _medium, fontSize: 12.0),
    bodyLarge: TextStyle(fontWeight: _regular, fontSize: 14.0),
    bodyMedium: TextStyle(fontWeight: _regular, fontSize: 16.0),
    labelLarge: TextStyle(fontWeight: _semiBold, fontSize: 14.0),
  );
}
