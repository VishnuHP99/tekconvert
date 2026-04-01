import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../converter/universal_converter_screen.dart';
import '../../data/unit_definitions.dart';
import '../../core/utils/ui_sound.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// =======================================================
/// MODELS
/// =======================================================

class HomeSection {
  final String title;
  final List<HomeTile> tiles;
  HomeSection(this.title, this.tiles);
}

class HomeTile {
  final String title;
  final String key;
  final String iconPath;
  HomeTile(this.title, this.key, this.iconPath);
}

class UnitSuggestion {
  final String name;
  final String symbol;
  final String categoryKey;
  UnitSuggestion(this.name, this.symbol, this.categoryKey);
}

class UnitPairSuggestion {
  final UnitSuggestion from;
  final UnitSuggestion to;
  UnitPairSuggestion(this.from, this.to);
}

/// =======================================================
/// FAST UNIT INDEX
/// =======================================================

final List<UnitSuggestion> allUnitSuggestions = (() {
  final list = <UnitSuggestion>[];
  for (final e in unitDefinitions.entries) {
    for (final u in e.value) {
      list.add(UnitSuggestion(
        u["f"].toString(),
        u["s"].toString(),
        e.key,
      ));
    }
  }
  return list;
})();


/// =======================================================
/// DATA (UNCHANGED)
/// =======================================================

final List<HomeSection> homeSections = [

  HomeSection("Length & Geometry", [
    HomeTile("Length","length","assets/images/homeIcons/lengthGeometry/length.png"),
    HomeTile("Area Small","area_small","assets/images/homeIcons/lengthGeometry/areaSmall.png"),
    HomeTile("Area Large","area_large","assets/images/homeIcons/lengthGeometry/areaLarge.png"),
    HomeTile("Acceleration","acceleration","assets/images/homeIcons/lengthGeometry/acceleration.png"),
    HomeTile("Velocity","velocity","assets/images/homeIcons/lengthGeometry/velocity.png"),
  ]),

  HomeSection("Mass & Density", [
    HomeTile("Mass","mass","assets/images/homeIcons/massDensity/mass.png"),
    HomeTile("Mass Rate","mass_rate","assets/images/homeIcons/massDensity/massRate.png"),
    HomeTile("Density","density","assets/images/homeIcons/massDensity/density.png"),
  ]),

  HomeSection("Thermal & Energy", [
    HomeTile("Temperature","temperature","assets/images/homeIcons/thermalEnergy/temperature.png"),
    HomeTile("Energy","energy","assets/images/homeIcons/thermalEnergy/energy.png"),
    HomeTile("Energy Rate","energy_rate","assets/images/homeIcons/thermalEnergy/energyRate.png"),
    HomeTile("Heat Capacity","heat_capacity","assets/images/homeIcons/thermalEnergy/heatCapacity.png"),
    HomeTile("Heating Value (Mass)","heating_mass","assets/images/homeIcons/thermalEnergy/heatingMass.png"),
    HomeTile("Heating Value (Volume)","heating_volume","assets/images/homeIcons/thermalEnergy/heatingVolume.png"),
    HomeTile("Thermal Conductivity","thermal_conductivity","assets/images/homeIcons/thermalEnergy/thermalConductivity.png"),
  ]),

  HomeSection("Pressure & Force", [
    HomeTile("Pressure","pressure","assets/images/homeIcons/pressureForce/Pressure.png"),
    HomeTile("Differential Pressure","differential_pressure","assets/images/homeIcons/pressureForce/pressureDelta.png"),
    HomeTile("Force","force","assets/images/homeIcons/pressureForce/force.png"),
    HomeTile("Surface Tension","surface_tension","assets/images/homeIcons/pressureForce/surfaceTension.png"),
  ]),

  HomeSection("Volume & Flow", [
    HomeTile("Volume","volume","assets/images/homeIcons/volume/Volume.png"),
    HomeTile("Gas Flow Standard","flow_standard","assets/images/homeIcons/volume/gasFlow.png"),
    HomeTile("Gas Flow Actual","flow_actual","assets/images/homeIcons/volume/gasActual.png"),
    HomeTile("Liquid Flow","flow_liquid","assets/images/homeIcons/volume/volumeRateLiq.png"),
    //HomeTile("Gas Flow","gas_flow","assets/images/homeIcons/volume/gasFlow.png")
  ]),

  HomeSection("Fluid Ratios", [
    HomeTile("Condensate-Gas Ratio","cgr","assets/images/homeIcons/fluidRatios/CGR.png"),
    HomeTile("Gas-Liquid Ratio","glr","assets/images/homeIcons/fluidRatios/GLR.png"),
    HomeTile("Liquid-Gas Ratio","lgr","assets/images/homeIcons/fluidRatios/LGR.png"),
    HomeTile("Gas-Oil Ratio","gor","assets/images/homeIcons/fluidRatios/GOR.png"),
  ]),

  HomeSection("Time", [
    HomeTile("Time Large","time_large","assets/images/homeIcons/time/timeLarge.png"),
    HomeTile("Time Small","time_small","assets/images/homeIcons/time/timeSmall.png"),
  ]),

  HomeSection("Viscosity", [
    HomeTile("Dynamic Viscosity","viscosity_dynamic","assets/images/homeIcons/viscosity/dynamicViscosity.png"),
    HomeTile("Kinematic Viscosity","viscosity_kinematic","assets/images/homeIcons/viscosity/kinematicViscosity.png"),
  ]),

  HomeSection("Power & Heat Transfer", [
    HomeTile("Power","power","assets/images/homeIcons/powerHeat/Power.png"),
    HomeTile("Heat Transfer","heat_transfer","assets/images/homeIcons/powerHeat/HeatTransfer.png"),
  ]),

  HomeSection("Speed & Torque", [
    HomeTile("Speed","speed","assets/images/homeIcons/speedTorque/Speed.png"),
    HomeTile("Torque","torque","assets/images/homeIcons/speedTorque/Torque.png"),
  ]),
];


