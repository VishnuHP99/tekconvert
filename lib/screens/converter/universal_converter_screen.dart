import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../core/utils/ui_sound.dart';
import '../../widgets/common/app_top_bar.dart';

import '../../data/unit_definitions.dart';
import '../../core/utils/converter_engine.dart';

import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/utils/app_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UniversalConverterScreen extends StatefulWidget {
  final String title;
  final String categoryKey;
  final String? initialFromUnit;
  final String? initialResult;
  final String? initialValue;
  final String? initialToUnit;


  const UniversalConverterScreen({
    super.key,
    required this.title,
    required this.categoryKey,
    this.initialFromUnit,
    this.initialToUnit,
    this.initialValue,
    this.initialResult,



  });


  @override
  State<UniversalConverterScreen> createState() =>
      _UniversalConverterScreenState();
}

class _UniversalConverterScreenState
    extends State<UniversalConverterScreen>
{

  final TextEditingController inputController = TextEditingController();

  String fromUnit = "";
  String toUnit = "";
  String result = "";
  bool showCopiedLabel = false;
  bool showSharedLabel = false;
  bool convertPressed = false;
  bool resultFlash = false;
  bool resultScale = false;
  List<String> localHistory = [];
  bool isSaved = false;



  late List<Map<String, dynamic>> units;

  late FixedExtentScrollController fromController;
  late FixedExtentScrollController toController;

  bool swapAnim = false;

  // ================= COLORS =================
  bool get isDark => Theme.of(context).brightness == Brightness.dark;

  Color get cardBg =>
      isDark ? const Color(0xFF1C1C1E) : const Color(0xA6F6F9FA);

  Color get stroke =>
      isDark ? const Color(0xFF2C2C2E) : const Color(0xFFC7C2C2);

  Color get pickerBg =>
      isDark ? const Color(0xFF2C2C2E) : Colors.white;

  Color get numBg =>
      isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF0F1F5);

  Color get acBg =>
      isDark ? const Color(0xFF4A2C2C) : const Color(0xFFFFDADA);

  Color get toolBg =>
      isDark ? const Color(0xFF1C1C1E) : const Color(0xFFEAF9FE);

  // ================= INIT =================
  @override
  void initState() {
    super.initState();

    units = unitDefinitions[widget.categoryKey] ?? [];

    int fromIndex = 0;
    int toIndex = 0;

    String? startFrom = widget.initialFromUnit;
    String? startTo = widget.initialToUnit;


    // Extract TO unit from result:
    // Example: "12 kg = 26.45 lb"
    // if (widget.initialResult != null) {
    //   final parts = widget.initialResult!.split("=");
    //   if (parts.length == 2) {
    //     final right = parts[1].trim();      // 26.45 lb
    //     final rightParts = right.split(" ");
    //     if (rightParts.length >= 2) {
    //       startTo = rightParts[1];
    //     }
    //   }
    // }

    if (units.isNotEmpty) {
      if (startFrom != null) {
        final i = units.indexWhere((u) => u["s"] == startFrom);
        if (i != -1) fromIndex = i;
      }

      if (startTo != null) {
        final j = units.indexWhere((u) => u["s"] == startTo);
        if (j != -1) toIndex = j;
      } else {
        toIndex = fromIndex == 0 ? 1 : 0;
      }

      fromUnit = units[fromIndex]["s"]!;
      toUnit = units[toIndex]["s"]!;
    }

    fromController = FixedExtentScrollController(initialItem: fromIndex);
    toController = FixedExtentScrollController(initialItem: toIndex);

    if (widget.initialValue != null) {
      inputController.text = widget.initialValue!;
    }

    if (widget.initialResult != null) {
      result = widget.initialResult!;
    }

    loadHistory();
    // 🔥 Auto run convert when coming from Saved screen
    if (widget.initialValue != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        convert();
      });
    }

  }


  @override
  void dispose() {
    fromController.dispose();
    toController.dispose();
    inputController.dispose();
    super.dispose();
  }
  Future<void> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> list =
        prefs.getStringList("conv_history_${widget.categoryKey}") ?? [];

    if (list.length > 5) {
      list = list.sublist(0, 5);
    }

    setState(() {
      localHistory = list;
    });
  }



  // ================= UI =================
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [

            AppTopBar(
              currentIndex: -1,
              title: widget.title,
              onBack: () => Navigator.pop(context),

              // ✅ ADD THIS
              onSettingsChanged: () {
                if (result.isNotEmpty) {
                  isSaved = false;
                  convert();   // reformat result
                }
              },
            ),


            // ================= CARD =================
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: stroke),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x14000000),
                      blurRadius: 14,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [

                    // INPUT
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x08000000),
                            blurRadius: 6,
                          )
                        ],
                      ),
                      child: TextField(
                        controller: inputController,
                        readOnly: true,
                        showCursor: true,
                        keyboardType: TextInputType.none,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          hintText: "Enter Value",
                          filled: true,
                          fillColor: pickerBg,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // LABELS
                    Row(
                      children: [
                        Expanded(child: Center(child: labelWithDots("From"))),
                        const SizedBox(width: 44),
                        Expanded(child: Center(child: labelWithDots("To"))),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // PICKERS + SWAP
                    Row(
                      children: [

                        Expanded(child: inlinePicker(true)),
                        const SizedBox(width: 10),

                        GestureDetector(
                          onTap: () {
                            UISound.tap();   // 🔊 UI tap sound
                            swapUnits();
                          },

                          child: AnimatedRotation(
                            turns: swapAnim ? 0.5 : 0,
                            duration: const Duration(milliseconds: 300),
                            child: Icon(
                              Icons.swap_horiz,
                              size: 28,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),

                        const SizedBox(width: 6),
                        Expanded(child: inlinePicker(false)),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // RESULT
                    AnimatedScale(
                      scale: resultScale ? 1.04 : 1.0,
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOut,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 320),
                        height: 52,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: pickerBg,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: resultFlash
                                ? Theme.of(context).colorScheme.primary
                                : stroke,
                            width: resultFlash ? 2 : 1,
                          ),
                          boxShadow: resultFlash
                              ? [
                            BoxShadow(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withValues(alpha: 0.25),
                              blurRadius: 14,
                              spreadRadius: 1,
                            )
                          ]
                              : const [
                            BoxShadow(
                              color: Color(0x08000000),
                              blurRadius: 6,
                            )
                          ],
                        ),
                        child: Text(
                          result.isEmpty
                              ? "Result will appear here"
                              : result,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight:
                            result.isEmpty ? FontWeight.w400 : FontWeight.w700,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // CONVERT BUTTON
                    GestureDetector(
                      onTapDown: (_) {
                        UISound.tap();
                        setState(() => convertPressed = true);
                      },
                      onTapUp: (_) {
                        UISound.tap();
                        HapticFeedback.lightImpact();
                        setState(() => convertPressed = false);
                        convert();   // 👈 ADD THIS LINE
                      },

                      onTapCancel: () {
                        UISound.tap();
                        setState(() => convertPressed = false);
                      },
                      child: AnimatedScale(
                        scale: convertPressed ? 0.95 : 1.0,
                        duration: const Duration(milliseconds: 90),
                        child: AnimatedOpacity(
                          opacity: convertPressed ? 0.85 : 1,
                          duration: const Duration(milliseconds: 90),
                          child: Container(
                            height: 36,
                            width: 130,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x33000000),
                                  blurRadius: 8,
                                  offset: Offset(0,4),
                                )
                              ],
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              "Convert",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),

            // ================= TOOL BAR =================
            // ================= TOOL BAR =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [

                  toolButton(
                    icon: Icons.copy,
                    label: showCopiedLabel ? "Copied" : "Copy",
                    active: showCopiedLabel,
                    activeColor: Colors.green,
                    onTap: () {
                      UISound.tap();
                      onCopy();
                    },
                  ),

                  toolButton(
                    icon: Icons.share,
                    label: showSharedLabel ? "Shared" : "Share",
                    active: showSharedLabel,
                    activeColor: Colors.blue,
                    onTap: () {
                      UISound.tap();
                      onShare();
                    },
                  ),

                  toolButton(
                    icon: Icons.history,
                    label: "History",
                    onTap: () {
                      UISound.tap();
                      showHistoryPopup();
                    },
                  ),

                  toolButton(
                    icon: isSaved ? Icons.bookmark : Icons.bookmark_border,
                    label: isSaved ? "Saved" : "Save",
                    active: isSaved,
                    activeColor: Colors.orange,
                    onTap: () {
                      UISound.tap();
                      saveResult();
                    },
                    onLongPress: isSaved ? unsaveResult : null,


                  ),


                ],
              ),
            ),


            const SizedBox(height: 10),

            // ================= KEYPAD =================
            Flexible(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                child: Row(
                  children: [

                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Expanded(child: numberRow(["7", "8", "9"])),
                          Expanded(child: numberRow(["4", "5", "6"])),
                          Expanded(child: numberRow(["1", "2", "3"])),
                          Expanded(child: numberRow(["+/-", "0", "."])),
                        ],
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: Column(
                        children: [
                          Expanded(child: tallKey("⌫")),
                          const SizedBox(height: 10),
                          Expanded(child: tallKey("AC")),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= PICKERS =================

  Widget inlinePicker(bool isFrom) {
    return SizedBox(
      height: 90,
      child: CupertinoPicker(
        scrollController: isFrom ? fromController : toController,
        itemExtent: 40,
        useMagnifier: true,
        magnification: 1.08,
        onSelectedItemChanged: (index) {
          UISound.wheel(); // 🔊 picker scroll sound
          setState(() {
            isSaved = false;
            if (isFrom) {
              fromUnit = units[index]["s"]!;
            } else {
              toUnit = units[index]["s"]!;
            }
          });

        },
        children: units.map((u) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(u["s"]!,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
              Text(
                u["f"]!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  // ================= KEYPAD LOGIC =================

  Widget numberRow(List<String> items) {
    return Row(
      children: items.map((e) => numberKey(e)).toList(),
    );
  }

  Widget numberKey(String text) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onKeyTap(text),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            decoration: BoxDecoration(
              color: numBg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget tallKey(String text) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onKeyTap(text),
        child: Container(
          decoration: BoxDecoration(
            color: acBg,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ================= LOGIC UNCHANGED =================

  void onKeyTap(String k) {
    UISound.keyboard(); // 🔊 keypad sound
    setState(() {

      // ✅ IMPORTANT: reset saved state on ANY edit
      isSaved = false;

      if (k == "AC") {
        inputController.clear();
        result = "";
        return;
      }

      if (k == "⌫") {
        if (inputController.text.isNotEmpty) {
          inputController.text =
              inputController.text.substring(
                  0, inputController.text.length - 1);
        }
        return;
      }

      if (k == "+/-") {
        if (inputController.text.startsWith("-")) {
          inputController.text =
              inputController.text.substring(1);
        } else {
          inputController.text = "-${inputController.text}";
        }
        return;
      }

      if (k == "." &&
          inputController.text.contains(".")) return;

      inputController.text += k;
    });
  }


  Future<void> checkIfSaved(String row) async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList("universal_saved") ?? [];

    final exists = saved.any((e) => e.endsWith(row));

    if (mounted) {
      setState(() {
        isSaved = exists;
      });
    }
  }

  Future<void> convert() async {

    if (inputController.text.isEmpty) {
      showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) => CupertinoAlertDialog(
          title: const Text("No Value"),
          content: const Text("Please enter a value to convert"),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text("OK"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
      return;
    }

    final value = double.tryParse(inputController.text);
    if (value == null) return;

    final converted = convertValue(
      category: widget.categoryKey,
      value: value,
      fromUnit: fromUnit,
      toUnit: toUnit,
    );

    final newResult =
        "${inputController.text} $fromUnit = "
        "${AppSettings.format(converted)} $toUnit";

    setState(() {
      result = newResult;
      resultFlash = true;
      resultScale = true;
    });

    Future.delayed(const Duration(milliseconds: 220), () {
      if (!mounted) return;
      setState(() {
        resultScale = false;
      });
    });

    Future.delayed(const Duration(milliseconds: 420), () {
      if (!mounted) return;
      setState(() {
        resultFlash = false;
      });
    });

    await checkIfSaved(newResult);



    await saveToHistory(result);



  }

  Future<void> saveToHistory(String row) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> list =
        prefs.getStringList("conv_history_${widget.categoryKey}") ?? [];

    // remove duplicate
    list.remove(row);

    // insert newest on top
    list.insert(0, row);

    // keep only latest 5
    if (list.length > 5) {
      list = list.sublist(0, 5);
    }

    await prefs.setStringList(
        "conv_history_${widget.categoryKey}", list);

    setState(() {
      localHistory = list;
    });
  }



  void swapUnits() {
    setState(() {
      isSaved = false;
      swapAnim = !swapAnim;

      final temp = fromUnit;
      fromUnit = toUnit;
      toUnit = temp;

      final fromIndex =
      units.indexWhere((e) => e["s"] == fromUnit);
      final toIndex =
      units.indexWhere((e) => e["s"] == toUnit);

      if (fromIndex != -1) {
        fromController.jumpToItem(fromIndex);
      }

      if (toIndex != -1) {
        toController.jumpToItem(toIndex);
      }
    });
  }

  Widget labelWithDots(String text) {
    return GestureDetector(
      onTap: () => showUnitSheet(text == "From"),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text,
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w700,
              )),
          const SizedBox(width: 4),
          const Icon(Icons.more_vert, size: 16),
        ],
      ),
    );
  }

  void showUnitSheet(bool isFrom) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => CupertinoActionSheet(
        title: const Text("Select Unit"),
        actions: units.map((u) {
          return CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                if (isFrom) {
                  fromUnit = u["s"]!;
                  fromController.jumpToItem(units.indexOf(u));
                } else {
                  toUnit = u["s"]!;
                  toController.jumpToItem(units.indexOf(u));
                }
              });
            },
            child: Text("${u["s"]} - ${u["f"]}"),
          );
        }).toList(),
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
      ),
    );
  }

  void onCopy() async {
    if (result.isEmpty) {
      showEmptyAction("Nothing to copy");
      return;
    }

    Clipboard.setData(ClipboardData(text: result));
    setState(() => showCopiedLabel = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => showCopiedLabel = false);
  }

  void onShare() async {
    if (result.isEmpty) {
      showEmptyAction("Nothing to share");
      return;
    }

    setState(() => showSharedLabel = true);
    Share.share(result);
    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) setState(() => showSharedLabel = false);
  }

  Future<void> saveResult() async {
    if (result.isEmpty) {
      showEmptyAction("Nothing to save");
      return;
    }


    final prefs = await SharedPreferences.getInstance();
    List<String> saved =
        prefs.getStringList("universal_saved") ?? [];

    if (saved.any((e) => e.endsWith(result))) {

      showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: const Text("Already Saved"),
          content:
          const Text("Overwrite existing saved item?"),
          actions: [

            CupertinoDialogAction(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),

            CupertinoDialogAction(
              isDestructiveAction: true,
              child: const Text("Overwrite"),
              onPressed: () async {
                Navigator.pop(context);

                // ✅ Remove any previous occurrence of this result
                saved.removeWhere((e) => e.endsWith(result));

                // ✅ Insert fresh copy at top
                final tagged = "${widget.categoryKey}||$result";
                saved.insert(0, tagged);

                await prefs.setStringList("universal_saved", saved);

                setState(() => isSaved = true);
              },
            ),


          ],
        ),
      );
      return;
    }

    final tagged = "${widget.categoryKey}||$result";
    saved.insert(0, tagged);
    await prefs.setStringList("universal_saved", saved);
    setState(() => isSaved = true);



    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Saved"),
        duration: Duration(milliseconds: 800),
      ),
    );
  }

  Future<void> unsaveResult() async {
    if (result.isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    List<String> saved =
        prefs.getStringList("universal_saved") ?? [];

    saved.removeWhere((e) => e.endsWith(result));

    await prefs.setStringList("universal_saved", saved);

    setState(() => isSaved = false);

    HapticFeedback.mediumImpact();

    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => const CupertinoAlertDialog(
        content: Text("Removed from Saved"),
      ),
    );

    Future.delayed(const Duration(milliseconds: 900), () {
      if (mounted) Navigator.pop(context);
    });
  }


  void showHistoryPopup() {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => CupertinoActionSheet(
        title: const Text("History"),

        actions: localHistory.isEmpty
            ? [
          CupertinoActionSheetAction(
            onPressed: () {},
            child: const Text("No History"),
          )

        ]
            : [

          // LIST
          SizedBox(
            height: 250,
            child: ListView.builder(
              itemCount: localHistory.length,
              itemBuilder: (context, i) {
                final row = localHistory[i];

                return CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(context);
                    restoreFromHistory(row);
                  },
                  child: Text(row),
                );
              },
            ),
          ),

          // CLEAR ALL
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () async {
              final prefs =
              await SharedPreferences.getInstance();

              await prefs.remove(
                  "conv_history_${widget.categoryKey}");

              setState(() => localHistory.clear());
              Navigator.pop(context);
            },
            child: const Text("Clear All"),
          ),
        ],

        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
      ),
    );
  }

  Future<void> restoreFromHistory(String row) async {

    // Example:
    // 12 m = 39.37 ft

    final parts = row.split("=");

    if (parts.length != 2) return;

    // LEFT SIDE
    final left = parts[0].trim();      // 12 m
    final leftParts = left.split(" ");
    if (leftParts.length < 2) return;

    final value = leftParts[0];
    final from = leftParts[1];

    // RIGHT SIDE
    final right = parts[1].trim();     // 39.37 ft
    final rightParts = right.split(" ");
    if (rightParts.length < 2) return;

    final to = rightParts[1];

    setState(() {

      inputController.text = value;
      fromUnit = from;
      toUnit = to;
      result = row;
    });

    // Sync pickers
    final fromIndex =
    units.indexWhere((e) => e["s"] == from);
    final toIndex =
    units.indexWhere((e) => e["s"] == to);

    if (fromIndex != -1) {
      fromController.jumpToItem(fromIndex);
    }

    if (toIndex != -1) {
      toController.jumpToItem(toIndex);
    }
    await checkIfSaved(row);

  }

  Widget toolIcon(IconData icon) =>
      Expanded(child: Center(child: Icon(icon)));

  Widget vDivider() =>
      Container(width: 1, color: Colors.grey.shade300);

  Widget toolButton({
    required IconData icon,
    required String label,
    bool active = false,
    Color activeColor = Colors.blue,
    required VoidCallback onTap,
    VoidCallback? onLongPress,
  }) {
    return Expanded(
      child: _BouncyButton(
        glowColor: active ? activeColor : null,
        onTap: onTap,
        onLongPress: onLongPress,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Tooltip(
              message: active ? "Hold to remove" : "Tap to save",
              child: Icon(
                icon,
                size: 22,
                color: active
                    ? activeColor
                    : Theme.of(context).colorScheme.onSurface,
              ),
            ),

            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: active
                    ? activeColor
                    : Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showEmptyAction(String message) {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text("Nothing Here"),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text("OK"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }


}

class _BouncyButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final Color? glowColor;

  const _BouncyButton({
    required this.child,
    required this.onTap,
    this.glowColor,
    this.onLongPress,
  });

  @override
  State<_BouncyButton> createState() => _BouncyButtonState();
}

class _BouncyButtonState extends State<_BouncyButton> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;



    final toolBg = isDark
        ? const Color(0xFF1C1C1E)
        : const Color(0xFFEAF9FE);
    return GestureDetector(
      onLongPress: widget.onLongPress,
      onTapDown: (_) => setState(() => pressed = true),
      onTapCancel: () => setState(() => pressed = false),
      onTapUp: (_) {
        setState(() => pressed = false);
        HapticFeedback.lightImpact();   // ✅ subtle haptic
        widget.onTap();
      },
      child: AnimatedScale(
        scale: pressed ? 0.92 : 1.0,
        duration: const Duration(milliseconds: 140),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOutCubic,
          height: 56,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: toolBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFD6D6D6),
            ),

            // ✅ PERFECT SOFT GLOW
            boxShadow: widget.glowColor != null
                ? [
              BoxShadow(
                color: widget.glowColor!.withValues(alpha: 0.45),
                blurRadius: 14,
                spreadRadius: 1,
              )
            ]
                : [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 6,
              )
            ],
          ),
          child: AnimatedOpacity(
            opacity: pressed ? 0.75 : 1,
            duration: const Duration(milliseconds: 120),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}


