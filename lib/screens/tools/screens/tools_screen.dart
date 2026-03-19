import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../tool_mapper.dart';
import 'universal_tool_calculator_screen.dart';   // adjust path if needed
import 'dart:math';
import '../models/tool_field.dart';
import '../models/tool_result.dart';


/// =======================================================
/// MODELS
/// =======================================================

class ToolSection {
  final String title;
  final List<ToolTile> tiles;
  ToolSection(this.title, this.tiles);
}

class ToolTile {
  final String title;
  final IconData icon;
  final Color color;
  ToolTile(this.title, this.icon, this.color);
}

/// =======================================================
/// DATA (FINAL OFFLINE FORMULA TOOLS ONLY)
/// =======================================================

final List<ToolSection> toolSections = [

  /// 💰 FINANCE TOOLS
  ToolSection("Finance Tools", [
    ToolTile("EMI Calculator", Icons.calculate, Colors.blue),
    ToolTile("Loan Calculator", Icons.request_quote, Colors.purple),
    ToolTile("Simple Interest", Icons.trending_up, Colors.green),
    ToolTile("Compound Interest", Icons.savings, Colors.orange),
    ToolTile("Profit Calculator", Icons.show_chart, Colors.teal),
    ToolTile("Loss Calculator", Icons.trending_down, Colors.red),
    ToolTile("Discount Calculator", Icons.local_offer, Colors.redAccent),
    ToolTile("Sales Tax Calculator", Icons.receipt_long, Colors.indigo),
  ]),

  /// 📊 MATH UTILITIES
  ToolSection("Math Utilities", [

    ToolTile("Percentage Calculator", Icons.percent, Colors.indigo),
    ToolTile("Ratio Calculator", Icons.compare_arrows, Colors.brown),
    ToolTile("Average Calculator", Icons.functions, Colors.deepOrange),

    ToolTile("LCM Calculator", Icons.merge_type, Colors.teal),
    ToolTile("HCF / GCD Calculator", Icons.account_tree, Colors.blueGrey),
    ToolTile("Square Calculator", Icons.crop_square, Colors.purple),
    ToolTile("Cube Calculator", Icons.view_in_ar, Colors.orange),
    ToolTile("Square Root", Icons.calculate_outlined, Colors.green),
    ToolTile("Power Calculator", Icons.flash_on, Colors.redAccent),
    // ToolTile("Scientific Calculator", Icons.science, Colors.deepPurple),

  ]),


  /// 📅 DATE & TIME
  // ToolSection("Date & Time", [
  //   ToolTile("Age Calculator", Icons.cake, Colors.pink),
  //   ToolTile("Date Difference", Icons.calendar_month, Colors.blueGrey),
  // ]),

  /// 🏥 HEALTH
  // ToolSection("Health", [
  //   ToolTile("BMI Calculator", Icons.monitor_weight, Colors.pink),
  // ]),
];

/// =======================================================
/// TOOLS SCREEN
/// =======================================================

class ToolsScreen extends StatefulWidget {
  const ToolsScreen({super.key});

  @override
  State<ToolsScreen> createState() => _ToolsScreenState();
}

class _ToolsScreenState extends State<ToolsScreen> {
  final TextEditingController searchCtrl = TextEditingController();
  List<ToolSection> filteredSections = toolSections;

  void filterTools(String text) {
    if (text.isEmpty) {
      setState(() => filteredSections = toolSections);
      return;
    }

    final q = text.toLowerCase();
    final List<ToolSection> result = [];

    for (final section in toolSections) {
      if (section.title.toLowerCase().contains(q)) {
        result.add(section);
        continue;
      }

      final tiles = section.tiles
          .where((t) => t.title.toLowerCase().contains(q))
          .toList();

      if (tiles.isNotEmpty) {
        result.add(ToolSection(section.title, tiles));
      }
    }

    setState(() => filteredSections = result);
  }

