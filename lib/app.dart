import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tekconvert/core/utils/theme_controller.dart';
import 'package:tekconvert/screens/dashboard/dashboard_screen.dart';
import 'package:tekconvert/screens/saved/universal_saved_screen.dart';
import 'package:tekconvert/screens/settings/settings_screen.dart';
import 'package:tekconvert/screens/splash/splash.dart';
import 'package:tekconvert/screens/legal/terms_acceptance_screen.dart';

class TekConvertApp extends StatelessWidget {
  const TekConvertApp({super.key});

  @override
  Widget build(BuildContext context) {

    final theme = context.watch<ThemeController>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TekConvert",

      themeMode: theme.mode,

      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: "Montserrat",
        useMaterial3: true,

        scaffoldBackgroundColor: const Color(0xFFF7F8FA),

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF53CBF3),
          brightness: Brightness.light,
        ),

        cardColor: Colors.white,

        dividerColor: const Color(0xFFE5E5EA),

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: "Montserrat",
        useMaterial3: true,

        scaffoldBackgroundColor: const Color(0xFF121212),

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF53CBF3),
          brightness: Brightness.dark,
        ),

        cardColor: const Color(0xFF1E1E1E),

        dividerColor: const Color(0xFF2C2C2E),

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),

      initialRoute: "/",

      routes: {
        "/": (context) => const SplashScreen(),
        "/dashboard": (context) => const DashboardScreen(),
        "/settings": (context) => const SettingsScreen(),
        "/saved": (context) => const UniversalSavedScreen(),
        "/terms": (context) => const TermsAcceptanceScreen(),
      },
    );
  }
}