/// =======================================================
/// SCREEN
/// =======================================================

class NewHomeScreen extends StatefulWidget {
  const NewHomeScreen({super.key});
  @override
  State<NewHomeScreen> createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {

  final TextEditingController searchCtrl = TextEditingController();
  final FocusNode searchFocus = FocusNode();
  Timer? debounce;

  List<UnitSuggestion> suggestions = [];
  List<UnitSuggestion> recent = [];
  List<UnitPairSuggestion> pairSuggestions = []; // 👈 NEW

  bool searchActive = false;
  late List<HomeSection> filteredSections;
  String getCategoryTitle(String key) {
    for (final section in homeSections) {
      for (final tile in section.tiles) {
        if (tile.key == key) {
          return tile.title;
        }
      }
    }
    return key;
  }
  @override
  void initState() {
    super.initState();
    _handleAppUpdate();
    PaintingBinding.instance.imageCache.maximumSize = 100;
    PaintingBinding.instance.imageCache.maximumSizeBytes = 15 << 20; // 🔥 BEST
    filteredSections = homeSections;

    // 🔥 PRELOAD IMAGES (VERY IMPORTANT)

  }


  /// =======================================================

  @override
  void dispose() {
    debounce?.cancel();
    searchCtrl.dispose();
    searchFocus.dispose();




    super.dispose();
  }

  /// =======================================================
  String normalize(String input) {
    return input
        .toLowerCase()
        .replaceAll(' ', '')        // remove spaces
        // .replaceAll('₂', '2')      // H₂O → H2O
        // .replaceAll('³', '3')      // if ever used
        .replaceAll('/', '');       // optional (N/m² → Nm²)
        // .replaceAll('²', '2');     // m² → m2
  }

  void updateSuggestions(String text) {

    filterHomeByCategory(text);

    // 🔥 PAIR DETECTION
    List<UnitPairSuggestion> tempPairs = [];

    final cleaned = text.toLowerCase()
        .replaceAll(" into ", " to ")
        .replaceAll("-", " to ");
    final q = normalize(text);

// 🔥 DETECT CATEGORY INTENT
    String? forcedCategory;

    if (text.contains("m3") || text.contains("cube") || text.contains("³")) {
      forcedCategory = "volume";
    }
    else if (text.contains("m2") || text.contains("square") || text.contains("²")) {
      forcedCategory = "area_small";
    }
    else if (text.contains("kg/") || text.contains("/m3")) {
      forcedCategory = "density";
    }
    else if (text.trim() == "g" || text.startsWith("g ")) {
      forcedCategory = "mass";
    }

    // =======================================================
    // 🔥 CASE 1 + 2 → WITH "to"
    // =======================================================
    if (cleaned.contains("to")) {

      final parts = cleaned.split("to");
      final fromQuery = normalize(parts[0].trim());


      final toQuery = parts.length > 1
          ? normalize(parts[1].trim())
          : "";

      final isCubeSearch =
          text.toLowerCase().contains("3") ||
              text.toLowerCase().contains("cube");

      final isSquareSearch =
          text.toLowerCase().contains("2") ||
              text.toLowerCase().contains("square");

      final fromMatches = allUnitSuggestions.where((u) {
        final name = normalize(u.name);
        final symbol = u.symbol;
        final symbolNormalized = symbol
            .replaceAll("³", "3")
            .replaceAll("²", "2")
            .toLowerCase();

        // 🔥 CATEGORY FILTER (THIS FIXES YOUR BUG)
        if (forcedCategory != null && u.categoryKey != forcedCategory) {
          return false;
        }

        // 🔥 HANDLE CUBE
        if (isCubeSearch) {
          return u.categoryKey == "volume" &&
              (symbol.contains("³") || name.contains("cubic"));
        }

        // 🔥 HANDLE SQUARE
        if (isSquareSearch) {
          return symbol.contains("²") || name.contains("square");
        }

        return symbolNormalized.startsWith(fromQuery) || name.startsWith(fromQuery);
      }).toList();

      // ✅ CASE: "km to" → ALL units in same category
      if (toQuery.isEmpty) {

        for (final f in fromMatches) {
          final sameCategoryUnits = allUnitSuggestions.where(
                (u) => u.categoryKey == f.categoryKey && u.symbol != f.symbol,
          );

          for (final u in sameCategoryUnits) {

            // ✅ forward: m² → km²
            tempPairs.add(UnitPairSuggestion(f, u));

            // 🔥 reverse: km² → m²
            tempPairs.add(UnitPairSuggestion(u, f));
          }
        }

      }

      // ✅ CASE: "km to m"
      else {

        final toMatches = allUnitSuggestions.where((u) {
          final name = normalize(u.name);
          final symbolNormalized = u.symbol
              .replaceAll("³", "3")
              .replaceAll("²", "2")
              .toLowerCase();

          // 🔥 CATEGORY FILTER
          if (forcedCategory != null && u.categoryKey != forcedCategory) {
            return false;
          }

          return symbolNormalized.startsWith(toQuery) || name.startsWith(toQuery);
        }).toList();

        for (final f in fromMatches) {
          for (final t in toMatches) {
            if (f.categoryKey == t.categoryKey) {
              tempPairs.add(UnitPairSuggestion(f, t));
            }
          }
        }
      }
    }

    // =======================================================
    // 🔥 CASE 3 → ONLY "km" (NO "to")
    // =======================================================
    else {

      final isCubeSearch =
          text.toLowerCase().contains("3") ||
              text.toLowerCase().contains("cube");

      final isSquareSearch =
          text.toLowerCase().contains("2") ||
              text.toLowerCase().contains("square");

      final fromMatches = allUnitSuggestions.where((u) {
        final name = normalize(u.name);
        final symbol = u.symbol;
        final q = normalize(text);
        final symbolNormalized = symbol
            .replaceAll("³", "3")
            .replaceAll("²", "2")
            .toLowerCase();

        // 🔥 CATEGORY FILTER (THIS FIXES YOUR BUG)
        if (forcedCategory != null && u.categoryKey != forcedCategory) {
          return false;
        }

        // 🔥 HANDLE CUBE
        if (isCubeSearch) {
          return u.categoryKey == "volume" &&
              (symbol.contains("³") || name.contains("cubic"));
        }

        // 🔥 HANDLE SQUARE
        if (isSquareSearch) {
          return symbol.contains("²") || name.contains("square");
        }

        return symbolNormalized.startsWith(q) || name.startsWith(q);
      }).toList();

// 🔥 ADD THIS


      final strongMatches = fromMatches.where((u) {
        final symbol = normalize(u.symbol);
        return symbol == q || symbol.startsWith(q);
      }).toList();


      for (final f in strongMatches.isNotEmpty ? strongMatches : fromMatches) {
        final sameCategoryUnits = allUnitSuggestions.where(
              (u) => u.categoryKey == f.categoryKey && u.symbol != f.symbol,
        );

        for (final u in sameCategoryUnits) {
          tempPairs.add(UnitPairSuggestion(f, u));
        }
      }
    }

    // =======================================================
    // 🔥 NORMAL SUGGESTIONS (EXISTING LOGIC)
    // =======================================================

    debounce?.cancel();

    debounce = Timer(const Duration(milliseconds: 300), () {

      if (text.isEmpty) {
        setState(() {
          suggestions = [];
          pairSuggestions = []; // 👈 IMPORTANT
        });
        return;
      }

      final q = normalize(text);

      final exact = <UnitSuggestion>[];
      final symbolExact = <UnitSuggestion>[];   // 🔥 NEW
      final symbolStarts = <UnitSuggestion>[];  // 🔥 NEW
      final nameStarts = <UnitSuggestion>[];
      final contains = <UnitSuggestion>[];
      final isCubeSearch =
          text.toLowerCase().contains("3") ||
              text.toLowerCase().contains("m3") ||
              text.toLowerCase().contains("cube");

      final isSquareSearch =
          text.toLowerCase().contains("2") ||
              text.toLowerCase().contains("m2") ||
              text.toLowerCase().contains("square");

      for (final u in allUnitSuggestions) {
        final name = normalize(u.name);
        final symbolRaw = u.symbol; // ⚠️ DON'T normalize here fully
        final symbol = normalize(u.symbol);

        // 🔥 CUBE SEARCH
        if (isCubeSearch) {
          if (u.categoryKey == "volume" &&
              (symbolRaw.contains("³") || name.contains("cubic"))) {
            symbolStarts.add(u);
          }
          continue;
        }

        // 🔥 SQUARE SEARCH
        if (isSquareSearch) {
          if (symbolRaw.contains("²") || name.contains("square")) {
            symbolStarts.add(u);
          }
          continue;
        }

        // ===== EXISTING LOGIC =====

        if (name == q || symbol == q) {
          exact.add(u);
        }
        else if (symbol == q) {
          symbolExact.add(u);
        }
        else if (symbol.startsWith(q)) {
          symbolStarts.add(u);
        }
        else if (name.startsWith(q)) {
          nameStarts.add(u);
        }
        else if (name.contains(q) || symbol.contains(q)) {
          contains.add(u);
        }
      }

      final matches = [
        ...symbolExact,   // m
        ...symbolStarts,  // m², m³, mm
        ...exact,         // meter
        ...nameStarts,
        ...contains,
      ].toList();

// 🔥 CRITICAL FIX — SORT AFTER MERGE
      matches.sort((a, b) {

        final aSym = a.symbol.toLowerCase();
        final bSym = b.symbol.toLowerCase();

        // ✅ exact symbol first (m)
        if (aSym == q && bSym != q) return -1;
        if (bSym == q && aSym != q) return 1;

        // ✅ shorter symbols first (m before cm)
        if (aSym.length != bSym.length) {
          return aSym.length.compareTo(bSym.length);
        }

        // fallback
        return aSym.compareTo(bSym);
      });

      final finalMatches = matches.take(40).toList();

      setState(() {
        suggestions = finalMatches;

        // 🔥 LIMIT (important for performance)
        final q = normalize(text);

// 🔥 FILTER BEST MATCHES ONLY
        final filteredPairs = tempPairs.where((p) {
          final symbol = normalize(p.from.symbol);
          return symbol == q || symbol.startsWith(q);
        }).toList();

// 🔥 fallback if nothing matched strongly
        pairSuggestions = (filteredPairs.isNotEmpty
            ? filteredPairs
            : tempPairs).take(25).toList();

        searchActive = true;
      });
    });
  }

  // sub cat and cat filtering

  void filterHomeByCategory(String text) {
    if (text.isEmpty) {
      setState(() => filteredSections = homeSections);
      return;
    }

    final q = text.toLowerCase();

    final List<HomeSection> result = [];

    for (final section in homeSections) {

      // Match section title
      if (section.title.toLowerCase().contains(q)) {
        result.add(section);
        continue;
      }

      // Match tiles
      final tiles = section.tiles.where(
            (t) => t.title.toLowerCase().contains(q),
      ).toList();

      if (tiles.isNotEmpty) {
        result.add(HomeSection(section.title, tiles));
      }
    }

    setState(() => filteredSections = result);
  }


  /// =======================================================

  void open(UnitSuggestion u) {

    //searchFocus.unfocus();

    if (!recent.any((r) => r.symbol == u.symbol)) {
      recent.insert(0, u);
      if (recent.length > 6) recent.removeLast();
    }

    // Search correct category
    for (final s in homeSections) {
      for (final t in s.tiles) {

        if (t.key == u.categoryKey) {
          FocusManager.instance.primaryFocus?.unfocus();

          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (_) => UniversalConverterScreen(
                title: t.title,
                categoryKey: t.key,
                initialFromUnit: u.symbol,   // 👈 THIS IS THE MISSING PART
              ),
            ),
          );

          return;
        }
      }
    }

