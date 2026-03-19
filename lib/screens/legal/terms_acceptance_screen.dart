import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/utils/ui_sound.dart';

class TermsAcceptanceScreen extends StatefulWidget {
  const TermsAcceptanceScreen({super.key});

  @override
  State<TermsAcceptanceScreen> createState() =>
      _TermsAcceptanceScreenState();
}

class _TermsAcceptanceScreenState
    extends State<TermsAcceptanceScreen> {

  bool agreed = false;

  Future<void> acceptTerms() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("termsAccepted", true);

    if (!mounted) return;

    Navigator.pushReplacementNamed(context, "/dashboard");
  }

  void declineTerms() {
    showCupertinoDialog(
      context: context,
      builder: (_) => const CupertinoAlertDialog(
        title: Text("Terms Required"),
        content: Text(
          "You must accept the Terms of Use to use this application.",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    final bg = Theme.of(context).scaffoldBackgroundColor;
    final textPrimary =
        Theme.of(context).colorScheme.onSurface;
    final textSecondary =
    isDark ? Colors.grey.shade400 : Colors.grey;

    final cardBg = isDark
        ? const Color(0xFF1C1C1E)
        : Colors.white;

    final borderColor = isDark
        ? const Color(0xFF2C2C2E)
        : const Color(0xFFE5E5E5);

    return Scaffold(
      backgroundColor: bg,

      body: SafeArea(
        child: Column(
          children: [

            const SizedBox(height: 30),

            Text(
              "Terms of Use",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
                color: textPrimary,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "Please review and accept to continue",
              style: TextStyle(
                fontSize: 13,
                color: textSecondary,
              ),
            ),

            const SizedBox(height: 25),

            Expanded(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 22),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: cardBg,
                    border: Border.all(color: borderColor),
                    borderRadius:
                    BorderRadius.circular(14),
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      '''
Last updated: 2026

By using this application you agree to the following terms.

1. This application provides calculation and conversion tools.

2. While we strive for accuracy, results may contain errors.

3. The developers are not responsible for decisions made based on app results.

4. Features may change without notice.

5. Continued use of the application indicates acceptance of these terms.
''',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: textPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                children: [

                  Checkbox(
                    value: agreed,
                    activeColor:
                    const Color(0xFF53CBF3),
                    checkColor: Colors.white,
                    side: BorderSide(
                      color: isDark
                          ? Colors.grey.shade500
                          : Colors.grey,
                    ),
                    onChanged: (v) {
                      UISound.tap();
                      setState(() {
                        agreed = v ?? false;
                      });
                    },
                  ),

                  Expanded(
                    child: Text(
                      "I agree to the Terms of Use",
                      style: TextStyle(
                        fontSize: 13,
                        color: textPrimary,
                      ),
                    ),
                  )
                ],
              ),
            ),

            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 22),
              child: SizedBox(
                width: double.infinity,
                child: CupertinoButton(
                  color: const Color(0xFF06034E),
                  disabledColor:
                  const Color(0xFF4A88B3)
                      .withValues(alpha: 0.35),
                  borderRadius:
                  BorderRadius.circular(10),
                  onPressed: agreed
                      ? () {
                    UISound.tap();
                    acceptTerms();
                  }
                      : null,
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            CupertinoButton(
              onPressed: declineTerms,
              child: Text(
                "Decline",
                style: TextStyle(
                  color: isDark
                      ? Colors.red.shade300
                      : Colors.red,
                ),
              ),
            ),

            const SizedBox(height: 30),

          ],
        ),
      ),
    );
  }
}