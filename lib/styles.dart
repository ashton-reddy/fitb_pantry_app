
import 'package:flutter/material.dart';

class Spacing {
  static const double _matGridUnit = 8.0;
  static double matGridUnit({scale = 1}) {
    // Material design grid uses multiples of 8
    // Multiples of 4 are acceptable if needed
    // Only accept numbers that are full or half units of _matGridUnit
    assert(scale % .5 == 0);
    return _matGridUnit * scale;
  }
}

class AppColors {
  /// App Background
  /// Off white
  static const background = Color(0xFFF7F7F7);
  static const cardBackground = Colors.white;
  static const activeFillColor = Color(0xFFE0E0E0);

  /// Text Theme
  /// For cards, content, and canvas:
  static const textColor = Color.fromRGBO(35, 35, 50, .7);

  /// For 'Primary' theme
  /// For headings
  static const displayTextColor = Colors.black;

  /// for 'Accent' theme
  static const accentTextColor = Colors.white70;

  static const purple = Color(0xFFB59FB5);

  static MaterialColor primary = MaterialColor(0xFFC18083, _primarySwatch);
  static MaterialColor accent = MaterialColor(0xFFFEEAE6, _accentSwatch);
}

Map<int, Color> _primarySwatch = {
  50: const Color(0xFFFFF0E9),
  100: const Color(0xFFFFDBCF),
  200: const Color(0xFFFCB8AB),
  300: const Color(0xFFF2A9A5),
  400: const Color(0xFFE29896),
  500: const Color(0xFFC18083),
  600: const Color(0xFFA36A72),
  700: const Color(0xFF84565E),
  800: const Color(0xFF664046),
  900: const Color(0xFF442B2D),
};

Map<int, Color> _accentSwatch = {
  50: const Color(0xFFFEEAE6),
  100: const Color(0xFFFFCEB9),
  200: const Color(0xFFFEAE8B),
  300: const Color(0xFFFC8F5C),
  400: const Color(0xFFFA7736),
  500: const Color(0xFFF86203),
  600: const Color(0xFFEE5C00),
  700: const Color(0xFFE05400),
  800: const Color(0xFFD24D00),
  900: const Color(0xFFBA4000),
};

class Elevation {
  static List<BoxShadow> low = [
    const BoxShadow(color: Colors.black26, offset: Offset(1.0, 1.0), blurRadius: 1.0),
  ];

  static List<BoxShadow> high = [
    const BoxShadow(color: Colors.black26, offset: Offset(4.0, 4.0), blurRadius: 4.0),
    const BoxShadow(color: Colors.black26, offset: Offset(2.0, 2.0), blurRadius: 2.0),
    const BoxShadow(color: Colors.black26, offset: Offset(1.0, 1.0), blurRadius: 1.0),
  ];
}