    debugPrint("Category not found for: ${u.categoryKey}");
  }

  void openPair(UnitPairSuggestion p) {

    if (!recent.any((r) => r.symbol == p.from.symbol)) {
      recent.insert(0, p.from);
      if (recent.length > 6) recent.removeLast();
    }

    for (final s in homeSections) {
      for (final t in s.tiles) {

        if (t.key == p.from.categoryKey) {

          FocusManager.instance.primaryFocus?.unfocus();

          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (_) => UniversalConverterScreen(
                title: t.title,
                categoryKey: t.key,
                initialFromUnit: p.from.symbol,
                initialToUnit: p.to.symbol, // 👈 THIS IS THE MAIN UPGRADE
              ),
            ),
          );

          return;
        }
      }
    }
  }


  /// =======================================================

  @override
  Widget build(BuildContext context) {

    if (!searchActive) searchFocus.unfocus();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: Stack(
        children: [

          /// HOME GRID
          CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [


              const SliverToBoxAdapter(child:SizedBox(height:80)),

              for (final s in filteredSections) ...[

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(18,14,18,8),
                    child: Text(
                      s.title,
                      style: const TextStyle(
                        fontSize:17,
                        fontWeight:FontWeight.w700,
                      ),
                    ),
                  ),
                ),

                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal:18),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                          (context,i){
                        final t = s.tiles[i];
                        return IOSPressable(
                          onTap: (){
                            UISound.tap();
                            FocusManager.instance.primaryFocus?.unfocus();
                            searchFocus.unfocus();
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) => UniversalConverterScreen(
                                  title: t.title,
                                  categoryKey: t.key,
                                ),
                              ),
                            );
                          },
                          child: tile(t),
                        );
                      },
                      childCount: s.tiles.length,
                    ),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:3,
                      crossAxisSpacing:10,
                      mainAxisSpacing:14,
                      childAspectRatio:0.9,
                    ),
                  ),
                ),

                const SliverToBoxAdapter(child:SizedBox(height:22)),
              ],

              const SliverToBoxAdapter(child:SizedBox(height:160)),
            ],
          ),

          /// SEARCH BAR + PANEL
          Positioned(
            top:12,left:18,right:18,
            child: Column(
              children: [

                searchBar(),

                if(searchActive &&
                    (recent.isNotEmpty || suggestions.isNotEmpty || pairSuggestions.isNotEmpty))
                  panel(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// =======================================================

  Widget searchBar() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.15)
              : Colors.grey.shade300,
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(isDark ? 0.35 : 0.12),
            blurRadius: 12,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [

          Icon(
            Icons.search,
            size: 20,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.65),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: TextField(
              controller: searchCtrl,
              focusNode: searchFocus,
              onTap: () => setState(() => searchActive = true),
              onChanged: updateSuggestions,
              style: TextStyle(
                color: theme.colorScheme.onSurface,
                fontSize: 15,
              ),
              decoration: InputDecoration(
                hintText: "Search units and categories",
                hintStyle: TextStyle(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
                border: InputBorder.none,
                isCollapsed: true,
              ),
            ),
          ),

          if (searchActive)
            GestureDetector(
              onTap: () {
                searchFocus.unfocus();
                searchCtrl.clear();
                setState(() {
                  suggestions = [];
                  searchActive = false;
                  filteredSections = homeSections;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withValues(alpha: 0.12), // light red background
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close,
                  size: 16,
                  color: Colors.red, // 👈 red cross
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// =======================================================

  Widget panel() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: theme.dividerColor.withValues(alpha: 0.15),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(isDark ? 0.45 : 0.15),
            blurRadius: 16,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 320, // 👈 control height here
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

          if (recent.isNotEmpty)
            header("Recently Searched", clear: true),

          ...recent.map(recentRow),
              if (pairSuggestions.isNotEmpty)
                header(
                  pairSuggestions.first.from.symbol.isNotEmpty
                      ? "Quick Conversions from ${pairSuggestions.first.from.symbol}"
                      : "Quick Conversions",
                ),
//

              ...pairSuggestions.map(pairRow),

          if (suggestions.isNotEmpty)
            header("Suggestions"),

          ...suggestions.map(suggestionRow),
        ],
      ),
    ),
    ),
    );
  }

  Widget header(String title, {bool clear = false}) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 10, 10, 6),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          const Spacer(),
          if (clear)
            TextButton(
              onPressed: () => setState(() => recent.clear()),
              child: const Text("Clear", style: TextStyle(fontSize: 12)),
            ),
        ],
      ),
    );
  }

  Widget recentRow(UnitSuggestion u) {
    final theme = Theme.of(context);

    return ListTile(
      dense: true,
        title: RichText(
          text: TextSpan(
            text: u.name,
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            children: [
              TextSpan(
                text: "  •  ${getCategoryTitle(u.categoryKey)}",
                style: TextStyle(
                  fontSize: 12,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            u.symbol,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.primary,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.close,
              size: 16,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            onPressed: () {
              setState(() => recent.remove(u));
            },
          ),
        ],
      ),
        onTap: () {
        UISound.tap();
          // searchFocus.unfocus();
          //
          // setState(() {
          //   searchActive = false;
          //   suggestions = [];
          // });

          open(u);
        }
    );
  }

  Widget suggestionRow(UnitSuggestion u) {
    final theme = Theme.of(context);

    return ListTile(
      dense: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              u.name,
              style: TextStyle(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              getCategoryTitle(u.categoryKey),
              style: TextStyle(
                fontSize: 11,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      trailing: Text(
        u.symbol,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: theme.colorScheme.primary,
        ),
      ),
        onTap: () {
        UISound.tap();
          // searchFocus.unfocus();
          //
          // setState(() {
          //   searchActive = false;
          //   suggestions = [];
          // });

          open(u);
        }
    );
  }

  Widget pairRow(UnitPairSuggestion p) {
    final theme = Theme.of(context);

    return ListTile(
      dense: true,
      title: Text(
        "${p.from.name} → ${p.to.name}",
        style: TextStyle(
          color: theme.colorScheme.onSurface,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        getCategoryTitle(p.from.categoryKey),
        style: TextStyle(
          fontSize: 11,
          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
        ),
      ),
      trailing: Text(
        "${p.from.symbol} → ${p.to.symbol}",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: theme.colorScheme.primary,
        ),
      ),
      onTap: () {
        UISound.tap();
        openPair(p); // 👈 NEW FUNCTION
      },
    );
  }

  /// =======================================================

  Widget tile(HomeTile t){
    return Padding(
      padding: const EdgeInsets.fromLTRB(10,14,10,12),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Image.asset(
            t.iconPath,
            height: 44,
            width: 44,
            cacheWidth: 64, // 🔥 reduce more
            cacheHeight: 64,
            // filterQuality: FilterQuality.low, // 🔥 important
          ),

          const SizedBox(height:10),

          SizedBox(
            width: double.infinity,
            child: Text(
              t.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                height: 1.15,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),


        ],
      ),
    );
  }

}
Future<void> _handleAppUpdate() async {
  final prefs = await SharedPreferences.getInstance();
  final packageInfo = await PackageInfo.fromPlatform();

  final currentVersion = packageInfo.version;
  final lastVersion = prefs.getString("app_version");

  if (lastVersion != currentVersion) {
    // 🔥 CLEAR ONLY ON UPDATE
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();

    await prefs.setString("app_version", currentVersion);
  }
}

/// =======================================================
/// PRESS EFFECT
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
      scale: _pressed ? 0.94 : 1.0,
      duration: const Duration(milliseconds: 140),
      curve: Curves.easeOutBack,

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 140),
        curve: Curves.easeOutCubic,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            if (!_pressed)
              const BoxShadow(
                color: Color(0x14000000),
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
          ],
        ),

        child: Material(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(18),
          clipBehavior: Clip.antiAlias,

          child: InkWell(
            borderRadius: BorderRadius.circular(18),

            splashColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.08),
            highlightColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.04),

            onTapDown: (_) {
              HapticFeedback.lightImpact();
              setState(() => _pressed = true);
            },

            onTapCancel: () {
              setState(() => _pressed = false);
            },

            onTap: () {
              setState(() => _pressed = false);

              UISound.tap(); // 🔊 UI sound

              widget.onTap();
            },

            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 120),
              opacity: _pressed ? 0.92 : 1,
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}


