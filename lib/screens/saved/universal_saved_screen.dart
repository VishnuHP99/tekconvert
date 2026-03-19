import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/common/app_top_bar.dart';
import '../converter/universal_converter_screen.dart';


class UniversalSavedScreen extends StatefulWidget {
  const UniversalSavedScreen({super.key});

  @override
  State<UniversalSavedScreen> createState() =>
      _UniversalSavedScreenState();
}

class _UniversalSavedScreenState
    extends State<UniversalSavedScreen> {

  List<String> savedList = [];

  @override
  void initState() {
    super.initState();
    loadSaved();
  }

  // ================= LOAD =================
  Future<void> loadSaved() async {
    final prefs = await SharedPreferences.getInstance();
    savedList = prefs.getStringList("universal_saved") ?? [];
    setState(() {});
  }

  // ================= SAVE =================
  Future<void> persist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("universal_saved", savedList);
  }

  String prettyTitle(String key) {
    return key
        .split("_")
        .map((w) => w[0].toUpperCase() + w.substring(1))
        .join(" ");
  }


  void openSavedItem(String row) async {

    final parts = row.split("||");
    if (parts.length != 2) return;

    final categoryKey = parts[0];
    final expression = parts[1];

    final eqParts = expression.split("=");
    if (eqParts.length != 2) return;

    final left = eqParts[0].trim();
    final right = eqParts[1].trim();

    final leftParts = left.split(" ");
    final rightParts = right.split(" ");

    final value = leftParts[0];
    final fromUnit = leftParts[1];
    final toUnit = rightParts[1];


    Navigator.pop(context, {
      "categoryKey": categoryKey,
      "value": value,
      "fromUnit": fromUnit,
      "toUnit": toUnit,
      "result": expression,
    });

// ✅ ALWAYS refresh after coming back
    loadSaved();
  }




  // ================= OPTIONS =================
  void showOptions(String row, int index) {
    HapticFeedback.mediumImpact();

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius:
        BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              ListTile(
                leading: const Icon(Icons.copy),
                title: const Text("Copy"),
                onTap: () {
                  Clipboard.setData(
                    ClipboardData(text: row.split("||").last),
                  );

                  Navigator.pop(context);
                },
              ),

              ListTile(
                leading: const Icon(Icons.delete,
                    color: Colors.red),
                title: const Text(
                  "Delete",
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () async {
                  Navigator.pop(context);
                  setState(() => savedList.removeAt(index));
                  await persist();
                },
              ),

              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardBg = isDark
        ? const Color(0xFF1C1C1E)
        : const Color(0xFFF2F2F2);

    final textSecondary = isDark
        ? Colors.grey.shade400
        : Colors.grey;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: Column(
        children: [

          AppTopBar(
            currentIndex: -1,
            title: "Saved",
            onBack: () => Navigator.pop(context),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6, bottom: 6),
            child: Text(
              "Tip: Long-press an item to Copy or Delete",
              style: TextStyle(
                fontSize: 12,
                color: textSecondary,
              ),
            ),
          ),


          Expanded(
            child: savedList.isEmpty
                ? Center(
              child: Text(
                "No Saved Items",
                style: TextStyle(
                  fontSize: 16,
                  color: textSecondary,
                ),
              ),
            )
                : ListView.builder(
              padding:
              const EdgeInsets.fromLTRB(
                  16, 16, 16, 10),
              itemCount: savedList.length,
              itemBuilder: (context, i) {
                final raw = savedList[i];
                final row = raw.split("||").last;


                return Padding(
                  padding:
                  const EdgeInsets.only(bottom: 12),
                  child: Material(
                    color: cardBg,
                    borderRadius:
                    BorderRadius.circular(14),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () => openSavedItem(raw),
                      onLongPress: () => showOptions(raw, i),



                      child: Padding(
                        padding:
                        const EdgeInsets.all(14),
                        child: Text(
                          row,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          if (savedList.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 75),
              child: TextButton(
                onPressed: () async {
                  setState(() => savedList.clear());
                  await persist();
                },
                child: Text(
                  "Clear All",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
