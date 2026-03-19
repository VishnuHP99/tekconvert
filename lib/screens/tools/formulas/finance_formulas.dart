import 'dart:math';

class FinanceFormulas {

  /// EMI
  static Map<String, double> emi({
    required double principal,
    required double rate,
    required double months,
  }) {
    double r = rate / 12 / 100;

    double emi =
        (principal * r * pow(1 + r, months)) /
            (pow(1 + r, months) - 1);

    double totalPayment = emi * months;
    double totalInterest = totalPayment - principal;

    return {
      "emi": emi,
      "interest": totalInterest,
      "total": totalPayment,
    };
  }

  /// Simple Interest
  static Map<String, double> simpleInterest({
    required double principal,
    required double rate,
    required double years,
  }) {
    double interest = (principal * rate * years) / 100;
    double total = principal + interest;

    return {
      "interest": interest,
      "total": total,
    };
  }

  /// Compound Interest
  static Map<String, double> compoundInterest({
    required double principal,
    required double rate,
    required double years,
  }) {
    double amount = principal * pow(1 + rate / 100, years);
    double interest = amount - principal;

    return {
      "interest": interest,
      "total": amount,
    };
  }

  /// Discount
  static Map<String, double> discount({
    required double price,
    required double percent,
  }) {
    double save = price * percent / 100;
    double finalPrice = price - save;

    return {
      "final": finalPrice,
      "save": save,
    };
  }

  /// Profit
  static double profit(double cost, double sell) {
    return sell - cost;
  }

  /// Loss
  static double loss(double cost, double sell) {
    return cost - sell;
  }

  /// Sales Tax
  static Map<String, double> salesTax({
    required double amount,
    required double percent,
  }) {
    double tax = amount * percent / 100;
    double total = amount + tax;

    return {
      "tax": tax,
      "total": total,
    };
  }
}
