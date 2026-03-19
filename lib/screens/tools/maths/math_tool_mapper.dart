import 'package:flutter/material.dart';
import '../models/tool_field.dart';
import '../models/tool_result.dart';
import 'math_tool_screen.dart';
import 'math_formulas.dart';

class MathToolMapper {
  static Widget getTool(String title) {
    switch (title) {

    /// ================= PERCENTAGE =================
      case "Percentage Calculator":
        return MathToolScreen(
          title: title,
          fields: [
            ToolField(label: "Value"),
            ToolField(label: "Percentage (%)"),
          ],
          onCalculate: (v) {
            final map = MathFormulas.percentage(
              value: v[0],
              percent: v[1],
            );

            return ToolResult(
              mainLabel: "Result",
              mainValue: map["result"]!,
            );
          },
        );

    /// ================= RATIO =================
      case "Ratio Calculator":
        return MathToolScreen(
          title: title,
          fields: [
            ToolField(label: "Value A"),
            ToolField(label: "Value B"),
          ],
          onCalculate: (v) {
            final r = MathFormulas.ratio(
              a: v[0],
              b: v[1],
            );

            return ToolResult(
              mainLabel: "A",
              mainValue: r["a"]!,
              secondaryLabel: "B",
              secondaryValue: r["b"],
            );
          },
        );

    /// ================= AVERAGE =================
      case "Average Calculator":
        return MathToolScreen(
          title: title,
          fields: [
            ToolField(label: "Value 1"),
            ToolField(label: "Value 2"),
            ToolField(label: "Value 3"),
          ],
          onCalculate: (v) {
            final avg = MathFormulas.average(
              numbers: v,
            );

            return ToolResult(
              mainLabel: "Average",
              mainValue: avg["avg"]!,
              secondaryLabel: "Sum",
              secondaryValue: avg["sum"],
            );
          },
        );

    /// ================= LCM =================
      case "LCM Calculator":
        return MathToolScreen(
          title: title,
          fields: [
            ToolField(label: "Number A"),
            ToolField(label: "Number B"),
          ],
          onCalculate: (v) {
            final result = MathFormulas.lcm(
              v[0].toInt(),
              v[1].toInt(),
            );

            return ToolResult(
              mainLabel: "LCM",
              mainValue: result.toDouble(),
            );
          },
        );

    /// ================= GCD =================
      case "HCF / GCD Calculator":
        return MathToolScreen(
          title: title,
          fields: [
            ToolField(label: "Number A"),
            ToolField(label: "Number B"),
          ],
          onCalculate: (v) {
            final result = MathFormulas.gcd(
              v[0].toInt(),
              v[1].toInt(),
            );

            return ToolResult(
              mainLabel: "GCD / HCF",
              mainValue: result.toDouble(),
            );
          },
        );

    /// ================= SQUARE =================
      case "Square Calculator":
        return MathToolScreen(
          title: title,
          fields: [
            ToolField(label: "Value"),
          ],
          onCalculate: (v) {
            final result = MathFormulas.square(
              v[0],
            );

            return ToolResult(
              mainLabel: "Square",
              mainValue: result,
            );
          },
        );

    /// ================= CUBE =================
      case "Cube Calculator":
        return MathToolScreen(
          title: title,
          fields: [
            ToolField(label: "Value"),
          ],
          onCalculate: (v) {
            final result = MathFormulas.cube(
              value: v[0],
            );

            return ToolResult(
              mainLabel: "Cube",
              mainValue: result,
            );
          },
        );

    /// ================= ROOT =================
      case "Square Root":
        return MathToolScreen(
          title: title,
          fields: [
            ToolField(label: "Value"),
          ],
          onCalculate: (v) {
            final result = MathFormulas.squareRoot(
              value: v[0],
            );

            return ToolResult(
              mainLabel: "Square Root",
              mainValue: result,
            );
          },
        );

    /// ================= POWER =================
      case "Power Calculator":
        return MathToolScreen(
          title: title,
          fields: [
            ToolField(label: "Base"),
            ToolField(label: "Exponent"),
          ],
          onCalculate: (v) {
            final result = MathFormulas.power(
              base: v[0],
              exponent: v[1],
            );

            return ToolResult(
              mainLabel: "Result",
              mainValue: result,
            );
          },
        );

      default:
        return const Scaffold(
          body: Center(
            child: Text("Tool Not Found"),
          ),
        );
    }
  }
}