  void openTool(String title) {
    Widget screen;

    switch (title) {

    /// ================= FINANCE =================

      case "Discount Calculator":
        screen = UniversalToolCalculatorScreen(
          title: title,
          fields: const [
            ToolField(label: "Original Price"),
            ToolField(label: "Discount (%)"),
          ],
          onCalculate: (values) {
            final price = values[0];
            final percent = values[1];

            final discount = price * percent / 100;
            final finalPrice = price - discount;

            return ToolResult(
              mainValue: finalPrice,
              secondaryValue: discount,
              mainLabel: "Final Price",
              secondaryLabel: "You Save",
            );
          },
        );
        break;

      case "Profit Calculator":
        screen = UniversalToolCalculatorScreen(
          title: title,
          fields: const [
            ToolField(label: "Cost Price"),
            ToolField(label: "Selling Price"),
          ],
          onCalculate: (values) {
            final profit = values[1] - values[0];

            return ToolResult(
              mainValue: profit,
              mainLabel: "Profit",
            );
          },
        );
        break;

      case "Loss Calculator":
        screen = UniversalToolCalculatorScreen(
          title: title,
          fields: const [
            ToolField(label: "Cost Price"),
            ToolField(label: "Selling Price"),
          ],
          onCalculate: (values) {
            final loss = values[0] - values[1];

            return ToolResult(
              mainValue: loss,
              mainLabel: "Loss",
            );
          },
        );
        break;

      case "Sales Tax Calculator":
        screen = UniversalToolCalculatorScreen(
          title: title,
          fields: const [
            ToolField(label: "Amount"),
            ToolField(label: "Tax (%)"),
          ],
          onCalculate: (values) {
            final tax = values[0] * values[1] / 100;
            final total = values[0] + tax;

            return ToolResult(
              mainValue: total,
              secondaryValue: tax,
              mainLabel: "Total Amount",
              secondaryLabel: "Tax",
            );
          },
        );
        break;

    /// ================= HEALTH =================

      case "BMI Calculator":
        screen = UniversalToolCalculatorScreen(
          title: title,
          fields: const [
            ToolField(label: "Weight (kg)"),
            ToolField(label: "Height (m)"),
          ],
          onCalculate: (values) {
            final bmi = values[0] / (values[1] * values[1]);

            return ToolResult(
              mainValue: bmi,
              mainLabel: "BMI",
            );
          },
        );
        break;

    /// ================= DEFAULT =================

      default:
        screen = UniversalToolCalculatorScreen(
          title: title,
          fields: const [
            ToolField(label: "Value"),
          ],
          onCalculate: (values) {
            return ToolResult(
              mainValue: values[0],
              mainLabel: "Result",
            );
          },
        );
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ToolMapper.getScreen(title),
      ),
    );


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: Stack(
        children: [

          /// GRID CONTENT
          CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 90)),

              for (final section in filteredSections) ...[
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(18, 14, 18, 8),
                    child: Text(
                      section.title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),

                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                          (context, i) {
                        final tile = section.tiles[i];
                        return IOSPressable(
                          onTap: () {
                            openTool(tile.title);
                          },

                          child: toolTile(tile),
                        );
                      },
                      childCount: section.tiles.length,
                    ),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 14,
                      childAspectRatio: 0.9,
                    ),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 22)),
              ],

              const SliverToBoxAdapter(child: SizedBox(height: 160)),
            ],
          ),

          /// SEARCH BAR
          Positioned(
            top: 20,
            left: 18,
            right: 18,
            child: Container(
              height: 46,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(26),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 10)
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, size: 20, color: Colors.grey),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: searchCtrl,
                      onChanged: filterTools,
                      decoration: const InputDecoration(
                        hintText: "Search tools",
                        border: InputBorder.none,
                        isCollapsed: true,
                      ),
                    ),
                  ),
                  if (searchCtrl.text.isNotEmpty)
                    IconButton(
                      icon: const Icon(Icons.close, size: 18),
                      onPressed: () {
                        searchCtrl.clear();
                        filterTools("");
                      },
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget toolTile(ToolTile t) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 14, 10, 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: t.color.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(t.icon, size: 28, color: t.color),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: Text(
              t.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                height: 1.15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// =======================================================
/// IOS PRESS EFFECT
/// =======================================================

class IOSPressable extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const IOSPressable({
    super.key,
    required this.child,
    required this.onTap,
  });

  @override
  State<IOSPressable> createState() => _IOSPressableState();
}

class _IOSPressableState extends State<IOSPressable> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _pressed ? 0.965 : 1.0,
      duration: const Duration(milliseconds: 110),
      curve: Curves.easeOutCubic,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          splashColor: Colors.black.withOpacity(0.06),
          highlightColor: Colors.black.withOpacity(0.04),
          onTapDown: (_) {
            HapticFeedback.lightImpact();
            setState(() => _pressed = true);
          },
          onTapCancel: () {
            setState(() => _pressed = false);
          },
          onTap: () {
            setState(() => _pressed = false);
            widget.onTap();
          },
          child: AnimatedOpacity(
            opacity: _pressed ? 0.92 : 1,
            duration: const Duration(milliseconds: 110),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
