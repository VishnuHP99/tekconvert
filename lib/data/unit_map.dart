final Map<String, Map<String, double>> unitMap = {

  // ================= LENGTH =================
  // Base: meter
  "length": {
    "Å": 1e-10,              // 🔥 added
    "au": 1.495978707e11,    // 🔥 added
    "cm": 0.01,
    "dm": 0.1,               // 🔥 added
    "ft": 0.3048,
    "fathom": 1.8288,        // 🔥 added
    "fur": 201.168,          // 🔥 added (furlong)
    "in": 0.0254,
    "km": 1000,
    "league": 4828.032,      // 🔥 added (3 miles)
    "ly": 9.4607e15,         // 🔥 added
    "m": 1,
    "mi": 1609.344,
    "mil": 0.0000254,        // 🔥 added (1/1000 inch)
    "mm": 0.001,
    "μm": 1e-6,              // 🔥 added
    "nmi": 1852,             // 🔥 added
    "pc": 3.0857e16,         // 🔥 added
    "rod": 5.0292,           // 🔥 added
    "yd": 0.9144,
  },

  // ================= AREA SMALL =================
  // Base: m²
  "area_small": {
    "mm²": 1e-6,
    "cm²": 1e-4,
    "in²": 0.00064516,
    "m²": 1,
    "ft²": 0.09290304,
    "yd²": 0.83612736,
  },

  // ================= AREA LARGE =================
  // Base: m²
  "area_large": {
    "m²": 1,
    "km²": 1e6,
    "mi²": 2589988.11,
    "ha": 10000,
    "acre": 4046.8564224,
  },

  // ================= ACCELERATION =================
  // Base: m/s²
  "acceleration": {
    "mm/s²": 0.001,
    "m/s²": 1,
    "km/s²": 1000,
    "in/s²": 0.0254,
    "ft/s²": 0.3048,
    "mi/s²": 1609.344,
    "g": 9.80665,
  },

  // ================= VELOCITY =================
  // Base: m/s
  "velocity": {
    "m/s": 1,
    "km/h": 0.2777777778,
    "ft/s": 0.3048,
    "mi/h": 0.44704,
    "knot": 0.514444,
  },

  // ================= MASS =================
  // Base: kg
  "mass": {
    "mg": 0.000001,
    "g": 0.001,
    "kg": 1,
    "oz": 0.028349523125,
    "lb": 0.45359237,
    "tonne": 1000,
    "ton_short": 907.18474,
    "ton_long": 1016.0469088,
  },

  // ================= MASS RATE =================
// Base: kg/s
  "mass_rate": {
    "mg/s": 0.000001,
    "g/s": 0.001,
    "kg/s": 1,
    "kg/h": 1 / 3600,
    "t/h": 1000 / 3600,
    "t/day": 1000 / 86400,
    "lb/s": 0.45359237,
    "lb/h": 0.45359237 / 3600,
  },

// ================= DENSITY =================
// Base: kg/m³
  "density": {
    "kg/m³": 1,
    "g/cm³": 1000,
    "g/mL": 1000,
    "lb/ft³": 16.01846337,
    "lb/in³": 27679.90471,
  },

  // ================= THERMAL & ENERGY =================

// Base: Kelvin (handled separately)
  "temperature": {
    "°C": 1,
    "K": 1,
    "°F": 1,
    "°R": 1,
  },

// Base: Joule
  "energy": {
    "J": 1.0,
    "kJ": 1000.0,
    "MJ": 1000000.0,
    "Gj": 1000000000.0,

    // Thermodynamic/Thermal Units
    "cal": 4.184,
    "kcal": 4184.0,
    "BTU": 1055.05585,
    "th": 4184000.0,        // 1 Thermie = 1,000 kcal
    "thm": 105480400.0,     // US Food/Therm = 100,000 BTU
    "quad": 1.05505585e18,  // 1 Quad = 10^15 BTU

    // Electrical Units
    "eV": 1.602176634e-19,  // Exact CODATA value
    "kWh": 3600000.0,       // 3.6 million Joules
    "Ws": 1.0,              // 1 Watt-second = 1 Joule

    // Mechanical Units
    "Nm": 1.0,              // 1 Newton-meter = 1 Joule
    "ft·lb": 1.3558179483   // Consistent with your Torque factor
  },

// Base: J/s
  "energy_rate": {
    "TJ/d": (1e12) / 86400,
    "PJ/y": (1e15) / (365 * 86400),
  },

// Base: J/K
  "heat_capacity": {
    "J/K": 1,
    "BTU/°F": 1900.57,
    "cal/°C": 4.184,
  },

// Base: MJ/kg
  "heating_mass": {
    "MJ/kg": 1,
    "BTU/kg": 0.00105505585,
    "BTU/lb": 0.002326,
    "kcal/kg": 0.004184,
    "kcal/lb": 0.009237,
  },

// Base: MJ/m³
  "heating_volume": {
    "MJ/m³": 1,
    "MJ/scf": 1 / 0.0283168466,
    "BTU/m³": 0.00105505585,
    "BTU/scf": 0.03732,
    "kcal/m³": 0.004184,
    "kcal/scf": 0.14776,
    "BTU/lbmol": 0.00009832,
  },

// Base: W/(m·K)
  "thermal_conductivity": {
    "W/(m·K)": 1,
    "BTU/(h·ft·°F)": 1.730735,
    "BTU·in/(h·ft²·°F)": 0.144,
    "cal/(s·m·°C)": 4.184,
  },

  // ================= PRESSURE (ALL MERGED) =================
// Base: Pa
  "pressure": {
    // ===== SI & METRIC (Exact Definitions) =====
    "Pa": 1.0,
    "Pa (A)": 1.0,
    "N/m²": 1.0,
    "hPa": 100.0,
    "kPa": 1000.0,
    "kPa (A)": 1000.0,
    "kPa (G)": 1000.0,
    "MPa": 1000000.0,
    "MPa (A)": 1000000.0,
    "MPa (G)": 1000000.0,

    // ===== BAR & ATM (Exact Definitions) =====
    "bar": 100000.0,
    "bara": 100000.0,
    "barg": 100000.0,
    "mbar": 100.0,
    "atm": 101325.0,
    "atm (A)": 101325.0,
    "atm (G)": 101325.0,
    "at": 98066.5,

    // ===== IMPERIAL / US (Exact Definitions) =====
    // 1 lbf = 4.44822161526 N exactly. 1 inch = 0.0254 m exactly.
    "psi": 6894.757293168361,
    "psia": 6894.757293168361,
    "psig": 6894.757293168361,
    "psf": 47.88025898033584,
    "ksi": 6894757.293168361,

    // ===== MERCURY (Conventional Liquid Column at 0°C) =====
    // Exact mathematical derivatives of standard mercury density and gravity
    "mmHg": 133.322387415,
    "cmHg": 1333.22387415,
    "inHg": 3386.388640341, // Exactly mmHg * 25.4
    "torr": 133.32236842105263, // Exactly 101325 / 760

    // ===== WATER (Conventional Liquid Column at 4°C / 39.2°F) =====
    // Exact mathematical derivatives of 1000 kg/m³ density
    "m H₂O": 9806.65,
    "cm H₂O": 98.0665,
    "in H₂O": 249.08891,    // Exactly cmH2O * 2.54
    "ft H₂O": 2989.06692,   // Exactly inH2O * 12

    // ===== FORCE/AREA =====
    "kgf/cm²": 98066.5,
    "kg/cm² (A)": 98066.5,
    "kgf/m²": 9.80665
  },

  // Differential Pressure
  "differential_pressure": {
    // ===== SI =====
    "Pa (Δ)": 1.0,
    "N/m² (Δ)": 1.0,
    "hPa (Δ)": 100.0,
    "kPa (Δ)": 1000.0,
    "MPa (Δ)": 1000000.0,

    // ===== BAR & ATM =====
    "bar (Δ)": 100000.0,
    "mbar (Δ)": 100.0,
    "atm (Δ)": 101325.0,
    "at (Δ)": 98066.5,

    // ===== IMPERIAL =====
    "psi (Δ)": 6894.757293168361,
    "psf (Δ)": 47.88025898033584,
    "ksi (Δ)": 6894757.293168361,

    // ===== MERCURY =====
    "mmHg (Δ)": 133.322387415,
    "cmHg (Δ)": 1333.22387415,
    "inHg (Δ)": 3386.388640341,
    "torr (Δ)": 133.32236842105263,

    // ===== WATER =====
    "mm H₂O (Δ)": 9.80665,
    "cm H₂O (Δ)": 98.0665,
    "m H₂O (Δ)": 9806.65,
    "in H₂O (Δ)": 249.08891,
    "ft H₂O (Δ)": 2989.06692,

    // ===== FORCE/AREA =====
    "kgf/cm² (Δ)": 98066.5,
    "kgf/m² (Δ)": 9.80665
  },
// ================= FORCE =================
// Base: Newton
  "force": {
    "N": 1,

    "mN": 0.001,
    "μN": 1e-6,             // 🔥 added
    "nN": 1e-9,             // 🔥 added
    "kN": 1000,             // 🔥 added
    "MN": 1e6,              // 🔥 added
    "GN": 1e9,              // 🔥 added

    "dyn": 1e-5,

    "kgf": 9.80665,
    "gf": 0.00980665,       // 🔥 added
    "mgf": 9.80665e-6,      // 🔥 added
    "kp": 9.80665,          // 🔥 added (same as kgf)

    "lbf": 4.448221615,
    "ozf": 0.27801385,      // 🔥 added

    "kip": 4448.221615,     // 🔥 added (1000 lbf)

    "pdl": 0.138255,        // 🔥 added (poundal)

    "tf": 9806.65,          // 🔥 added (metric ton-force)
    "stnf": 8896.443,       // 🔥 added (short ton-force)
    "ltnf": 9964.016,       // 🔥 added (long ton-force)

    "sn": 1000,             // 🔥 added (sthène = 1 kN)
  },

// ================= SURFACE TENSION =================
// Base: N/m
  "surface_tension": {
    "N/m": 1,
    "mN/m": 0.001,
    "dyn/cm": 0.001,
    "lbf/in": 175.12677,
    "kgf/m": 9.80665,
    "T/m": 9806.65,
  },

  // ================= FLUID RATIOS =================

// ---------- CGR ----------
  "cgr": {
    // base = m³/Mm³
    "m³/Mm³": 1,
    "bbl/MMscf": 1 / 0.178107606,
  },

// ---------- GLR ----------
  "glr": {
    // base = m³/m³
    "m³/m³": 1,
    "scf/bbl": 0.028316846592 / 0.158987294928,
  },

// ---------- LGR ----------
  "lgr": {
    // base = m³/Mm³
    "m³/Mm³": 1,
    "bbl/MMscf": 1 / 0.178107606,
  },

// ---------- GOR ----------
  "gor": {
    // base = m³/m³
    "m³/m³": 1,
    "scf/bbl": 0.028316846592 / 0.158987294928,
  },

  // ================= TIME LARGE =================
// Base: second
  "time_large": {
    "h": 3600,
    "day": 86400,
    "month": 2592000,
    "year": 31536000,
  },

// ================= TIME SMALL =================
// Base: second
  "time_small": {
    "ms": 0.001,
    "s": 1,
    "min": 60,
    "h": 3600,
    "day": 86400,
  },


// ================= VISCOSITY DYNAMIC =================
// Base: Pa·s
  "viscosity_dynamic": {
    "cP": 0.001,
    "P": 0.1,
    "Pa·s": 1,
    "lb/(ft·s)": 1.48816394357,
  },

// ================= VISCOSITY KINEMATIC =================
// Base: St
  "viscosity_kinematic": {
    "St": 1,
    "cSt": 0.01,
    "m²/s": 10000,
    "ft²/s": 929.0304,
  },


// ================= POWER =================
// Base: W
  "power": {
    "bhp": 9810.657,        // 🔥 added (boiler horsepower)
    "BTU/h": 0.29307107,
    "BTU/s": 1055.056,      // 🔥 added
    "cal/h": 0.001162222,   // 🔥 added
    "ehp": 746,             // 🔥 added (approx electrical hp)
    "ft·lb/min": 0.02259697,// 🔥 added
    "ft·lb/s": 1.3558179,   // 🔥 added
    "hp": 745.699872,
    "J/s": 1,               // 🔥 added (same as W)
    "kW": 1000,
    "kcal/h": 1.162222,     // 🔥 added
    "mhp": 735.49875,       // 🔥 added (metric hp)
    "mW": 0.001,            // 🔥 added
    "MW": 1000000,
    "TR": 3516.8525,        // 🔥 added
    "W": 1,
  },

  // ================= VOLUME =================
// Base: m³ //how much
  "volume": {
    "μL": 1e-9,
    "mL": 1e-6,
    "cm³": 1e-6,
    "mm³": 1e-9,
    "L": 0.001,
    "cL": 1e-5,
    "dL": 1e-4,
    "m³": 1.0,
    "dm³": 0.001,
    "km³": 1e9,

    "in³": 0.000016387064, // Exact NIST
    "ft³": 0.028316846592, // Exact (0.3048^3)
    "yd³": 0.764554857984, // Exact (ft3 * 27)

    "gal_us": 0.003785411784, // Exact
    "gal_uk": 0.00454609,     // Exact
    "gal_us_dry": 0.00440488377086, // Exact

    "qt_us": 0.000946352946,
    "qt_uk": 0.0011365225,
    "qt_dry": 0.0011012209427,

    "pt_us": 0.000473176473,
    "pt_uk": 0.00056826125,
    "pt_dry": 0.000550610471,

    "fl_oz_us": 0.0000295735295625,
    "fl_oz_uk": 0.0000284130625,

    "tbsp_us": 0.00001478676478125,
    "tbsp_metric": 1.5e-5,
    "tsp_us": 0.00000492892159375,
    "tsp_metric": 5e-6,

    "cups": 0.0002365882365,
    "bbl": 0.158987294928, // 42 US Gallons
    "bbl_us_oil": 0.158987294928,
    "bbl_uk": 0.16365924,
    "ac·ft": 1233.48183754752 // Exact
  },


// ================= FLOW RATE – STANDARD =================
// Base: m³/s //how fast normalized gas
  "flow_standard": {
    "mmsc/d": (1e6) / 86400,     // million Sm³ per day → Sm³/s
    "scm/h": 1 / 3600,           // standard m³/hour → Sm³/s
    "scm/d": 1 / 86400,

    "Sm³/s": 1.0,
    "Sm³/min": 1/60,
    "Sm³/h": 1/3600,
    "Sm³/d": 1/86400,

    // Normal m3 are denser than Standard m3 (Ref 0C vs 15C)
    "Nm³/s": 1.05491488,
    "Nm³/min": 1.05491488 / 60,
    "Nm³/h": 1.05491488 / 3600,
    "Nm³/d": 1.05491488 / 86400,
    "MNm³/d": (1.05491488 * 1e6) / 86400,

    "scf/s": 0.028316846592,
    "scf/m": 0.028316846592 / 60,
    "scf/h": 0.028316846592 / 3600,
    "scf/d": 0.028316846592 / 86400,

    "Mscf/d": (1000 * 0.028316846592) / 86400,
    "MMscf/d": (1e6 * 0.028316846592) / 86400,
    "Bscf/y": (1e9 * 0.028316846592) / 31536000, // 365 days

    "Sl/s": 0.001,
    "Sl/m": 0.001 / 60,
    "Sl/h": 0.001 / 3600,

    "Sm³/hr @ 59°F": 1/3600,
    "MSm³/hr @ 59°F": 1e6 / 3600,
    "MSm³/d @ 59°F": 1e6 / 86400,
    "Nm³/hr @ 32°F": 1.05491488 / 3600
  },


// ================= FLOW RATE – ACTUAL =================
// Base: m³/s // how fast real gas
  "flow_actual": {
    "am³/s": 1.0,
    "am³/min": 1/60,
    "am³/h": 1/3600,
    "am³/d": 1/86400,

    "ft³/s": 0.028316846592,
    "ft³/min": 0.028316846592 / 60,
    "ft³/h": 0.028316846592 / 3600,

    "Mcf/d": (1000 * 0.028316846592) / 86400, // Fixed: Added 1000
    "MMcf/d": (1e6 * 0.028316846592) / 86400
  },


// ================= FLOW RATE – LIQUID =================
// Base: m³/s  //simple flow
  "flow_liquid": {
    "L/s": 0.001,
    "L/min": 0.001 / 60,
    "L/h": 0.001 / 3600,

    "m³/s": 1,
    "m³/h": 1 / 3600,

    "ft³/s": 0.028316846592,
    "ft³/min": 0.028316846592 / 60,
    "ft³/h": 0.028316846592 / 3600,

    "gal/min": 0.003785411784 / 60,
    "gal/h": 0.003785411784 / 3600,

    "bbl/s": 0.158987294928,
    "bbl/h": 0.158987294928 / 3600,
    "bbl/d": 0.158987294928 / 86400,
  },



  // ================= Heat Transfer =================
  "heat_transfer": {
    "W/(m²·K)": 1,
    "BTU/(h·ft²·°F)": 5.678263,
    "kcal/(h·m²·K)": 1.163,
  },

  // ================= SPEED =================
  "speed": {
    "m/s": 1,
    "m/min": 1 / 60,
    "km/h": 1 / 3.6,
    "ft/s": 0.3048,
    "ft/min": 0.3048 / 60,
    "mi/h": 0.44704,
  },


  // ================= TORQUE =================
  "torque": {
    "N·m": 1.0,
    "MN·m": 1000000.0,
    "kN·m": 1000.0,
    "mN·m": 0.001,
    "µN·m": 0.000001,

    "kgf·m": 9.80665,
    "kp·m": 9.80665,
    "cm·kgf": 0.0980665,
    "gf·cm": 0.0000980665,

    "lbf·ft": 1.3558179483,
    "ft·lb": 1.3558179483,
    "lbf·in": 0.11298482903,
    "in·lb": 0.11298482903,  // 🔥 Matches your original factor
    "ozf·ft": 0.08473862177,
    "ozf·in": 0.00706155181,

    "dyn·cm": 0.0000001
  },






};
