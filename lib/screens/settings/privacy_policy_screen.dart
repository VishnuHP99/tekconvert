import 'package:flutter/material.dart';
import '../../widgets/common/app_top_bar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: Column(
        children: [

          AppTopBar(
            currentIndex: -1,
            title: "Privacy Policy",
            onBack: () => Navigator.pop(context),
          ),

          Expanded(
            child: SafeArea(
              top: false,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 700),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(22, 20, 22, 40),
                    child: Text(
                      '''
Last updated: 2026

This application respects your privacy.

1. Data Collection
This app does not collect personal information unless explicitly provided.

2. Usage Data
Basic usage information may be collected to improve app functionality.

3. Third-Party Services
The app may use third-party services such as analytics or authentication providers.

4. Security
We strive to protect your information but cannot guarantee absolute security.

5. Changes
This privacy policy may be updated periodically.

If you have questions, contact support.
''',
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 14,
                        height: 1.6,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}