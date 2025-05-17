import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final lightColorScheme = ColorScheme.fromSeed(seedColor: Colors.brown);
final defaultLightTheme = ThemeData.light();
final lightTheme = defaultLightTheme.copyWith(
  colorScheme: lightColorScheme,
  appBarTheme: AppBarTheme().copyWith(
    backgroundColor: lightColorScheme.onPrimaryContainer,
    foregroundColor: lightColorScheme.primaryContainer,
  ),
  cardTheme: defaultLightTheme.cardTheme.copyWith(
    color: lightColorScheme.onPrimary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: lightColorScheme.primaryContainer,
      foregroundColor: lightColorScheme.onPrimaryContainer,
    ),
  ),
  textTheme: GoogleFonts.agbalumoTextTheme(),
);
