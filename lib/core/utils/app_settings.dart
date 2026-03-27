import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class AppSettings {
  static int _decimalPlaces = 5;
  static bool _scientificEnabled = false;

  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _decimalPlaces = prefs.getInt("decimal_places") ?? 5;
    _scientificEnabled = prefs.getBool("scientific_enabled") ?? true;
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
  // UNIVERSAL FORMATTER (CORRECTED)
  // ======================================
  static String format(double value) {
    double absVal = value.abs();

    // 1. SCIENTIFIC MODE
    if (_scientificEnabled &&
        ((absVal >= 1e6) || (absVal > 0 && absVal < 1e-6))) {
      return _toScientific(value);
    }

    // 2. USE STRICT USER SETTING
    int decimals = _decimalPlaces;

    // --- SMALL NUMBER HANDLING REMOVED TO ENSURE ROUNDING WORKS ---

    // 3. APPLY ROUNDING
    String fixed = value.toStringAsFixed(decimals);

    // 4. TRIM TRAILING ZEROS SAFELY
    if (fixed.contains('.')) {
      fixed = fixed
          .replaceAll(RegExp(r'0+$'), '') // Remove zeros at end
          .replaceAll(RegExp(r'\.$'), ''); // Remove dot if it's left at the end
    }

    // Failsafe for empty strings
    if (fixed.isEmpty || fixed == "-") {
      fixed = "0";
    }

    // 5. ADD COMMAS FOR THOUSANDS
    final parts = fixed.split('.');
    final intPart = parts[0];
    final decPart = parts.length > 1 ? parts[1] : null;

    final parsedInt = double.tryParse(intPart) ?? 0.0;
    final formattedInt = NumberFormat("#,##0").format(parsedInt);

    return decPart != null ? "$formattedInt.$decPart" : formattedInt;
  }

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

  static String _toSuperscript(int number) {
    const superscripts = {
      '0': '⁰', '1': '¹', '2': '²', '3': '³', '4': '⁴',
      '5': '⁵', '6': '⁶', '7': '⁷', '8': '⁸', '9': '⁹', '-': '⁻',
    };
    return number.toString().split('').map((c) => superscripts[c] ?? '').join();
  }
}