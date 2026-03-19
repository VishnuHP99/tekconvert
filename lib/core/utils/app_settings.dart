import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class AppSettings {
  static int _decimalPlaces = 5;
  static bool _scientificEnabled = false;

  // Load once at app start
  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _decimalPlaces = prefs.getInt("decimal_places") ?? 5;
    _scientificEnabled = prefs.getBool("scientific_enabled") ?? false;
  }

  static int get decimalPlaces => _decimalPlaces;
  static bool get scientificEnabled => _scientificEnabled;

  static Future<void> setDecimalPlaces(int value) async {
    final prefs = await SharedPreferences.getInstance();
    _decimalPlaces = value;
    await prefs.setInt("decimal_places", value);
  }


  static Future<void> setScientificEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    _scientificEnabled = value;
    await prefs.setBool("scientific_enabled", value);
  }

  // ======================================
  // UNIVERSAL FORMATTER
  // ======================================
  static String format(double value) {
    double absVal = value.abs();

    // If scientific toggle ON
    if (_scientificEnabled &&
        ((absVal >= 1e6) || (absVal > 0 && absVal < 1e-4))) {
      return _toScientific(value);
    }

    // Normal comma separated formatting
    final formatter =
    NumberFormat("#,##0.${'#' * _decimalPlaces}");

    return formatter.format(value);
  }

  // ======================================
  // SCIENTIFIC FORMATTER → 6 × 10⁶
  // ======================================
  static String _toScientific(double value) {
    String exp = value.toStringAsExponential(_decimalPlaces);

    final parts = exp.split('e');
    double base = double.parse(parts[0]);
    int exponent = int.parse(parts[1]);

    String baseStr = base
        .toStringAsFixed(_decimalPlaces)
        .replaceAll(RegExp(r'0+$'), '')
        .replaceAll(RegExp(r'\.$'), '');

    return "$baseStr × 10${_toSuperscript(exponent)}";
  }

  // ======================================
  // Convert exponent → superscript
  // ======================================
  static String _toSuperscript(int number) {
    const superscripts = {
      '0': '⁰',
      '1': '¹',
      '2': '²',
      '3': '³',
      '4': '⁴',
      '5': '⁵',
      '6': '⁶',
      '7': '⁷',
      '8': '⁸',
      '9': '⁹',
      '-': '⁻',
    };

    return number
        .toString()
        .split('')
        .map((c) => superscripts[c] ?? '')
        .join();
  }
}
