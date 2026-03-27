import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'core/utils/app_settings.dart';
import 'core/utils/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔥 ADD THESE 2 LINES (CRITICAL)
  PaintingBinding.instance.imageCache.maximumSize = 100;
  PaintingBinding.instance.imageCache.maximumSizeBytes = 20 << 20; // 20MB


  final themeController = ThemeController();
  await themeController.load();   // IMPORTANT

  await AppSettings.init();
  runApp(
    ChangeNotifierProvider(
      create: (_) => themeController,
      child: const TekConvertApp(),
    ),
  );
}