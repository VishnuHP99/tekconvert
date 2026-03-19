import 'package:flutter/material.dart';
import '../subcategory/subcategory_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const Color cardBorder = Color(0xFF5A8FEF);

  final List<CategoryItem> items = const [

    CategoryItem("Length & Geometry", "assets/images/LengthGeometry.png"),
    CategoryItem("Mass & Density", "assets/images/mass.png"),
    CategoryItem("Thermal & Energy", "assets/images/ThermalEnergy.png"),
    CategoryItem("Pressure & Force", "assets/images/PressureForce.png"),
    CategoryItem("Fluid Ratios", "assets/images/FluidRatios.png"),

    CategoryItem("Time", "assets/images/Time.png"),
    CategoryItem("Viscosity", "assets/images/Viscosity.png"),
    CategoryItem("Power", "assets/images/Power.png"),

    // ✅ NEW
    CategoryItem("Volume", "assets/images/Volume.png"),
    CategoryItem("Heat Transfer", "assets/images/HeatTransfer.png"),

    CategoryItem("Speed", "assets/images/Speed.png"),
    CategoryItem("Torque", "assets/images/Torque.png"),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Padding(
        padding: const EdgeInsets.fromLTRB(18, 11, 14, 5),
        child: Column(
          children: [

            // 🔍 SEARCH BAR
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F1F1),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, size: 18, color: Colors.grey),
                  const SizedBox(width: 6),

                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search for units and categories",
                        hintStyle: const TextStyle(
                          fontSize: 13,          // 👈 Change size here
                          color: Color(0xFF9A9A9A),    // 👈 Change color here
                          fontWeight: FontWeight.w500,
                        ),
                        border: InputBorder.none,
                        isCollapsed: true,
                      ),
                    ),

                  ),

                  const Icon(Icons.mic_none, size: 18, color: Colors.grey),
                ],
              ),
            ),

            const SizedBox(height: 11),

            // 📦 GRID
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.only(bottom: 120),
                physics: const BouncingScrollPhysics(),
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.60,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];

                  return IOSPressable(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SubCategoryScreen(
                            categoryTitle: item.title,
                          ),
                        ),
                      );
                    },

                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: cardBorder,
                          width: 1.3,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Image.asset(
                            item.icon,
                            height: 45,
                            width: 45,
                          ),

                          const SizedBox(height: 6),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              item.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 12.6,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  );



                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryItem {
  final String title;
  final String icon;
  const CategoryItem(this.title, this.icon);
}

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
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => pressed = true),
      onTapUp: (_) {
        setState(() => pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => pressed = false),
      child: AnimatedScale(
        scale: pressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: AnimatedOpacity(
          opacity: pressed ? 0.85 : 1.0,
          duration: const Duration(milliseconds: 120),
          child: widget.child,
        ),
      ),
    );
  }
}

