import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';
import '../utils/padding.dart';

ThemeData appTheme() {
  return ThemeData(
    // Define the default brightness and colors.
    appBarTheme: const AppBarTheme(color: AppColors.appBarColor),
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    primaryColorDark: AppColors.primary,
    backgroundColor: AppColors.background,
    scaffoldBackgroundColor: AppColors.background,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        selectedItemColor: AppColors.primary,
        elevation: 0.0,
        type: BottomNavigationBarType.fixed),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: AppColors.primary),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.primary,
      padding: AppPading.defaultPadding,
    ),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(AppColors.primary),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22.0),
            )))),
    // Define the default font family.
    fontFamily: GoogleFonts.notoKufiArabic().fontFamily,

    // Define the default `TextTheme`. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    inputDecorationTheme: inputDecorationTheme(),
    textTheme: const TextTheme(
      // bodySmall: const TextStyle(fontSize: 14),
      headline1: TextStyle(
        fontSize: 24.0,
        color: AppColors.text,
        fontWeight: FontWeight.bold,
      ),
      headline6: TextStyle(
        fontSize: 20.0,
      ),
      bodyText2: TextStyle(
        fontSize: 14.0,
      ),
      bodyText1: TextStyle(
        fontSize: 11.0,
      ),
    ),
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(24),
    borderSide: const BorderSide(color: Colors.transparent),
    gapPadding: 4,
  );
  return InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.never,
    fillColor: AppColors.textFormFill,
    filled: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}
