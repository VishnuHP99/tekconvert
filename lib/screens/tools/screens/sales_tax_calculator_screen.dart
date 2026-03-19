import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/widgets/common/app_top_bar.dart';
import '../models/tool_result.dart';

class SalesTaxCalculatorScreen extends StatefulWidget {
  const SalesTaxCalculatorScreen({super.key});

  @override
  State<SalesTaxCalculatorScreen> createState() =>
      _SalesTaxCalculatorScreenState();
}

class _SalesTaxCalculatorScreenState
    extends State<SalesTaxCalculatorScreen>
    with TickerProviderStateMixin {
  static const primary = Color(0xFF0F0F5F);

  final amountCtrl = TextEditingController();
  final taxCtrl = TextEditingController();

  int activeIndex = 0;

  /// true = add tax
  bool addTax = true;

  @override
  void dispose() {
    amountCtrl.dispose();
    taxCtrl.dispose();
    super.dispose();
  }

  TextEditingController get activeController =>
      activeIndex == 0 ? amountCtrl : taxCtrl;

  void setActive(int i) => setState(() => activeIndex = i);

  void add(String v) {
    setState(() => activeController.text += v);
  }

  void backspace() {
    if (activeController.text.isEmpty) return;

    setState(() {
      activeController.text = activeController.text.substring(
        0,
        activeController.text.length - 1,
      );
    });
  }

  void clear() => setState(() => activeController.clear());

  void toggleSign() {
    if (activeController.text.isEmpty) return;

    if (activeController.text.startsWith("-")) {
      activeController.text =
          activeController.text.substring(1);
    } else {
      activeController.text =
      "-${activeController.text}";
    }

    setState(() {});
  }

  void applyPreset(double percent) {
    setState(() {
      taxCtrl.text = percent.toString();
      activeIndex = 1;
    });
  }

  /// ================= CALCULATE =================

  void calculate() {
    if (amountCtrl.text.isEmpty ||
        taxCtrl.text.isEmpty) return;

    final amount = double.parse(amountCtrl.text);
    final percent = double.parse(taxCtrl.text);

    double tax;

    if (addTax) {
      tax = amount * percent / 100;
    } else {
      tax = amount - (amount / (1 + percent / 100));
    }

    final total = addTax ? amount + tax : amount - tax;

    final cgst = tax / 2;
    final sgst = tax / 2;

    showResult(
      ToolResult(
        mainValue: total,
        secondaryValue: tax,
        tertiaryValue: cgst,
        mainLabel:
        addTax ? "Total Amount" : "Amount Without Tax",
        secondaryLabel: "GST Amount",
        tertiaryLabel: "CGST",
      ),
      sgst,
    );
  }

  /// ================= RESULT =================

  Widget animatedNumber(double value, bool big) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutCubic,
      builder: (_, v, __) {
        return Text(
          v.toStringAsFixed(2),
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: big ? 38 : 26,
            fontWeight: FontWeight.w700,
            color: primary,
          ),
        );
      },
    );
  }

  void showResult(ToolResult r, double sgst) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        final bottom =
            MediaQuery.of(context).viewPadding.bottom;

        return Container(
          padding:
          EdgeInsets.fromLTRB(20, 18, 20, 28 + bottom),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(34),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 5,
                margin:
                const EdgeInsets.only(bottom: 22),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius:
                  BorderRadius.circular(10),
                ),
              ),

              _card(r.mainLabel, r.mainValue, true),

              const SizedBox(height: 14),

              _card(
                r.secondaryLabel!,
                r.secondaryValue!,
                false,
              ),

              const SizedBox(height: 14),

              _card("CGST", r.tertiaryValue!, false),

              const SizedBox(height: 14),

              _card("SGST", sgst, false),
            ],
          ),
        );
      },
    );
  }

  Widget _card(String label, double value, bool big) {
    return Container(
      width: double.infinity,
      padding:
      const EdgeInsets.symmetric(vertical: 26),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border:
        Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            blurRadius: 18,
            color:
            Colors.black.withOpacity(0.05),
            offset: const Offset(0, 8),
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
          const SizedBox(height: 8),
          animatedNumber(value, big),
        ],
      ),
    );
  }

  /// ================= INPUT =================

  Widget field(
      String label,
      TextEditingController ctrl,
      int index,
      ) {
    final active = activeIndex == index;
    final hasValue = ctrl.text.isNotEmpty;

    return GestureDetector(
      onTap: () => setActive(index),
      child: AnimatedContainer(
        duration:
        const Duration(milliseconds: 200),
        height: 74,
        margin:
        const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(
            horizontal: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(18),
          border: Border.all(
            color: active
                ? primary
                : Colors.grey.shade300,
            width: active ? 2 : 1,
          ),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration:
              const Duration(milliseconds: 200),
              top: (active || hasValue)
                  ? 8
                  : 26,
              child: AnimatedDefaultTextStyle(
                duration:
                const Duration(milliseconds: 200),
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize:
                  (active || hasValue)
                      ? 12
                      : 17,
                  fontWeight:
                  FontWeight.w600,
                  color:
                  (active || hasValue)
                      ? primary
                      : Colors.grey,
                ),
                child: Text(label),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding:
                const EdgeInsets.only(
                    bottom: 12),
                child: Text(
                  ctrl.text,
                  style:
                  const TextStyle(
                    fontFamily:
                    'Montserrat',
                    fontSize: 18,
                    fontWeight:
                    FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ================= RADIO =================

  Widget taxModeSelector() {
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.center,
      children: [
        Radio<bool>(
          value: true,
          groupValue: addTax,
          activeColor: primary,
          onChanged: (v) =>
              setState(() => addTax = true),
        ),
        const Text("Add Tax"),
        Radio<bool>(
          value: false,
          groupValue: addTax,
          activeColor: primary,
          onChanged: (v) =>
              setState(() => addTax = false),
        ),
        const Text("Remove Tax"),
      ],
    );
  }

  /// ================= KEYPAD =================

  Widget key(String t) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          HapticFeedback.selectionClick();

          if (t == "+/-") {
            toggleSign();
            return;
          }

          add(t);
        },
        child: Container(
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color:
            const Color(0xFFF1F3F6),
            borderRadius:
            BorderRadius.circular(18),
          ),
          child: Center(
            child: Text(
              t,
              style: const TextStyle(
                fontFamily:
                'Montserrat',
                fontSize: 26,
                fontWeight:
                FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget sideKey(
      IconData icon,
      VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin:
          const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color:
            const Color(0xFFFFDADA),
            borderRadius:
            BorderRadius.circular(18),
          ),
          child: Center(
            child: Icon(
              icon,
              size: 30,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  Widget row(List<String> keys) {
    return Expanded(
      child: Row(
        children:
        keys.map(key).toList(),
      ),
    );
  }

  Widget _preset(double p) {
    return GestureDetector(
      onTap: () => applyPreset(p),
      child: Container(
        padding:
        const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 8),
        decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(20),
          border:
          Border.all(color: primary),
        ),
        child: Text(
          "$p%",
          style: const TextStyle(
            fontFamily: 'Montserrat',
            fontWeight:
            FontWeight.w600,
            color: primary,
          ),
        ),
      ),
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
              title: "Sales Tax / GST",
              currentIndex: -1,
              onBack: () =>
                  Navigator.pop(context),
            ),

            Padding(
              padding:
              const EdgeInsets.all(16),
              child: Column(
                children: [
                  field(
                      "Amount",
                      amountCtrl,
                      0),
                  field(
                      "GST (%)",
                      taxCtrl,
                      1),

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                    children: [
                      _preset(5),
                      _preset(12),
                      _preset(18),
                      _preset(28),
                    ],
                  ),

                  const SizedBox(height: 10),

                  taxModeSelector(),

                  const SizedBox(height: 12),

                  ElevatedButton(
                    onPressed: calculate,
                    style:
                    ElevatedButton
                        .styleFrom(
                      backgroundColor:
                      primary,
                      shape:
                      const StadiumBorder(),
                      padding:
                      const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical:
                          16),
                    ),
                    child: const Text(
                      "Calculate",
                      style: TextStyle(
                        fontFamily:
                        'Montserrat',
                        color:
                        Colors.white,
                        fontWeight:
                        FontWeight
                            .w700,
                      ),
                    ),
                  ),
                ],
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
                        row(
                            ["+/-", "0", "."]),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        sideKey(
                            Icons.backspace,
                            backspace),
                        sideKey(
                            Icons.delete,
                            clear),
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
