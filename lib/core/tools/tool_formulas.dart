import 'dart:math';
class ToolFormulas {

  // =====================================================
  // FINANCE
  // =====================================================

  static double simpleInterest({
    required double principal,
    required double rate,
    required double time,
  }) {
    return (principal * rate * time) / 100;
  }

  static double compoundInterest({
    required double principal,
    required double rate,
    required double time,
  }) {
    return principal * pow(1 + rate / 100, time);
  }


  static double emi({
    required double principal,
    required double annualRate,
    required double months,
  }) {
    double r = annualRate / 12 / 100;

    if (r == 0) return principal / months;

    return (principal * r * pow(1 + r, months)) /
        (pow(1 + r, months) - 1);
  }


  static double loanTotal({
    required double emi,
    required double months,
  }) {
    return emi * months;
  }

  // =====================================================
  // BUSINESS
  // =====================================================

  static double profitPercent({
    required double cost,
    required double selling,
  }) {
    return ((selling - cost) / cost) * 100;
  }


  static double lossPercent({
    required double cost,
    required double selling,
  }) {
    return ((cost - selling) / cost) * 100;
  }


  static double discount({
    required double price,
    required double percent,
  }) {
    return price * percent / 100;
  }

  static double salesTax({
    required double amount,
    required double taxPercent,
  }) {
    return amount * taxPercent / 100;
  }

  // =====================================================
  // HEALTH
  // =====================================================

  static double bmi({
    required double weightKg,
    required double heightMeter,
  }) {
    return weightKg / (heightMeter * heightMeter);
  }

  // =====================================================
  // MATH
  // =====================================================

  static double percentage({
    required double value,
    required double total,
  }) {
    return (value / total) * 100;
  }

  static double average(List<double> numbers) {
    if (numbers.isEmpty) return 0;
    return numbers.reduce((a, b) => a + b) /
        numbers.length;
  }

  static double ratio(double a, double b) {
    return a / b;
  }

}
