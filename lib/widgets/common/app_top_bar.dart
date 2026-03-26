import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../core/utils/ui_sound.dart';
import '../../screens/saved/universal_saved_screen.dart';
import '../../screens/settings/settings_screen.dart';
import 'package:flutter/services.dart';

class AppTopBar extends StatefulWidget {
  final int currentIndex;
  final String? title;
  final VoidCallback? onBack;
  final VoidCallback? onSettingsChanged;

  const AppTopBar({
    super.key,
    required this.currentIndex,
    this.title,
    this.onBack,
    this.onSettingsChanged,
  });

  @override
  State<AppTopBar> createState() => _AppTopBarState();
}

class _AppTopBarState extends State<AppTopBar> {

  String? _currentRouteName;
  bool _isNavigating = false;

  //DateTime? _lastTapTime;


  //bool _navigating = false;

  // bool _canNavigate() {
  //   final now = DateTime.now();
  //
  //   if (_lastTapTime == null ||
  //       now.difference(_lastTapTime!) > const Duration(milliseconds: 700)) {
  //     _lastTapTime = now;
  //     return true;
  //   }
  //   return false;
  // }



  //final ValueNotifier<bool> _locked = ValueNotifier(false);



  // Future<void> _safePush(String routeName) async {
  //   if (_navigating) return;
  //
  //   setState(() => _navigating = true);
  //
  //   await Navigator.pushNamed(context, routeName);
  //
  //   if (mounted) {
  //     setState(() => _navigating = false);
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    _currentRouteName = ModalRoute.of(context)?.settings.name;
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Container(
            height: 52,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            color: Theme.of(context).cardColor,
            child: Row(
              children: [

                if (widget.title != null) ...[
                  GestureDetector(
                    onTap: () {
                      UISound.tap();
                      widget.onBack?.call();
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 18,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    widget.title!,
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ] else ...[
                  Row(
                    children: [
                      Text(
                        "TekConvert",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Image.asset(
                        "assets/app_icon/logo_TekConvert.png",
                        height: 22,
                        width: 22,
                      ),
                    ],
                  ),
                ],

                const Spacer(),

                // ================= BOOKMARK =================
                IconButton(
                  icon: const Icon(CupertinoIcons.bookmark),
                  onPressed: () async {
                    if (_currentRouteName == "saved" || _isNavigating) return;

                    _isNavigating = true;
                    UISound.tap();
                    HapticFeedback.lightImpact();

                    await Navigator.pushAndRemoveUntil(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => const UniversalSavedScreen(),
                        settings: const RouteSettings(name: "saved"),
                      ),
                          (route) => route.settings.name == "/" || route.isFirst,
                    );

                    if (mounted) _isNavigating = false;
                  },
                ),



                // ================= SETTINGS =================
                IconButton(
                  icon: const Icon(CupertinoIcons.settings),
                  onPressed: () async {
                    if (_currentRouteName == "settings" || _isNavigating) return;

                    _isNavigating = true;
                    UISound.tap();
                    HapticFeedback.lightImpact();

                    final changed = await Navigator.pushAndRemoveUntil(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => const SettingsScreen(),
                        settings: const RouteSettings(name: "settings"),
                      ),
                          (route) => route.settings.name == "/" || route.isFirst,
                    );

                    if (mounted) _isNavigating = false;

                    if (changed == true) {
                      widget.onSettingsChanged?.call();
                    }
                  },
                ),

              ],
            ),
          ),

          Divider(
            height: 1,
            thickness: 0.6,
            color: Theme.of(context).dividerColor,
          ),
        ],
      ),
    );
  }
}


