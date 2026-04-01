// ================= LENGTH & GEOMETRY =================

final Map<String, List<Map<String, String>>> unitDefinitions = {

  // ---------- LENGTH ----------
  "length": [
    {"s": "Å", "f": "angstrom"},        // 🔥 added
    {"s": "au", "f": "astronomical unit"}, // 🔥 added
    {"s": "cm", "f": "centimeter"},
    {"s": "dm", "f": "decimeter"},      // 🔥 added
    {"s": "ft", "f": "foot"},
    {"s": "fathom", "f": "fathom"},     // 🔥 added
    {"s": "fur", "f": "furlong"},       // 🔥 added
    {"s": "in", "f": "inch"},
    {"s": "km", "f": "kilometer"},
    {"s": "league", "f": "league"},     // 🔥 added
    {"s": "ly", "f": "light year"},     // 🔥 added
    {"s": "m", "f": "meter"},
    {"s": "mi", "f": "mile"},
    {"s": "mil", "f": "mils"},           // 🔥 added
    {"s": "mm", "f": "millimeter"},
    {"s": "μm", "f": "micrometer"},     // 🔥 added
    {"s": "nmi", "f": "nautical mile"}, // 🔥 added
    {"s": "pc", "f": "parsec"},         // 🔥 added
    {"s": "rod", "f": "rod"},           // 🔥 added
    {"s": "yd", "f": "yard"},
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
    {"s": "J", "f": "Joules (J)"},
    {"s": "kJ", "f": "Kilojoules (kJ)"},
    {"s": "MJ", "f": "Megajoules (MJ)"},
    {"s": "Gj", "f": "Gigajoules (Gj)"},
    {"s": "cal", "f": "Calories (cal)"},
    {"s": "kcal", "f": "Kilocalories (kcal)"},
    {"s": "eV", "f": "Electron volts (eV)"},
    {"s": "BTU", "f": "British thermal units (BTU)"},
    {"s": "kWh", "f": "Kilowatt hours (kWh)"},
    {"s": "Ws", "f": "Watt seconds (Ws)"},
    {"s": "Nm", "f": "Newton meters (Nm)"},
    {"s": "th", "f": "Thermie (th)"},
    {"s": "quad", "f": "Quads"},
    {"s": "thm", "f": "Therms"},
    {"s": "ft·lb", "f": "Foot pounds"}
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

// ---------- PRESSURE (ALL MERGED) ----------
  "pressure": [
    {"s":"at", "f":"technical atmosphere"},
    {"s":"atm", "f":"standard atmosphere"},
    {"s":"atm (A)", "f":"atmosphere absolute"},
    {"s":"atm (G)", "f":"atmosphere gauge"},
    {"s":"bar", "f":"bar"},
    {"s":"bar(A)", "f":"bar absolute"},
    {"s":"bar(G)", "f":"bar gauge"},
    {"s":"cm H₂O", "f":"centimeter of water (4°C)"},
    {"s":"cmHg", "f":"centimeter of mercury (0°C)"},
    {"s":"ft H₂O", "f":"foot of water (4°C)"},
    {"s":"hPa", "f":"hectopascal"},
    {"s":"in H₂O", "f":"inch of water (4°C)"},
    {"s":"inHg", "f":"inch of mercury (0°C)"},
    {"s":"kg/cm² (A)", "f":"kg-force per cm² absolute"},
    {"s":"kgf/cm²", "f":"kilogram-force per cm²"},
    {"s":"kgf/m²", "f":"kilogram-force per m²"},
    {"s":"kPa", "f":"kilopascal"},
    {"s":"kPa (A)", "f":"kilopascal absolute"},
    {"s":"kPa (G)", "f":"kilopascal gauge"},
    {"s":"ksi", "f":"kilopound per square inch"},
    {"s":"m H₂O", "f":"meter of water (4°C)"},
    {"s":"mbar", "f":"millibar"},
    {"s":"mmHg", "f":"millimeter of mercury (0°C)"},
    {"s":"MPa", "f":"megapascal"},
    {"s":"MPa (A)", "f":"megapascal absolute"},
    {"s":"MPa (G)", "f":"megapascal gauge"},
    {"s":"N/m²", "f":"newton per square meter"},
    {"s":"Pa", "f":"pascal"},
    {"s":"Pa (A)", "f":"pascal absolute"},
    {"s":"psf", "f":"pound per square foot"},
    {"s":"psi", "f":"pound per square inch"},
    {"s":"psia", "f":"pound per square inch absolute"},
    {"s":"psig", "f":"pound per square inch gauge"},
    {"s":"torr", "f":"torr"},
  ],

  //Differential Pressure
  "differential_pressure": [
    {"s":"Pa (Δ)", "f":"pascal differential"},
    {"s":"N/m² (Δ)", "f":"newton per square meter differential"},
    {"s":"hPa (Δ)", "f":"hectopascal differential"},
    {"s":"kPa (Δ)", "f":"kilopascal differential"},
    {"s":"MPa (Δ)", "f":"megapascal differential"},

    {"s":"bar (Δ)", "f":"bar differential"},
    {"s":"mbar (Δ)", "f":"millibar differential"},
    {"s":"atm (Δ)", "f":"standard atmosphere differential"},
    {"s":"at (Δ)", "f":"technical atmosphere differential"},

    {"s":"psi (Δ)", "f":"pound per square inch differential"},
    {"s":"psf (Δ)", "f":"pound per square foot differential"},
    {"s":"ksi (Δ)", "f":"kilopound per square inch differential"},

    {"s":"mmHg (Δ)", "f":"millimeter of mercury differential"},
    {"s":"cmHg (Δ)", "f":"centimeter of mercury differential"},
    {"s":"inHg (Δ)", "f":"inch of mercury differential"},
    {"s":"torr (Δ)", "f":"torr differential"},

    {"s":"mm H₂O (Δ)", "f":"millimeter of water differential"},
    {"s":"cm H₂O (Δ)", "f":"centimeter of water differential"},
    {"s":"m H₂O (Δ)", "f":"meter of water differential"},
    {"s":"in H₂O (Δ)", "f":"inch of water differential"},
    {"s":"ft H₂O (Δ)", "f":"foot of water differential"},

    {"s":"kgf/cm² (Δ)", "f":"kilogram-force per cm² differential"},
    {"s":"kgf/m² (Δ)", "f":"kilogram-force per m² differential"},
  ],

// ---------- FORCE ----------
  "force": [
    {"s": "N", "f": "newton"},
    {"s": "mN", "f": "millinewton"},
    {"s": "μN", "f": "micronewton"},        // 🔥 added
    {"s": "nN", "f": "nanonewton"},         // 🔥 added
    {"s": "kN", "f": "kilonewton"},         // 🔥 added
    {"s": "MN", "f": "meganewton"},         // 🔥 added
    {"s": "GN", "f": "giganewton"},         // 🔥 added

    {"s": "dyn", "f": "dyne"},
    {"s": "kgf", "f": "kilogram-force"},
    {"s": "gf", "f": "gram-force"},         // 🔥 added
    {"s": "mgf", "f": "milligram-force"},   // 🔥 added
    {"s": "lbf", "f": "pound-force"},
    {"s": "ozf", "f": "ounce-force"},       // 🔥 added

    {"s": "kip", "f": "kip"},               // 🔥 added
    {"s": "pdl", "f": "poundal"},           // 🔥 added

    {"s": "tf", "f": "ton-force"},          // 🔥 added (metric)
    {"s": "stnf", "f": "short ton-force"},  // 🔥 added
    {"s": "ltnf", "f": "long ton-force"},   // 🔥 added

    {"s": "sn", "f": "sthène"},             // 🔥 added
    {"s": "kp", "f": "kilopond"},           // 🔥 added (same as kgf)
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
    {"s": "bhp", "f": "boiler horsepower"},          // 🔥 added
    {"s": "BTU/h", "f": "BTU per hour"},
    {"s": "BTU/s", "f": "BTU per second"},           // 🔥 added
    {"s": "cal/h", "f": "calories per hour"},        // 🔥 added
    {"s": "ehp", "f": "electrical horsepower"},      // 🔥 added
    {"s": "ft·lb/min", "f": "foot-pound per minute"},// 🔥 added
    {"s": "ft·lb/s", "f": "foot-pound per second"},  // 🔥 added
    {"s": "hp", "f": "horsepower"},
    {"s": "J/s", "f": "joule per second"},           // 🔥 added (same as W)
    {"s": "kW", "f": "kilowatt"},
    {"s": "kcal/h", "f": "kilocalories per hour"},   // 🔥 added
    {"s": "mhp", "f": "metric horsepower"},          // 🔥 added
    {"s": "mW", "f": "milliwatt"},                  // 🔥 added
    {"s": "MW", "f": "megawatt"},
    {"s": "TR", "f": "ton of refrigeration"},        // 🔥 added
    {"s": "W", "f": "watt"},
  ],

  // ================= VOLUME =================

// ---------- VOLUME ----------
  "volume": [
    {"s": "mL", "f": "milliliter"},
    {"s": "μL", "f": "microliter"},                 // 🔥 added
    {"s": "cm³", "f": "cubic centimeter"},
    {"s": "mm³", "f": "cubic millimeter"},          // 🔥 added
    {"s": "L", "f": "liter"},
    {"s": "cL", "f": "centiliter"},                 // 🔥 added
    {"s": "dL", "f": "deciliter"},                  // 🔥 added
    {"s": "m³", "f": "cubic meter"},
    {"s": "dm³", "f": "cubic decimeter"},           // 🔥 added
    {"s": "km³", "f": "cubic kilometer"},           // 🔥 added

    {"s": "in³", "f": "cubic inch"},
    {"s": "ft³", "f": "cubic foot"},
    {"s": "yd³", "f": "cubic yard"},                // 🔥 added

    {"s": "gal_us", "f": "gallon (US)"},
    {"s": "gal_uk", "f": "gallon (UK)"},
    {"s": "gal_us_dry", "f": "gallon (US dry)"},    // 🔥 added

    {"s": "qt_us", "f": "quart (US liquid)"},       // 🔥 added
    {"s": "qt_uk", "f": "quart (UK)"},              // 🔥 added
    {"s": "qt_dry", "f": "quart (US dry)"},         // 🔥 added

    {"s": "pt_us", "f": "pint (US liquid)"},        // 🔥 added
    {"s": "pt_uk", "f": "pint (UK)"},               // 🔥 added
    {"s": "pt_dry", "f": "pint (US dry)"},          // 🔥 added

    {"s": "fl_oz_us", "f": "fluid ounce (US)"},     // 🔥 added
    {"s": "fl_oz_uk", "f": "fluid ounce (UK)"},     // 🔥 added

    {"s": "tbsp_us", "f": "tablespoon (US)"},       // 🔥 added
    {"s": "tbsp_metric", "f": "tablespoon (metric)"},// 🔥 added
    {"s": "tsp_us", "f": "teaspoon (US)"},          // 🔥 added
    {"s": "tsp_metric", "f": "teaspoon (metric)"},  // 🔥 added

    {"s": "cups", "f": "cups"},                     // 🔥 added

    {"s": "bbl", "f": "barrel"},
    {"s": "bbl_us_oil", "f": "barrel (US Oil)"},
    {"s": "bbl_uk", "f": "barrel (UK)"},            // 🔥 added

    {"s": "ac·ft", "f": "acre foot"},               // 🔥 added
  ],


// ---------- FLOW RATE – STANDARD ----------
  "flow_standard": [
    {"s": "mmscm/d", "f": "million std cubic meter/day"},
    {"s": "scm/h", "f": "standard cubic meter/hour"},
    {"s": "scm/d", "f": "standard cubic meter per day"},
    {"s": "Sm³/s", "f": "standard m³/s"},
    {"s": "Sm³/min", "f": "standard m³/min"},     // 🔥 added
    {"s": "Sm³/h", "f": "standard m³/h"},         // 🔥 added
    {"s": "Sm³/d", "f": "standard m³/day"},       // 🔥 added

    {"s": "Nm³/s", "f": "normal m³/s"},
    {"s": "Nm³/min", "f": "normal m³/min"},
    {"s": "Nm³/h", "f": "normal m³/h"},
    {"s": "Nm³/d", "f": "normal m³/day"},
    {"s": "MNm³/d", "f": "million Nm³/day"},

    {"s": "scf/s", "f": "standard cubic ft/s"},        // 🔥 added
    {"s": "scf/m", "f": "standard cubic ft/min"},
    {"s": "scf/h", "f": "standard cubic ft/h"},
    {"s": "scf/d", "f": "standard cubic ft/day"},      // 🔥 added

    {"s": "Mscf/d", "f": "thousand scf/day"},
    {"s": "MMscf/d", "f": "million scf/day"},
    {"s": "Bscf/y", "f": "billion scf/year"},

    {"s": "Sl/s", "f": "standard liter/s"},            // 🔥 added
    {"s": "Sl/m", "f": "standard liter/min"},
    {"s": "Sl/h", "f": "standard liter/h"},

    {"s": "Sm³/hr @ 59°F", "f": "std m³/hr @ 15°C"},     // 🔥 moved
    {"s": "MSm³/hr @ 59°F", "f": "million std m³/hr"},  // 🔥 moved
    {"s": "MSm³/d @ 59°F", "f": "million std m³/day"},  // 🔥 moved
    {"s": "Nm³/hr @ 32°F", "f": "normal m³/hr @ 0°C"}, // 🔥 moved

  ],


// ---------- FLOW RATE – ACTUAL ----------
  "flow_actual": [
    {"s": "am³/s", "f": "actual m³/s"},
    {"s": "am³/min", "f": "actual m³/min"},   // 🔥 added
    {"s": "am³/h", "f": "actual m³/h"},
    {"s": "am³/d", "f": "actual m³/day"},     // 🔥 added

    {"s": "ft³/s", "f": "cubic ft/s"},        // 🔥 added
    {"s": "ft³/min", "f": "cubic ft/min"},
    {"s": "ft³/h", "f": "cubic ft/h"},

    {"s": "Mcf/d", "f": "thousand ft³/day"},
    {"s": "MMcf/d", "f": "million ft³/day"},
  ],


// ----------  FLOW – LIQUID ----------
  "flow_liquid": [
    {"s": "L/s", "f": "liter/s"},
    {"s": "L/min", "f": "liter/min"},
    {"s": "L/h", "f": "liter/h"},           // 🔥 added

    {"s": "m³/s", "f": "cubic m/s"},        // 🔥 added
    {"s": "m³/h", "f": "cubic m/h"},

    {"s": "ft³/s", "f": "cubic ft/s"},      // 🔥 added
    {"s": "ft³/min", "f": "cubic ft/min"},
    {"s": "ft³/h", "f": "cubic ft/h"},

    {"s": "gal/min", "f": "gallon/min"},
    {"s": "gal/h", "f": "gallon/h"},        // 🔥 added

    {"s": "bbl/s", "f": "barrel/s"},        // 🔥 added
    {"s": "bbl/h", "f": "barrel/h"},        // 🔥 added
    {"s": "bbl/d", "f": "barrel/day"},
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
    {"s": "N·m", "f": "Newton metres"},
    {"s": "MN·m", "f": "Meganewton metres"},
    {"s": "kN·m", "f": "Kilonewton metres"},
    {"s": "mN·m", "f": "Millinewton metres"},
    {"s": "µN·m", "f": "Micronewton metres"},
    {"s": "kgf·m", "f": "Kilogram-force metres"},
    {"s": "cm·kgf", "f": "Centimetres kilogram-force"},
    {"s": "gf·cm", "f": "Gram-force centimetres"},
    {"s": "lbf·ft", "f": "Pound-force feet"},
    {"s": "lbf·in", "f": "Pound-force inches"},
    {"s": "ozf·ft", "f": "Ounce-force feet"},
    {"s": "ozf·in", "f": "Ounce-force inches"},
    {"s": "ft·lb", "f": "Foot-pound force"},
    {"s": "in·lb", "f": "Inch-pound force"},  // 🔥 Added back
    {"s": "kp·m", "f": "Kilopond metres"},
    {"s": "dyn·cm", "f": "Dyne centimetres"}
  ],







};
