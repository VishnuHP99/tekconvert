import 'dart:math';
class MathFormulas {
  /// ================= PERCENTAGE =================

  static Map<String, double> percentage({
    required double value,
    required double percent,
  }) {
    return {
      "result": value * percent / 100,
    };
  }

  /// ================= RATIO =================

  static Map<String, double> ratio({
    required double a,
    required double b,
  }) {
    int x = a.round();
    int y = b.round();

    int g = _gcd(x, y);

    return {
      "a": x / g,
      "b": y / g,
    };
  }

  static int _gcd(int a, int b) {
    if (b == 0) return a;
    return _gcd(b, a % b);
  }

  /// ================= LCM =================

  static int lcm(int a, int b) {
    return (a * b) ~/ _gcd(a, b);
  }

  /// ================= HCF / GCD =================

  static int gcd(int a, int b) {
    return _gcd(a, b);
  }

  /// ================= SQUARE =================

  static double square(double value) {
    return value * value;
  }

  /// ================= CUBE =================
  static double cube({
    required double value,
  }) {
    return value * value * value;
  }

  /// ================= SQUARE ROOT =================
  static double squareRoot({
    required double value,
  }) {
    if (value < 0) return 0;
    return sqrt(value);
  }

  /// ================= POWER =================
  static double power({
    required double base,
    required double exponent,
  }) {
    return pow(base, exponent).toDouble();
  }


  /// ================= AVERAGE =================

  static Map<String, double> average({
    required List<double> numbers,
  }) {
    double sum = numbers.reduce((a, b) => a + b);
    double avg = sum / numbers.length;

    return {
      "avg": avg,
      "sum": sum,
    };





  }
}
