import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/app/domain/repositories/preferences_repositories.dart';
import 'package:flutter_application_1/app/ui/utils/colors.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeController extends SimpleNotifier {
  late ThemeMode _mode;

  ThemeController() {
    _mode = _preferences.isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  final PreferencesRepository _preferences = Get.i.find();

  ThemeMode get mode => _mode;
  bool get isDark => _mode == ThemeMode.dark;

  TextTheme get _textTheme {
    return GoogleFonts.nunitoSansTextTheme();
  }

  ThemeData get lightTheme {
    return ThemeData.light().copyWith(
      brightness: Brightness.light,
      scaffoldBackgroundColor: backgroundLigthColor,
      iconTheme: const IconThemeData(
        color: primaryLigthColor,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundLigthColor,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
        ),
      ),
      primaryColorLight: primaryLigthColor,
      textTheme: _textTheme.merge(ThemeData.dark().textTheme).apply(
            fontFamily: _textTheme.bodyText1!.fontFamily,
          ),
      colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.light,
        primarySwatch: MaterialColor(primaryLigthColor.value, swatch),
      ),
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: primaryLigthColor.withOpacity(0.5),
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: backgroundDarkColor,
          ),
        ),
      ),
    );
  }

  ThemeData get darkTheme {
    // final isDark = context.isDark;
    // final Color statusColor = isDark ? primaryDarkColor : primaryLigthColor;
    return ThemeData.dark().copyWith(
      brightness: Brightness.dark,
      iconTheme: const IconThemeData(
        color: backgroundLigthColor,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryDarkColor,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
      ),
      textTheme: _textTheme.merge(ThemeData.dark().textTheme).apply(
            fontFamily: _textTheme.bodyText1!.fontFamily,
          ),
      scaffoldBackgroundColor: backgroundDarkColor,
      primaryColorDark: primaryDarkColor,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: primaryDarkColor,
      ),
      colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.dark,
        primarySwatch: MaterialColor(primaryDarkColor.value, swatch),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: primaryDarkColor,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white54,
          ),
        ),
      ),
    );
  }

  void toggle() {
    if (_mode == ThemeMode.light) {
      _mode = ThemeMode.dark;
      _preferences.darkMode(true);
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.light,
      );
    } else {
      _mode = ThemeMode.light;
      _preferences.darkMode(false);
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark,
      );
    }
    notify();
  }
}

final themeProvider = SimpleProvider(
  (_) => ThemeController(),
  autoDispose: false,
);
