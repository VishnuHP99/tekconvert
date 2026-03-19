import '../../data/unit_map.dart';

/// Master conversion function
double convertValue({
  required String category,
  required double value,
  required String fromUnit,
  required String toUnit,
}) {

  // ---------- TEMPERATURE (SPECIAL CASE) ----------
  if (category.toLowerCase() == "temperature") {

    return _convertTemperature(value, fromUnit, toUnit);
  }

  // ---------- GENERIC FACTOR BASED ----------
  final categoryMap = unitMap[category];

  if (categoryMap == null) {
    // category not found
    return value;
  }

  final fromFactor = categoryMap[fromUnit];
  final toFactor   = categoryMap[toUnit];

  if (fromFactor == null || toFactor == null) {
    // unit not found
    return value;
  }

  // Convert to base unit
  final baseValue = value * fromFactor;

  // Convert from base to target
  return baseValue / toFactor;
}

////////////////////////////////////////////////////////////
/// TEMPERATURE CONVERSION
////////////////////////////////////////////////////////////

double _convertTemperature(double v, String from, String to) {

  double kelvin;

  if (from == "°C") {
    kelvin = v + 273.15;
  } else if (from == "°F") {
    kelvin = (v - 32) * 5 / 9 + 273.15;
  } else if (from == "°R") {
    kelvin = v * 5 / 9;
  } else { // K
    kelvin = v;
  }

  if (to == "°C") return kelvin - 273.15;
  if (to == "°F") return (kelvin - 273.15) * 9 / 5 + 32;
  if (to == "°R") return kelvin * 9 / 5;
  return kelvin;
}

