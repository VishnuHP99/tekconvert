import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/widgets/common/app_top_bar.dart';
import '../models/tool_field.dart';
import '../models/tool_result.dart';

class MathToolScreen extends StatefulWidget {
  final String title;
  final List<ToolField> fields;
  final ToolResult Function(List<double>) onCalculate;

  const MathToolScreen({
    super.key,
    required this.title,
    required this.fields,
    required this.onCalculate,
  });

  @override
  State<MathToolScreen> createState() => _MathToolScreenState();
}

class _MathToolScreenState extends State<MathToolScreen> {
  static const primary = Color(0xFF0F0F5F);

  late List<TextEditingController> controllers;
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();
    controllers =
        List.generate(widget.fields.length, (_) => TextEditingController());
  }

  TextEditingController get activeController => controllers[activeIndex];

  void setActive(int i) => setState(() => activeIndex = i);

  void add(String v) {
    HapticFeedback.selectionClick();
    setState(() => activeController.text += v);
  }

  void backspace() {
    if (activeController.text.isEmpty) return;

    setState(() {
      activeController.text =
          activeController.text.substring(0, activeController.text.length - 1);
    });
  }

  void clear() {
    HapticFeedback.mediumImpact();
    setState(() => activeController.clear());
  }

  void toggleSign() {
    if (activeController.text.isEmpty) return;

    if (activeController.text.startsWith("-")) {
      activeController.text = activeController.text.substring(1);
    } else {
      activeController.text = "-${activeController.text}";
    }

    setState(() {});
  }

  void calculate() {
    List<double> vals = [];

    for (final c in controllers) {
      if (c.text.isEmpty) return;
      vals.add(double.tryParse(c.text) ?? 0);
    }

    final result = widget.onCalculate(vals);
    showResult(result);
  }

  /// ================= RESULT =================

  void showResult(ToolResult r) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _resultSheet(r),
    );
  }

  Widget _resultSheet(ToolResult r) {
    final bottom = MediaQuery.of(context).viewPadding.bottom;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 16, 20, bottom + 28),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius:
            const BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 5,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              _resultCard(r.mainLabel, r.mainValue),
              if (r.secondaryValue != null) ...[
                const SizedBox(height: 12),
                _resultCard(r.secondaryLabel!, r.secondaryValue!),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _resultCard(String label, double value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 26),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value.toStringAsFixed(2),
            style: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: primary,
            ),
          ),
        ],
      ),
    );
  }

  /// ================= INPUT FIELD =================

  Widget field(String label, TextEditingController ctrl, int index) {
    final active = activeIndex == index;
    final hasValue = ctrl.text.isNotEmpty;

    return GestureDetector(
      onTap: () => setActive(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        height: 72,
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: active ? primary : Colors.grey.shade300,
            width: active ? 2 : 1,
          ),
        ),
        child: Stack(
          children: [
            /// Floating Label
            AnimatedPositioned(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
              top: (active || hasValue) ? 4 : 24,
              left: 10,
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 220),
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: (active || hasValue) ? 12 : 17,
                  fontWeight: FontWeight.w600,
                  color: active ? primary : Colors.grey,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  color: Colors.white, // 👈 this creates border cut effect
                  child: Text(label),
                ),
              ),
            ),

            /// Value Text
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 6, bottom: 10),
                child: Text(
                  ctrl.text,
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  /// ================= KEYPAD =================

  Widget key(String text) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (text == "+/-") {
            toggleSign();
          } else {
            add(text);
          }
        },
        child: Container(
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color(0xFFE9ECF1),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 26,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget sideKey(Widget child, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color(0xFFFFDADA),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Center(child: child),
        ),
      ),
    );
  }

  Widget row(List<String> keys) {
    return Expanded(
      child: Row(children: keys.map(key).toList()),
    );
  }

  /// ================= UI =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppTopBar(
              title: widget.title,
              currentIndex: -1,
              onBack: () => Navigator.pop(context),
            ),

            /// MAIN CARD (IMPORTANT — THIS WAS MISSING)
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F7),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  ...List.generate(
                    widget.fields.length,
                        (i) => field(
                      widget.fields[i].label,
                      controllers[i],
                      i,
                    ),
                  ),

                  const SizedBox(height: 10),

                  ElevatedButton(
                    onPressed: calculate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 16),
                    ),
                    child: const Text(
                      "Calculate",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// KEYPAD
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        row(["7", "8", "9"]),
                        row(["4", "5", "6"]),
                        row(["1", "2", "3"]),
                        row(["+/-", "0", "."]),
                      ],
                    ),
                  ),

                  /// RIGHT SIDE
                  Expanded(
                    child: Column(
                      children: [
                        sideKey(
                          const Icon(Icons.backspace, color: Colors.red),
                          backspace,
                        ),
                        sideKey(
                          const Text(
                            "AC",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          clear,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
