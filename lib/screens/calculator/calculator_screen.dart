import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'history_screen.dart';
import '../../core/utils/app_settings.dart';
import '../../core/utils/ui_sound.dart';


class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {


  String rawExpression = "";
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();


  String previewResult = "";
  List<String> history = [];



  // ================= INIT =================
  @override
  void initState() {
    super.initState();
    loadHistory();
    loadDecimalSetting();

    WidgetsBinding.instance.addObserver(
      _LifecycleObserver(loadDecimalSetting),
    );

    _controller.selection =
    const TextSelection.collapsed(offset: 0);
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.microtask(loadDecimalSetting);
    // refresh when returning from Settings
  }

  // ================= STORAGE =================
  Future<void> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    history = prefs.getStringList("calc_history") ?? [];
    setState(() {});
  }

  Future<void> saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("calc_history", history);
  }

  Future<void> loadDecimalSetting() async {

    // 🔁 Recalculate preview if expression exists
    if (_controller.text.isNotEmpty && _hasOperator(_controller.text)) {
      updatePreview();
    }

    // 🔁 Reformat final value if it's a number
    else {
      final v = double.tryParse(_controller.text);
      if (v != null) {
        _controller.text = AppSettings.format(v);

        _controller.selection =
            TextSelection.collapsed(offset: _controller.text.length);
      }
    }

    setState(() {});
  }



  // ================= HELPERS =================
  bool _hasOperator(String s) {
    return s.contains('+') ||
        s.contains('-') ||
        s.contains('x') ||
        s.contains('/') ||
        s.contains('%');
  }

  bool isOperator(String s) {
    return ["+", "-", "x", "/", "%"].contains(s);
  }

  bool isDigit(String s) {
    return RegExp(r'^[0-9]$').hasMatch(s);
  }


  // ================= INSERT AT CURSOR =================
  void insertText(String text) {
    final value = rawExpression;

    rawExpression = value + text;

    _controller.text = formatExpression(rawExpression);
    _controller.selection =
        TextSelection.collapsed(offset: _controller.text.length);

    updatePreview(); // ✅ ALWAYS call
  }
  // ================= BUTTON TAP =================
  void onTap(String v) {

    // 🔊 keypad sound
    UISound.keyboard();


    // ---------- CLEAR ----------
    if (v == "AC") {
      rawExpression = "";   // 🔥 IMPORTANT
      _controller.clear();
      previewResult = "";
      setState(() {});
      return;
    }

    // ---------- BACKSPACE ----------
    if (v == "⌫") {
      if (rawExpression.isNotEmpty) {
        rawExpression =
            rawExpression.substring(0, rawExpression.length - 1);

        _controller.text = formatExpression(rawExpression);
        _controller.selection =
            TextSelection.collapsed(offset: _controller.text.length);
      }

      updatePreview();
      return;
    }

    // ---------- BRACKETS ----------
    if (v == "()") {
      final text = _controller.text;
      int open = "(".allMatches(text).length;
      int close = ")".allMatches(text).length;

      String insert = (open == close || text.endsWith("("))
          ? "("
          : ")";

      handleSmartInsert(insert);
      return;
    }

    // ---------- EQUAL ----------
    if (v == "=") {
      calculate();
      return;
    }

    // ---------- NORMAL ----------
    handleSmartInsert(v);
  }

  void handleSmartInsert(String v) {

    final text = rawExpression;

    if (text.isEmpty) {
      if (isOperator(v)) return;   // block starting with operator
      insertText(v);
      return;
    }

    String last = text[text.length - 1];

    // ---------- Prevent operator spam ----------
    if (isOperator(last) && isOperator(v)) {
      rawExpression =
          text.substring(0, text.length - 1) + v;

      _controller.text = formatExpression(rawExpression);
      _controller.selection =
          TextSelection.collapsed(offset: _controller.text.length);

      updatePreview();
      return;
    }

    // ---------- Implicit multiplication ----------
    if (
    (isDigit(last) && v == "(") ||
        (last == ")" && v == "(") ||
        (last == ")" && isDigit(v))
    ) {
      insertText("x$v");
      return;
    }
    // ---------- Decimal after bracket ----------
// ) . → )x0.
    if (last == ")" && v == ".") {
      insertText("x0.");
      return;
    }

    insertText(v);
  }



  // ================= CALCULATE =================
  void calculate() {
    final text = rawExpression;

    if (text.isEmpty || !_hasOperator(text)) return;

    String last = text[text.length - 1];
    if (isOperator(last)) return;

    try {
      // 🔥 remove commas before parsing
      String exp = text.replaceAll(",", "").replaceAll("x", "*");

      Parser p = Parser();
      Expression ex = p.parse(exp);

      double res =
      ex.evaluate(EvaluationType.REAL, ContextModel());

      // ✅ format result WITH commas
      String formatted = AppSettings.format(res);

      history.insert(0, "$text = $formatted");
      if (history.length > 5) history.removeLast();
      saveHistory();

      _controller.text = formatted;
      _controller.selection =
          TextSelection.collapsed(offset: formatted.length);

      previewResult = "";
      setState(() {});
      rawExpression = res.toString();  // 🔥 CRITICAL
    } catch (_) {
      _controller.text = "Error";
      previewResult = "";
      setState(() {});

    }

  }



  // ================= PREVIEW =================
  void updatePreview() {
    try {
      final text = rawExpression;

      if (text.isEmpty || !_hasOperator(text)) {
        previewResult = "";
        setState(() {});
        return;
      }

      String last = text[text.length - 1];
      if (isOperator(last)) {
        return; // ❌ don’t clear, just skip calculation
      }

      String exp = text.replaceAll(",", "").replaceAll("x", "*");
      Parser p = Parser();
      Expression ex = p.parse(exp);

      double res =
      ex.evaluate(EvaluationType.REAL, ContextModel());

      previewResult = AppSettings.format(res);


      setState(() {});
    } catch (_) {
      previewResult = "";
    }
  }



  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;



    final displayBg = isDark ? const Color(0xFF1C1C1E) : const Color(0xFFF6F9FA);
    final borderColor = isDark ? const Color(0xFF2C2C2E) : const Color(0xFFC7C2C2);

    final textPrimary = Theme.of(context).colorScheme.onSurface;
    final textSecondary = isDark ? const Color(0xFF9A9A9A) : const Color(0xFF929292);

    return Column(
      children: [

        // ================= DISPLAY =================
        Container(
          margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          padding: const EdgeInsets.all(14),
          height: 185,
          decoration: BoxDecoration(
            color: displayBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [

              EditableText(
                controller: _controller,
                focusNode: _focusNode,
                readOnly: true,
                textAlign: TextAlign.right,
                showCursor: true,
                cursorColor: Colors.blue,
                backgroundCursorColor: Colors.grey,
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  color: textPrimary,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                previewResult,
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: textSecondary,
                ),
              ),

              const Spacer(),

              Align(
                alignment: Alignment.bottomLeft,
                child: InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () async {
                    UISound.tap();   // 🔊 UI tap sound
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            HistoryScreen(history: history),
                      ),
                    );

                    if (result is String) {
                      _controller.text = result;
                      _controller.selection =
                          TextSelection.collapsed(
                              offset: result.length);
                      previewResult = "";
                      setState(() {});
                    }

                    if (result is List<String>) {
                      history = result;
                      saveHistory();
                      setState(() {});
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF2C2C2E)
                          : const Color(0xFFEDEDED),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.history, size: 14),
                        SizedBox(width: 6),
                        Text(
                          "History",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),

        // ================= KEYPAD =================
        Expanded(
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Column(
                children: [
                  row(["AC", "()", "%", "/"]),
                  row(["7", "8", "9", "x"]),
                  row(["4", "5", "6", "-"]),
                  row(["1", "2", "3", "+"]),
                  row([".", "0", "⌫", "="]),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ================= ROW =================
  Widget row(List<String> items) {
    return Expanded(
      child: Row(
        children: items.map((e) => button(e)).toList(),
      ),
    );
  }

  // ================= BUTTON =================
  Widget button(String text) {

    final isDark = Theme.of(context).brightness == Brightness.dark;

    final numBg = isDark ? const Color(0xFF2C2C2E) : const Color(0xFFE8EBF0);
    final opBg  = isDark ? const Color(0xFF1F3B5B) : const Color(0xFFD7ECFF);
    final acBg  = isDark ? const Color(0xFF4A2C2C) : const Color(0xFFFFEBEB);

    bool isOperator = ["%", "/", "x", "-", "+", "="].contains(text);
    bool isAC = text == "AC";
    bool isDelete = text == "⌫";

    Color bg = numBg;
    Color txt = Theme.of(context).colorScheme.onSurface;

    if (isOperator) bg = opBg;
    if (isAC || isDelete) {
      bg = acBg;
      txt = Colors.red;
    }

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => onTap(text),
          child: Container(
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 39,
                  fontWeight: FontWeight.w600,
                  color: txt,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}
class _LifecycleObserver extends WidgetsBindingObserver {
  final VoidCallback onResume;

  _LifecycleObserver(this.onResume);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      onResume();
    }
  }
}
String formatExpression(String input) {
  return input.replaceAllMapped(
    RegExp(r'\d+\.?\d*'),
        (match) {
      final numStr = match.group(0)!;

      if (numStr.endsWith(".")) return numStr;

      final numVal = double.tryParse(numStr);
      if (numVal == null) return numStr;

      return AppSettings.format(numVal);
    },
  );
}
