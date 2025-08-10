import 'package:flutter/material.dart';

/// Centraliza a tipografia do app.
///
/// Observações:
/// - A família padrão é 'Roboto' (configure no pubspec.yaml).
/// - Cores seguem um tema escuro (brancos em diferentes opacidades).
class FontText {
  // Displays / Headlines
  static const TextStyle displayLarge = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle displaySmall = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // Titles
  static const TextStyle titleLarge = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // Body
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.white70,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.white60,
  );

  // Labels / Buttons
  static const TextStyle labelLarge = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    letterSpacing: 0.2,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Colors.white70,
    letterSpacing: 0.2,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: Colors.white60,
    letterSpacing: 0.2,
  );

  // Auxiliares
  static const TextStyle caption = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.white38,
  );

  static const TextStyle overline = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: Colors.white38,
    letterSpacing: 0.4,
  );
}
