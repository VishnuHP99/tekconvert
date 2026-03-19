import 'package:flutter/material.dart';
import 'models/tool_field.dart';
import 'models/tool_result.dart';
import 'formulas/finance_formulas.dart';
import 'screens/universal_tool_calculator_screen.dart';
import 'screens/sales_tax_calculator_screen.dart';
import 'maths/math_tool_mapper.dart';


class ToolMapper {
  static Widget getScreen(String title) {
    switch (title) {
      case "EMI Calculator":
        return UniversalToolCalculatorScreen(
          title: title,
          fields: const [
            ToolField(label: "Loan Amount"),
            ToolField(label: "Interest Rate (%)"),
            ToolField(label: "Tenure (Months)"),
          ],
          onCalculate: (v) {
            final r = FinanceFormulas.emi(
              principal: v[0],
              rate: v[1],
              months: v[2],
            );

            return ToolResult(
              mainValue: r["emi"]!,
              secondaryValue: r["interest"],
              tertiaryValue: r["total"],
              mainLabel: "Monthly EMI",
              secondaryLabel: "Total Interest",
              tertiaryLabel: "Total Payment",
            );
          },
        );

      case "Loan Calculator":
        return UniversalToolCalculatorScreen(
          title: title,
          fields: const [
            ToolField(label: "Loan Amount"),
            ToolField(label: "Interest Rate (%)"),
            ToolField(label: "Tenure (Months)"),
          ],
          onCalculate: (v) {
            final r = FinanceFormulas.emi(
              principal: v[0],
              rate: v[1],
              months: v[2],
            );

            return ToolResult(
              mainValue: r["total"]!,
              secondaryValue: r["emi"],
              mainLabel: "Total Payment",
              secondaryLabel: "Monthly EMI",
            );
          },
        );

      case "Simple Interest":
        return UniversalToolCalculatorScreen(
          title: title,
          fields: const [
            ToolField(label: "Principal"),
            ToolField(label: "Rate (%)"),
            ToolField(label: "Time (Years)"),
          ],
          onCalculate: (v) {
            final r = FinanceFormulas.simpleInterest(
              principal: v[0],
              rate: v[1],
              years: v[2],
            );

            return ToolResult(
              mainValue: r["interest"]!,
              secondaryValue: r["total"],
              mainLabel: "Interest",
              secondaryLabel: "Total Amount",
            );
          },
        );

      case "Compound Interest":
        return UniversalToolCalculatorScreen(
          title: title,
          fields: const [
            ToolField(label: "Principal"),
            ToolField(label: "Rate (%)"),
            ToolField(label: "Time (Years)"),
          ],
          onCalculate: (v) {
            final r = FinanceFormulas.compoundInterest(
              principal: v[0],
              rate: v[1],
              years: v[2],
            );

            return ToolResult(
              mainValue: r["interest"]!,
              secondaryValue: r["total"],
              mainLabel: "Interest",
              secondaryLabel: "Total Amount",
            );
          },
        );

      case "Profit Calculator":
        return UniversalToolCalculatorScreen(
          title: title,
          fields: const [
            ToolField(label: "Cost Price"),
            ToolField(label: "Selling Price"),
          ],
          onCalculate: (v) {
            final profit = v[1] - v[0];

            return ToolResult(
              mainValue: profit,
              mainLabel: "Profit",
            );
          },
        );

      case "Loss Calculator":
        return UniversalToolCalculatorScreen(
          title: title,
          fields: const [
            ToolField(label: "Cost Price"),
            ToolField(label: "Selling Price"),
          ],
          onCalculate: (v) {
            final loss = v[0] - v[1];

            return ToolResult(
              mainValue: loss,
              mainLabel: "Loss",
            );
          },
        );

      case "Discount Calculator":
        return UniversalToolCalculatorScreen(
          title: title,
          fields: const [
            ToolField(label: "Original Price"),
            ToolField(label: "Discount (%)"),
          ],
          onCalculate: (v) {
            final r = FinanceFormulas.discount(
              price: v[0],
              percent: v[1],
            );

            return ToolResult(
              mainValue: r["final"]!,
              secondaryValue: r["save"],
              mainLabel: "Final Price",
              secondaryLabel: "You Save",
            );
          },
        );

      case "Sales Tax Calculator":
        return const SalesTaxCalculatorScreen();


      case "BMI Calculator":
        return UniversalToolCalculatorScreen(
          title: title,
          fields: const [
            ToolField(label: "Weight (kg)"),
            ToolField(label: "Height (m)"),
          ],
          onCalculate: (v) {
            final bmi = v[0] / (v[1] * v[1]);

            return ToolResult(
              mainValue: bmi,
              mainLabel: "BMI",
            );
          },
        );

    /// ================= MATH =================

      case "Percentage Calculator":
      case "Ratio Calculator":
      case "Average Calculator":
      case "LCM Calculator":
      case "HCF / GCD Calculator":
      case "Square Calculator":
      case "Cube Calculator":
      case "Square Root":
      case "Power Calculator":
        return MathToolMapper.getTool(title);

    // default

      default:
        return const Scaffold(
          body: Center(
            child: Text("Tool Not Found"),
          ),
        );
    }
  }
}
