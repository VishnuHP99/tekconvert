import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/utils/ui_sound.dart';
import '../../widgets/common/app_top_bar.dart';

class HistoryScreen extends StatefulWidget {
  final List<String> history;

  const HistoryScreen({super.key, required this.history});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  late List<String> historyList;

  @override
  void initState() {
    super.initState();
    historyList = List.from(widget.history);
  }

  // ================= SAVE =================
  Future<void> saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("calc_history", historyList);
  }

  // ================= TOAST =================
  void showToast(String msg) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: const Duration(milliseconds: 900),
      ),
    );
  }

  // ================= LONG PRESS MENU =================
  void showOptions(String row, int index) {
    HapticFeedback.mediumImpact();

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              const SizedBox(height: 12),

              ListTile(
                leading: const Icon(Icons.copy),
                title: const Text("Copy"),
                onTap: () {
                  UISound.tap();   // 🔊 UI tap sound
                  Clipboard.setData(ClipboardData(text: row));
                  Navigator.pop(context);
                  showToast("Copied");
                },
              ),

              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text(
                  "Delete",
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () async {
                  UISound.tap();   // 🔊 UI tap sound
                  Navigator.pop(context);
                  setState(() => historyList.removeAt(index));
                  await saveHistory();
                  showToast("Deleted");
                },
              ),

              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: Column(
        children: [

          // TOP BAR
          // TOP BAR
          AppTopBar(
            currentIndex: -1,
            title: "History",
            onBack: () {
              Navigator.pop(context, historyList);
            },
          ),

          Padding(
            padding: const EdgeInsets.only(top: 6, bottom: 6),
            child: Text(
              "Tip: Long-press an item to Copy or Delete",
              style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ),


          // LIST
          Expanded(
            child: historyList.isEmpty
                ? Center(
              child: Text(
                "No History",
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
              itemCount: historyList.length,
              itemBuilder: (context, index) {
                final row = historyList[index];
                final parts = row.split("=");
                final exp = parts[0].trim();
                final res =
                parts.length > 1 ? parts[1].trim() : "";

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Material(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF1C1C1E)
                        : const Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(14),

                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),

                      splashColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.15),
                      highlightColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.08),

                      onTap: () {
                        UISound.tap();   // 🔊 UI tap sound
                        Navigator.pop(context, exp);
                      },

                      onLongPress: () {
                        showOptions(row, index);
                      },

                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.end,
                          children: [

                            Text(
                              exp,
                              style: const TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF06034E),
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              res,
                              style: const TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // CLEAR ALL (RAISED A BIT)
          if (historyList.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 75),
              child: TextButton(
                onPressed: () async {
                  setState(() => historyList.clear());
                  await saveHistory();
                  showToast("History cleared");
                },
                child: const Text(
                  "Clear All",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
