import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import '../dashboard/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tekconvert/services/update_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late final AnimationController _ac;
  late final Animation<double> _tagOpacity;
  late final Animation<double> _tagScale;

  late final Animation<Offset> _blueSlide;
  late final Animation<Offset> _whiteSlide;


  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    _ac = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),

    );

    _tagOpacity = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _ac, curve: Curves.easeOut));

    _tagScale = Tween(begin: 0.96, end: 1.0)
        .animate(CurvedAnimation(parent: _ac, curve: Curves.easeOutBack));

    _blueSlide = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-0.09, 0), // more left
    ).animate(
      CurvedAnimation(parent: _ac, curve: Curves.easeInOutSine),
    );

    _whiteSlide = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.09, 0), // more right
    ).animate(
      CurvedAnimation(parent: _ac, curve: Curves.easeInOutSine),
    );



    _ac.repeat(reverse: true);

    Future.delayed(const Duration(seconds: 2), () async {
      await UpdateService.checkForUpdate(context);
      await _checkTermsAndNavigate();
    });
  }

  @override
  void dispose() {
    _ac.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        // ✅ EXACT HALF GRADIENT
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.5, 1.0],
            colors: [
              Color(0xFF0F0F5F),
              Color(0xFF13135C),
              Color(0xFF007EFC),
            ],
          ),
        ),

        child: SafeArea(
          child: Center(
            child: LayoutBuilder(
              builder: (context, c) {

                final logoSize = c.maxWidth * 0.55;
                final titleSize = c.maxWidth * 0.115;
                final tagSize = c.maxWidth * 0.042;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    // LOGO
                    SizedBox(
                      width: logoSize,
                      height: logoSize,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [

                          // ⚪ WHITE ARROW (bottom)
                          SlideTransition(
                            position: _whiteSlide,
                            child: Transform.translate(
                              offset: Offset(logoSize * 0.06, logoSize * 0.10),
                              child: Image.asset(
                                "assets/images/whiteArrow.png",
                                width: logoSize * 0.85,
                                height: logoSize * 0.85,
                              ),
                            ),
                          ),

                          // 🔵 BLUE ARROW (top)
                          SlideTransition(
                            position: _blueSlide,
                            child: Transform.translate(
                              offset: Offset(-logoSize * 0.06, -logoSize * 0.10),
                              child: Image.asset(
                                "assets/images/blueArrow.png",
                                width: logoSize * 0.85,
                                height: logoSize * 0.85,
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),





                    const SizedBox(height: 20),

                    // TITLE
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        Text(
                          "Tek",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: titleSize,
                            fontWeight: FontWeight.w900, // 🔥 BOLDER
                            color: const Color(0xFF8FCEF0),
                          ),
                        ),

                        Text(
                          "Convert",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: titleSize,
                            fontWeight: FontWeight.w900, // 🔥 BOLDER
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // TAGLINE
                    FadeTransition(
                      opacity: _tagOpacity,
                      child: ScaleTransition(
                        scale: _tagScale,
                        child: Text(
                          "Quick & Accurate",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: tagSize,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _checkTermsAndNavigate() async {
    final prefs = await SharedPreferences.getInstance();
    final accepted = prefs.getBool("termsAccepted") ?? false;

    if (!mounted) return;

    if (accepted) {
      Navigator.pushReplacementNamed(context, "/dashboard");
    } else {
      Navigator.pushReplacementNamed(context, "/terms");
    }
  }
}
