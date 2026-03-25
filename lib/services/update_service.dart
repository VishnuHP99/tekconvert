import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';

class UpdateService {
  static Future<void> checkForUpdate(BuildContext context) async {
    try {
      final response = await http.get(
        Uri.parse(
          "https://raw.githubusercontent.com/VishnuHP99/tekconvert/main/version.json",
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        String currentVersion = packageInfo.version;

        String latestVersion = data['version'];
        String apkUrl = data['apk_url'];
        bool forceUpdate = data['force_update'] ?? false;
        String changelog = data['changelog'] ?? "";

        if (latestVersion.compareTo(currentVersion) > 0) {
          await _showUpdateDialog(
            context,
            apkUrl,
            forceUpdate,
            changelog,
            currentVersion,
            latestVersion,
          );
        }
      }
    } catch (e) {
      print("Update check failed: $e");
    }
  }

  static Future<void> _showUpdateDialog(
      BuildContext context,
      String apkUrl,
      bool forceUpdate,
      String changelog,
      String currentVersion,
      String latestVersion,
      ) {
    return showModalBottomSheet(
      context: context,
      isDismissible: !forceUpdate,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _PremiumUpdateSheet(
          apkUrl: apkUrl,
          forceUpdate: forceUpdate,
          changelog: changelog,
          currentVersion: currentVersion,
          latestVersion: latestVersion,
        );
      },
    );
  }
}

class _PremiumUpdateSheet extends StatefulWidget {
  final String apkUrl;
  final bool forceUpdate;
  final String changelog;
  final String currentVersion;
  final String latestVersion;

  const _PremiumUpdateSheet({
    required this.apkUrl,
    required this.forceUpdate,
    required this.changelog,
    required this.currentVersion,
    required this.latestVersion,
  });

  @override
  State<_PremiumUpdateSheet> createState() =>
      _PremiumUpdateSheetState();
}

class _PremiumUpdateSheetState extends State<_PremiumUpdateSheet>
    with SingleTickerProviderStateMixin {
  double progress = 0;
  bool downloading = false;

  Future<void> downloadAndInstall() async {
    setState(() => downloading = true);

    try {
      final dir = await getTemporaryDirectory();
      final filePath = "${dir.path}/tekconvert.apk";

      await Dio().download(
        widget.apkUrl,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            setState(() {
              progress = received / total;
            });
          }
        },
      );

      await OpenFilex.open(filePath);
    } catch (e) {
      print("Download error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      decoration: BoxDecoration(
        color: theme.cardColor.withValues(alpha: 0.98),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 25,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          /// TOP BAR
          Stack(
            children: [

              /// CENTER HANDLE
              Center(
                child: Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              /// TOP RIGHT CLOSE BUTTON
              if (!widget.forceUpdate)
                Positioned(
                  right: 0,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.05),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close, size: 18),
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 18),

          const Icon(
            Icons.system_update,
            size: 42,
            color: Color(0xFF007AFF),
          ),

          const SizedBox(height: 12),

          const Text(
            "Update Available",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 6),

          /// VERSION DISPLAY
          Text(
            "v${widget.currentVersion} → v${widget.latestVersion}",
            style: TextStyle(
              fontSize: 13,
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            widget.changelog,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 22),

          /// BUTTON / PROGRESS MORPH
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: downloading
                ? Column(
              key: const ValueKey("progress"),
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: progress),
                    duration: const Duration(milliseconds: 300),
                    builder: (context, value, _) {
                      return LinearProgressIndicator(
                        value: value,
                        minHeight: 6,
                        backgroundColor:
                        Colors.grey.withValues(alpha: 0.2),
                        color: const Color(0xFF007AFF),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "${(progress * 100).toStringAsFixed(0)}%",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )
                : SizedBox(
              key: const ValueKey("button"),
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD7DCE1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                onPressed: downloadAndInstall,
                child: const Text(
                  "Download & Install",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),

          if (!widget.forceUpdate && !downloading)
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Not Now",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
        ],
      ),
    );
  }
}