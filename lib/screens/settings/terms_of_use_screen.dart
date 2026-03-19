import 'package:flutter/material.dart';
import '../../widgets/common/app_top_bar.dart';

class TermsOfUseScreen extends StatelessWidget {
  const TermsOfUseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: Column(
        children: [

          /// Top bar
          AppTopBar(
            currentIndex: -1,
            title: "Terms of Use",
            onBack: () => Navigator.pop(context),
          ),

          /// Content
          Expanded(
            child: SafeArea(
              top: false, // keep top controlled by AppTopBar
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(22, 20, 22, 30),
                child: Text(
                  '''
Last updated: 2026

Welcome to this application. By downloading or using this app, you agree to the following terms and conditions.

1. Use of Application
This application is intended to provide calculation and conversion utilities. The results generated are for informational purposes only.

2. Accuracy of Results
While we strive to ensure accuracy, the application does not guarantee that all calculations or outputs will be error-free.

3. Limitation of Liability
The developers and owners of this application shall not be held responsible for any damages, losses, or decisions made based on the results provided by the app.

4. Updates
We may update or modify the application and these terms at any time without prior notice.

5. Acceptance
By continuing to use this application, you agree to comply with these terms.

If you do not agree with these terms, please discontinue use of the application.
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
        ],
      ),
    );
  }
}