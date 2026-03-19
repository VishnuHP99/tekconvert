import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/widgets/common/app_top_bar.dart';
import '../models/tool_field.dart';
import '../models/tool_result.dart';

class UniversalToolCalculatorScreen extends StatefulWidget {
  final String title;
  final List<ToolField> fields;
  final ToolResult Function(List<double>) onCalculate;

  const UniversalToolCalculatorScreen({
    super.key,
    required this.title,
    required this.fields,
    required this.onCalculate,
  });

  @override
  State<UniversalToolCalculatorScreen> createState() =>
      _UniversalToolCalculatorScreenState();
}

class _UniversalToolCalculatorScreenState
    extends State<UniversalToolCalculatorScreen>
    with TickerProviderStateMixin {
  static const primary = Color(0xFF0F0F5F);

  late List<TextEditingController> controllers;
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();
    controllers =
        List.generate(widget.fields.length, (_) => TextEditingController());
  }

  @override
  void dispose() {
    for (final c in controllers) {
      c.dispose();
    }
    super.dispose();
  }

  TextEditingController get activeController => controllers[activeIndex];

  void setActive(int i) => setState(() => activeIndex = i);

  void add(String v) {
    HapticFeedback.selectionClick();
    setState(() => activeController.text += v);
  }

  void backspace() {
    if (activeController.text.isEmpty) return;
    HapticFeedback.selectionClick();

    setState(() {
      activeController.text = activeController.text
          .substring(0, activeController.text.length - 1);
    });
  }

  void clear() {
    HapticFeedback.mediumImpact();
    setState(() => activeController.clear());
  }

  void toggleSign() {
    if (activeController.text.isEmpty) return;

    if (activeController.text.startsWith("-")) {
      activeController.text =
          activeController.text.substring(1);
    } else {
      activeController.text = "-${activeController.text}";
    }

    setState(() {});
  }

  void calculate() {
    HapticFeedback.heavyImpact();

    List<double> vals = [];

    for (final c in controllers) {
      if (c.text.isEmpty) return;
      vals.add(double.tryParse(c.text) ?? 0);
    }

    final result = widget.onCalculate(vals);
    _showResult(result);
  }

  /// ================= RESULT SHEET =================

  void _showResult(ToolResult r) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        final bottom = MediaQuery.of(context).viewPadding.bottom;

        return GestureDetector(
          onVerticalDragDown: (_) => Navigator.pop(context),
          child: ClipRRect(
            borderRadius:
            const BorderRadius.vertical(top: Radius.circular(36)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
              child: Container(
                padding:
                EdgeInsets.fromLTRB(20, 16, 20, bottom + 28),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.92),
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(36)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 60,
                        height: 5,
                        margin:
                        const EdgeInsets.only(bottom: 22),
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius:
                          BorderRadius.circular(10),
                        ),
                      ),

                      _resultCard(
                          r.mainLabel, r.mainValue ?? 0, true),

                      if (r.secondaryValue != null) ...[
                        const SizedBox(height: 14),
                        _resultCard(
                            r.secondaryLabel ?? "",
                            r.secondaryValue!,
                            false),
                      ],

                      if (r.tertiaryValue != null) ...[
                        const SizedBox(height: 14),
                        _resultCard(
                            r.tertiaryLabel ?? "",
                            r.tertiaryValue!,
                            false),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _resultCard(String label, double value, bool big) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: const LinearGradient(
          colors: [Colors.white, Color(0xFFF4F6FA)],
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 30,
            color: Colors.black.withOpacity(0.08),
            offset: const Offset(0, 14),
          )
        ],
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
          const SizedBox(height: 10),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: value),
            duration: const Duration(milliseconds: 600),
            builder: (_, v, __) {
              return Text(
                v.toStringAsFixed(2),
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: big ? 40 : 26,
                  fontWeight: FontWeight.w700,
                  color: primary,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /// ================= INPUT FIELD =================

  Widget inputField(int i) {
    final active = activeIndex == i;
    final hasValue = controllers[i].text.isNotEmpty;

    return GestureDetector(
      onTap: () => setActive(i),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
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
            AnimatedPositioned(
              duration: const Duration(milliseconds: 220),
              top: (active || hasValue) ? 4 : 24,
              left: 10,
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 220),
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize:
                  (active || hasValue) ? 12 : 17,
                  fontWeight: FontWeight.w600,
                  color: active
                      ? primary
                      : Colors.grey,
                ),
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 6),
                  color: Colors.white,
                  child: Text(widget.fields[i].label),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding:
                const EdgeInsets.only(left: 6, bottom: 10),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    controllers[i].text,
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
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
            color: const Color(0xFFF1F3F6),
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color: Colors.black.withOpacity(0.06),
                offset: const Offset(0, 5),
              )
            ],
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

  Widget sideKey(String text, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color(0xFFFFDADA),
            borderRadius: BorderRadius.circular(22),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: Colors.red,
              ),
            ),
          ),
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

            Padding(
              padding:
              const EdgeInsets.fromLTRB(16, 14, 16, 8),
              child: Container(
                padding:
                const EdgeInsets.fromLTRB(18, 24, 18, 22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.circular(28),
                  border: Border.all(
                      color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 24,
                      color:
                      Colors.black.withOpacity(0.06),
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    ...List.generate(widget.fields.length,
                            (i) => inputField(i)),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: calculate,
                        style:
                        ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          shape:
                          const StadiumBorder(),
                          padding:
                          const EdgeInsets
                              .symmetric(
                              vertical: 18),
                        ),
                        child: const Text(
                          "Calculate",
                          style: TextStyle(
                            fontFamily:
                            'Montserrat',
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight:
                            FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

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
                  Expanded(
                    child: Column(
                      children: [
                        sideKey("⌫", backspace),
                        sideKey("AC", clear),
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