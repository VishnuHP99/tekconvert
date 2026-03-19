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
        );
      },
    );
  }
}

class _PremiumUpdateSheet extends StatefulWidget {
  final String apkUrl;
  final bool forceUpdate;
  final String changelog;

  const _PremiumUpdateSheet({
    required this.apkUrl,
    required this.forceUpdate,
    required this.changelog,
  });

  @override
  State<_PremiumUpdateSheet> createState() =>
      _PremiumUpdateSheetState();
}

class _PremiumUpdateSheetState extends State<_PremiumUpdateSheet> {
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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 25,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // iOS style handle
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          const SizedBox(height: 20),

          const Icon(
            Icons.system_update,
            size: 40,
            color: Color(0xFF53CBF3),
          ),

          const SizedBox(height: 12),

          const Text(
            "Update Available",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            widget.changelog,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 20),

          if (downloading) ...[
            LinearProgressIndicator(value: progress),
            const SizedBox(height: 8),
            Text("${(progress * 100).toStringAsFixed(0)}%"),
          ] else ...[
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: downloadAndInstall,
                child: const Text("Download & Install"),
              ),
            ),
          ],

          if (!widget.forceUpdate && !downloading)
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Later"),
            ),
        ],
      ),
    );
  }
}