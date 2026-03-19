import 'package:flutter/material.dart';
import '../../widgets/common/app_top_bar.dart';
import '../converter/universal_converter_screen.dart';

class SubCategoryScreen extends StatelessWidget {
  final String categoryTitle;

  const SubCategoryScreen({
    super.key,
    required this.categoryTitle,
  });

  // ================= CATEGORY → SUBCATEGORY KEYS =================

  static const Map<String, List<Map<String, String>>> subCategoryMap = {

    // ---------------- LENGTH & GEOMETRY ----------------
    "Length & Geometry": [
      {"title": "Length", "key": "length"},
      {"title": "Area Small", "key": "area_small"},
      {"title": "Area Large", "key": "area_large"},
      {"title": "Acceleration", "key": "acceleration"},
      {"title": "Velocity", "key": "velocity"},
    ],


    // ---------------- MASS & DENSITY ----------------
    "Mass & Density": [
      {"title": "Mass", "key": "mass"},
      {"title": "Mass Rate", "key": "mass_rate"},
      {"title": "Density", "key": "density"},
    ],


    // ---------------- THERMAL & ENERGY ----------------
    "Thermal & Energy": [
      {"title": "Temperature", "key": "temperature"},
      {"title": "Energy", "key": "energy"},
      {"title": "Energy Rate", "key": "energy_rate"},
      {"title": "Heat Capacity", "key": "heat_capacity"},
      {"title": "Heating Value (Mass)", "key": "heating_mass"},
      {"title": "Heating Value (Volume)", "key": "heating_volume"},

      {"title": "Thermal Conductivity", "key": "thermal_conductivity"},
    ],


    // ---------------- PRESSURE & FORCE ----------------
    "Pressure & Force": [
      {"title":"Pressure","key":"pressure"},
      {"title":"Pressure Delta","key":"pressure_delta"},
      {"title":"Pressure High","key":"pressure_high"},
      {"title":"Pressure Low","key":"pressure_low"},
      {"title":"Force","key":"force"},
      {"title":"Surface Tension","key":"surface_tension"},

    ],

// fluid ratios
    "Fluid Ratios": [
      {"title": "CGR", "key": "cgr"},
      {"title": "GLR", "key": "glr"},
      {"title": "LGR", "key": "lgr"},
      {"title": "GOR", "key": "gor"},
    ],


    // ---------------- TIME ----------------
    "Time": [
      {"title": "Time Large", "key": "time_large"},
      {"title": "Time Small", "key": "time_small"},
    ],

    // ---------------- VISCOSITY ----------------
    "Viscosity": [
      {"title": "Dynamic Viscosity", "key": "viscosity_dynamic"},
      {"title": "Kinematic Viscosity", "key": "viscosity_kinematic"},
    ],

    // ---------------- POWER ----------------
    "Power": [
      {"title": "Power", "key": "power"},
    ],



    // ---------------- VOLUME ----------------
    "Volume": [
      {"title": "Volume", "key": "volume"},
      {"title": "Volume Rate Standard", "key": "volume_rate_std"},
      {"title": "Volume Rate Actual", "key": "volume_rate_actual"},
      {"title": "Volume Rate Liquid", "key": "volume_rate_liquid"},
    ],


    // ---------------- HEAT TRANSFER ----------------
    "Heat Transfer": [
      {"title": "Heat Transfer Coeff.", "key": "heat_transfer"},
    ],


    // ---------------- SPEED ----------------
    "Speed": [
      {"title": "Speed", "key": "speed"},
    ],


    // ---------------- TORQUE ----------------
    "Torque": [
      {"title": "Torque", "key": "torque"},
    ],

  };

  // ================================================================

  @override
  Widget build(BuildContext context) {

    final subItems = subCategoryMap[categoryTitle] ?? [];

    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
        children: [

          AppTopBar(
            currentIndex: -1,
            title: categoryTitle,
            onBack: () => Navigator.pop(context),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 20),
              itemCount: subItems.length,
              itemBuilder: (context, index) {

                final title = subItems[index]["title"]!;
                final key   = subItems[index]["key"]!;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 25),

                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => UniversalConverterScreen(
                            title: title,
                            categoryKey: key,
                          ),

                        ),
                      );
                    },

                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1C238C),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),

                      alignment: Alignment.center,
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
