import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tekconvert/screens/settings/privacy_policy_screen.dart';
import 'package:tekconvert/screens/settings/terms_of_use_screen.dart';
import '../../core/utils/theme_controller.dart';
import '../../widgets/common/app_top_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/utils/app_settings.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  String appVersion = "";
  bool soundEnabled = true;
  int decimalPlaces = AppSettings.decimalPlaces;
  bool scientificEnabled = AppSettings.scientificEnabled;

  @override
  void initState() {
    super.initState();
    loadSettings();
    loadAppVersion();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      soundEnabled = prefs.getBool("ui_sound") ?? true;
      decimalPlaces = AppSettings.decimalPlaces;
      scientificEnabled = AppSettings.scientificEnabled;
    });
  }

  Future<void> saveSound(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("ui_sound", value);
  }

  Future<void> saveDecimals(int value) async {
    await AppSettings.setDecimalPlaces(value);

    setState(() {
      decimalPlaces = value;
    });
  }

  Future<void> saveScientific(bool value) async {
    await AppSettings.setScientificEnabled(value);

    setState(() {
      scientificEnabled = value;
    });
  }

  void notifyChanged() {
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: Column(
        children: [

          AppTopBar(
            currentIndex: -1,
            title: "Settings",
            onBack: () => Navigator.pop(context,true),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [

                const SizedBox(height: 8),

                sectionTitle("Appearance"),

                settingsGroup([
                  simpleTile(
                    title: "Theme",
                    subtitle: context.watch<ThemeController>().mode.name,
                    trailing: const Icon(
                      CupertinoIcons.chevron_forward,
                      size: 18,
                      color: Colors.grey,
                    ),
                    onTap: showThemePicker,
                  ),

                  switchTile(
                    title: "Sound",
                    subtitle: "Play sound on button press",
                    value: soundEnabled,
                    onChanged: (v) {
                      setState(() => soundEnabled = v);
                      saveSound(v);
                    },
                  ),
                ]),

                sectionTitle("Formatting"),

                settingsGroup([
                  simpleTile(
                    title: "Decimal Places",
                    subtitle: "$decimalPlaces",
                    onTap: showDecimalPicker,
                  ),

                  switchTile(
                    title: "Scientific Notation",
                    subtitle: "Show results in Power of 10",
                    value: scientificEnabled,
                    onChanged: (v) {
                      setState(() => scientificEnabled = v);
                      saveScientific(v);

                    },
                  ),
                ]),

                sectionTitle("About"),

                settingsGroup([
                  simpleTile(
                    title: "Version",
                    subtitle: appVersion,
                  ),

                  simpleTile(
                    title: "Terms of Use",
                    trailing: const Icon(
                      CupertinoIcons.chevron_forward,
                      size: 18,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) => const TermsOfUseScreen(),
                        ),
                      );
                    },
                  ),

                  simpleTile(
                    title: "Privacy Policy",
                    trailing: const Icon(
                      CupertinoIcons.chevron_forward,
                      size: 18,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) => const PrivacyPolicyScreen(),
                        ),
                      );
                    },
                  ),

                  simpleTile(
                    title: "Support",
                    subtitle: "Connect with Us",
                    trailing: const Icon(
                      CupertinoIcons.chevron_forward,
                      size: 18,
                    ),
                    onTap: () async {
                      final Uri email = Uri(
                        scheme: 'mailto',
                        path: 'Vishnu.Panicker@tekdpro.com',
                        query: 'subject=Unit Converter App Support',
                      );

                      await launchUrl(email);
                    },
                  ),

                  simpleTile(
                    title: "Website",
                    subtitle: "www.tekdpro.com",
                    trailing: const Icon(
                      CupertinoIcons.chevron_forward,
                      size: 18,
                    ),
                    onTap: () async {
                      final Uri url = Uri.parse("https://tekdpro.com/");
                      await launchUrl(url,
                          mode: LaunchMode.externalApplication);
                    },
                  ),
                ]),

                SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 24),
                    child: Column(
                      children: [
                        const Text(
                          "An App Owned by",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            color: Colors.grey,
                            fontSize: 9,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SvgPicture.asset(
                          "assets/images/tekdpro_Logo.svg",
                          height: 22,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 26, bottom: 8, left: 6),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.8,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget settingsGroup(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: List.generate(children.length, (index) {
          final item = children[index];

          if (index == children.length - 1) {
            return item;
          }

          return Column(
            children: [
              item,
              const Divider(
                height: 1,
                thickness: 0.5,
                indent: 16,
              )
            ],
          );
        }),
      ),
    );
  }

  Widget simpleTile({
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  if (subtitle != null) ...[
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 13,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            trailing ?? const SizedBox(),

          ],
        ),
      ),
    );
  }

  Widget switchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  subtitle,
                  style: const TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          CupertinoSwitch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  void showDecimalPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (BuildContext context) {
        // 🔥 FIX: Added StatefulBuilder so the bottom sheet can update its own UI
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return SafeArea(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 13, // 👈 Increased to 13 (0 to 12) so it matches your clamp limit and scrolls
                itemBuilder: (_, i) {
                  return ListTile(
                    title: Text(
                      "$i",
                      style: const TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 16,
                      ),
                    ),
                    trailing: i == decimalPlaces
                        ? const Icon(
                      Icons.check,
                      color: CupertinoColors.activeBlue,
                    )
                        : null,
                    onTap: () {
                      // 1. Update the checkmark inside the bottom sheet
                      setModalState(() {
                        decimalPlaces = i;
                      });

                      // 2. Update the background screen and save to memory
                      setState(() => decimalPlaces = i);
                      saveDecimals(i);

                      // OPTIONAL UX TIP: Uncomment the line below to auto-close
                      // the bottom sheet the moment they tap a number!
                      // Navigator.pop(context);
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  void showThemePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {

        final controller = context.read<ThemeController>();
        final mode = controller.mode;

        Widget row(String text, ThemeMode m) {
          return CupertinoActionSheetAction(
            onPressed: () {
              controller.setMode(m);
              Navigator.pop(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(text),
                if (mode == m) ...[
                  const SizedBox(width: 8),
                  const Icon(
                    CupertinoIcons.check_mark,
                    size: 18,
                    color: CupertinoColors.activeBlue,
                  )
                ]
              ],
            ),
          );
        }

        return CupertinoActionSheet(
          title: const Text("Appearance"),
          actions: [
            row("Light", ThemeMode.light),
            row("Dark", ThemeMode.dark),
            row("System", ThemeMode.system),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
        );
      },
    );
  }
  Future<void> loadAppVersion() async {
    final info = await PackageInfo.fromPlatform();

    setState(() {
      appVersion = info.version; // 👈 this gives 1.0.2
    });
  }
}