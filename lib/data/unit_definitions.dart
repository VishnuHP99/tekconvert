// ================= LENGTH & GEOMETRY =================

final Map<String, List<Map<String, String>>> unitDefinitions = {

  // ---------- LENGTH ----------
  "length": [
    {"s": "mm", "f": "millimeter"},
    {"s": "cm", "f": "centimeter"},
    {"s": "m", "f": "meter"},
    {"s": "km", "f": "kilometer"},
    {"s": "in", "f": "inch"},
    {"s": "ft", "f": "foot"},
    {"s": "yd", "f": "yard"},
    {"s": "mi", "f": "mile"},
  ],

  // ---------- AREA SMALL ----------
  "area_small": [
    {"s": "mm²", "f": "square millimeter"},
    {"s": "cm²", "f": "square centimeter"},
    {"s": "in²", "f": "square inch"},
    {"s": "m²", "f": "square meter"},
    {"s": "ft²", "f": "square foot"},
    {"s": "yd²", "f": "square yard"},
  ],

  // ---------- AREA LARGE ----------
  "area_large": [
    {"s": "m²", "f": "square meter"},
    {"s": "km²", "f": "square kilometer"},
    {"s": "mi²", "f": "square mile"},
    {"s": "ha", "f": "hectare"},
    {"s": "acre", "f": "acre"},
  ],

  // ---------- ACCELERATION ----------
  "acceleration": [
    {"s": "mm/s²", "f": "millimeter / second²"},
    {"s": "m/s²", "f": "meter / second²"},
    {"s": "km/s²", "f": "kilometer / second²"},
    {"s": "in/s²", "f": "inch / second²"},
    {"s": "ft/s²", "f": "foot / second²"},
    {"s": "mi/s²", "f": "mile / second²"},
    {"s": "g", "f": "standard gravity"},
  ],

  // ---------- VELOCITY ----------
  "velocity": [
    {"s": "m/s", "f": "meter / second"},
    {"s": "km/h", "f": "kilometer / hour"},
    {"s": "ft/s", "f": "foot / second"},
    {"s": "mi/h", "f": "mile / hour"},
    {"s": "knot", "f": "knot"},
  ],

// ================= MASS & DENSITY =================


  // ---------- MASS ----------
  "mass": [
    {"s": "mg", "f": "milligram"},
    {"s": "g", "f": "gram"},
    {"s": "kg", "f": "kilogram"},
    {"s": "oz", "f": "ounce"},
    {"s": "lb", "f": "pound"},
    {"s": "tonne", "f": "tonne (metric)"},
    {"s": "ton_short", "f": "ton (short)"},
    {"s": "ton_long", "f": "ton (long)"},
  ],

  // ---------- MASS RATE ----------
  "mass_rate": [
    {"s": "mg/s", "f": "milligram / second"},
    {"s": "g/s", "f": "gram / second"},
    {"s": "kg/s", "f": "kilogram / second"},
    {"s": "kg/h", "f": "kilogram / hour"},
    {"s": "t/h", "f": "tonne / hour"},
    {"s": "t/day", "f": "tonne / day"},
    {"s": "lb/s", "f": "pound / second"},
    {"s": "lb/h", "f": "pound / hour"},
  ],


// ---------- DENSITY ----------
  "density": [
    {"s": "kg/m³", "f": "kilogram / cubic meter"},
    {"s": "g/cm³", "f": "gram / cubic centimeter"},
    {"s": "g/mL", "f": "gram / milliliter"},
    {"s": "lb/ft³", "f": "pound / cubic foot"},
    {"s": "lb/in³", "f": "pound / cubic inch"},
  ],

  // ================= THERMAL & ENERGY =================

// ---------- TEMPERATURE ----------
  "temperature": [
    {"s": "°C", "f": "Celsius"},
    {"s": "K", "f": "Kelvin"},
    {"s": "°F", "f": "Fahrenheit"},
    {"s": "°R", "f": "Rankine"},
  ],

// ---------- ENERGY ----------
  "energy": [
    {"s": "J", "f": "joule"},
    {"s": "kJ", "f": "kilojoule"},
    {"s": "cal", "f": "calorie"},
    {"s": "kcal", "f": "kilocalorie"},
    {"s": "BTU", "f": "British thermal unit"},
  ],

// ---------- ENERGY RATE ----------
  "energy_rate": [
    {"s": "TJ/d", "f": "terajoule / day"},
    {"s": "PJ/y", "f": "petajoule / year"},
  ],

// ---------- HEAT CAPACITY ----------
  "heat_capacity": [
    {"s": "J/K", "f": "joule / kelvin"},
    {"s": "BTU/°F", "f": "BTU / fahrenheit"},
    {"s": "cal/°C", "f": "calorie / celsius"},
  ],

// ---------- HEATING VALUE (MASS) ----------
  "heating_mass": [
    {"s": "MJ/kg", "f": "megajoule / kilogram"},
    {"s": "BTU/kg", "f": "BTU / kilogram"},
    {"s": "BTU/lb", "f": "BTU / pound"},
    {"s": "kcal/kg", "f": "kilocalorie / kilogram"},
    {"s": "kcal/lb", "f": "kilocalorie / pound"},
  ],

// ---------- HEATING VALUE (VOLUME) ----------
  "heating_volume": [
    {"s": "MJ/m³", "f": "megajoule / cubic mtr"},
    {"s": "MJ/scf", "f": "megajoule / std cubic ft"},
    {"s": "BTU/m³", "f": "BTU / cubic mtr"},
    {"s": "BTU/scf", "f": "BTU / std cubic ft"},
    {"s": "kcal/m³", "f": "kilocalorie / cubic mtr"},
    {"s": "kcal/scf", "f": "kilocalorie / std cubic ft"},
    {"s": "BTU/lbmol", "f": "BTU / lb-mole"},
  ],

// ---------- THERMAL CONDUCTIVITY ----------
  "thermal_conductivity": [
    {"s": "W/(m·K)", "f": "watt / mtr kelvin"},
    {"s": "BTU/(h·ft·°F)", "f": "BTU / hr ft °F"},
    {"s": "BTU·in/(h·ft²·°F)", "f": "BTU inch / hr ft² °F"},
    {"s": "cal/(s·m·°C)", "f": "calorie / second mtr °C"},
  ],

  // ================= PRESSURE & FORCE =================

// ---------- PRESSURE ----------
  "pressure": [
    {"s":"Pa (A)", "f":"pascal absolute"},
    {"s":"kPa (A)", "f":"kilopascal absolute"},
    {"s":"MPa (A)", "f":"megapascal absolute"},
    {"s":"bara", "f":"bar absolute"},
    {"s":"psia", "f":"psi absolute"},
    {"s":"atm (A)", "f":"atmosphere absolute"},
    {"s":"kg/cm² (A)", "f":"kg-force per cm² absolute"},
    {"s":"kPa (G)", "f":"kilopascal gauge"},
    {"s":"MPa (G)", "f":"megapascal gauge"},
    {"s":"barg", "f":"bar gauge"},
    {"s":"psig", "f":"psi gauge"},
    {"s":"atm (G)", "f":"atmosphere gauge"},
  ],

// ---------- PRESSURE HIGH ----------
  "pressure_high": [
    {"s":"bar", "f":"bar"},
    {"s":"psi", "f":"pound per sqr inch"},
    {"s":"kPa", "f":"kilopascal"},
    {"s":"MPa", "f":"megapascal"},
    {"s":"kgf/cm²", "f":"kilogram-force per cm²"},
    {"s":"mmHg", "f":"millimeter of mercury"},
    {"s":"atm", "f":"atmosphere"},
  ],

// ---------- PRESSURE LOW ----------
  "pressure_low": [
    {"s":"m H₂O", "f":"meter of water"},
    {"s":"ft H₂O", "f":"foot of water"},
    {"s":"cmHg", "f":"centimeter of mercury"},
    {"s":"inHg", "f":"inch of mercury"},
    {"s":"in H₂O", "f":"inch of water"},
    {"s":"Pa", "f":"pascal"},
  ],

// ---------- PRESSURE DELTA ----------
  "pressure_delta": [
    {"s":"Pa", "f":"pascal"},
    {"s":"kPa", "f":"kilopascal"},
    {"s":"mbar", "f":"millibar"},
    {"s":"bar", "f":"bar"},
    {"s":"psi", "f":"psi"},
    {"s":"atm", "f":"atmosphere"},
    {"s":"kg/cm²", "f":"kg-force per cm²"},
    {"s":"m H₂O", "f":"meter of water"},
  ],

// ---------- FORCE ----------
  "force": [
    {"s":"N", "f":"newton"},
    {"s":"mN", "f":"millinewton"},
    {"s":"kgf", "f":"kilogram-force"},
    {"s":"lbf", "f":"pound-force"},
    {"s":"dyn", "f":"dyne"},
  ],

/// ---------- SURFACE TENSION ----------
  "surface_tension": [
    {"s":"N/m", "f":"newton per meter"},
    {"s":"mN/m", "f":"millinewton per meter"},
    {"s":"dyn/cm", "f":"dyne per centimeter"},
    {"s":"lbf/in", "f":"pound-force per inch"},
    {"s":"kgf/m", "f":"kilogram-force per meter"},
    {"s":"T/m", "f":"ton-force per meter"},
  ],

  // ================= FLUID RATIOS =================

// ---------- CGR ----------
  "cgr": [
    {"s": "m³/Mm³", "f": "cubic mtr /million cubic mtr"},
    {"s": "bbl/MMscf", "f": "barrel /million std cubic ft"},
  ],

// ---------- GLR ----------
  "glr": [
    {"s": "m³/m³", "f": "cubic mtr / cubic mtr"},
    {"s": "scf/bbl", "f": "std cubic ft / barrel"},
  ],

// ---------- LGR ----------
  "lgr": [
    {"s": "m³/Mm³", "f": "cubic mtr/million cubic mtr"},
    {"s": "bbl/MMscf", "f": "barrel/million std cubic ft"},
  ],

// ---------- GOR ----------
  "gor": [
    {"s": "m³/m³", "f": "cubic mtr /cubic mtr"},
    {"s": "scf/bbl", "f": "std cubic ft /barrel"},
  ],

  // ================= TIME =================

  "time_large": [
    {"s": "h", "f": "hour"},
    {"s": "day", "f": "day"},
    {"s": "month", "f": "month (30 days)"},
    {"s": "year", "f": "year (365 days)"},
  ],

  "time_small": [
    {"s": "ms", "f": "millisecond"},
    {"s": "s", "f": "second"},
    {"s": "min", "f": "minute"},
    {"s": "h", "f": "hour"},
    {"s": "day", "f": "day"},
  ],


// ================= VISCOSITY =================

  "viscosity_dynamic": [
    {"s": "cP", "f": "centipoise"},
    {"s": "P", "f": "poise"},
    {"s": "Pa·s", "f": "pascal second"},
    {"s": "lb/(ft·s)", "f": "pound / foot second"},
  ],

  "viscosity_kinematic": [
    {"s": "St", "f": "stokes"},
    {"s": "cSt", "f": "centistokes"},
    {"s": "m²/s", "f": "square meter / second"},
    {"s": "ft²/s", "f": "square foot / second"},
  ],


// ================= POWER =================

  "power": [
    {"s": "W", "f": "watt"},
    {"s": "kW", "f": "kilowatt"},
    {"s": "MW", "f": "megawatt"},
    {"s": "hp", "f": "horsepower"},
    {"s": "BTU/h", "f": "BTU per hour"},
  ],

  // ================= VOLUME =================

// ---------- VOLUME ----------
  "volume": [
    {"s": "mL", "f": "milliliter"},
    {"s": "cm³", "f": "cubic centimeter"},
    {"s": "L", "f": "liter"},
    {"s": "m³", "f": "cubic meter"},
    {"s": "in³", "f": "cubic inch"},
    {"s": "ft³", "f": "cubic foot"},
    {"s": "bbl", "f": "barrel"},
    {"s": "bbl_us_oil", "f": "barrel (US Oil)"},
    {"s": "gal_us", "f": "gallon (US)"},
    {"s": "gal_uk", "f": "gallon (UK)"},
  ],


// ---------- VOLUME RATE – STANDARD ----------
  "volume_rate_std": [
    {"s": "Sm³/s", "f": "standard m³ per second"},
    {"s": "Nm³/s", "f": "normal m³ per second"},
    {"s": "Nm³/min", "f": "normal m³ per minute"},
    {"s": "Nm³/h", "f": "normal m³ per hour"},
    {"s": "Nm³/d", "f": "normal m³ per day"},
    {"s": "MNm³/d", "f": "million Nm³ per day"},
    {"s": "SCFH", "f": "std cubic ft per hour"},
    {"s": "SCFM", "f": "std cubic ft per minute"},
    {"s": "Mscf/d", "f": "thousand scf per day"},
    {"s": "MMscf/d", "f": "million scf per day"},
    {"s": "Bscf/y", "f": "billion scf per year"},
    {"s": "SLPM", "f": "std liter per minute"},
    {"s": "SLPH", "f": "std liter per hour"},
  ],


// ---------- VOLUME RATE – ACTUAL ----------
  "volume_rate_actual": [
    {"s": "am³/s", "f": "actual m³ per second"},
    {"s": "am³/h", "f": "actual m³ per hour"},
    {"s": "Mm³/d", "f": "million m³ per day"},
    {"s": "Mcf/d", "f": "thousand cubic ft per day"},
    {"s": "MMcf/d", "f": "million cubic ft per day"},
  ],


// ---------- VOLUME RATE – LIQUID ----------
  "volume_rate_liquid": [
    {"s": "L/s", "f": "liter per second"},
    {"s": "L/min", "f": "liter per minute"},
    {"s": "m³/h", "f": "cubic mtr per hour"},
    {"s": "ft³/min", "f": "cubic ft per minute"},
    {"s": "ft³/h", "f": "cubic ft per hour"},
    {"s": "gal/min", "f": "gallon per minute (US)"},
    {"s": "bbl/d", "f": "barrel per day (US oil)"},
  ],

  // ================= HEAT TRANSER =================
  "heat_transfer": [
    {"s": "W/(m²·K)", "f": "watt / sqr mtr K"},
    {"s": "BTU/(h·ft²·°F)", "f": "BTU / hr sqr ft °F"},
    {"s": "kcal/(h·m²·K)", "f": "kilocalorie / hr sqr mtr K"},
  ],

// ================= SPEED =================
  "speed": [
    {"s": "m/s", "f": "meter per second"},
    {"s": "m/min", "f": "meter per minute"},
    {"s": "km/h", "f": "kilometer per hour"},
    {"s": "ft/s", "f": "foot per second"},
    {"s": "ft/min", "f": "foot per minute"},
    {"s": "mi/h", "f": "mile per hour"},
  ],

// ================= TORQUE =================
  "torque": [
    {"s": "N·m", "f": "newton meter"},
    {"s": "kgf·m", "f": "kilogram-force meter"},
    {"s": "ft·lb", "f": "foot pound"},
    {"s": "in·lb", "f": "inch pound"},
  ],







};
