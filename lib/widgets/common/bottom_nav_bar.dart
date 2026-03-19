import 'dart:ui';
import 'package:flutter/material.dart';

import '../../core/utils/ui_sound.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onChanged;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(34),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
          child: Container(
            height: 72,
            decoration: BoxDecoration(
              color: const Color(0xFF06034E).withOpacity(0.92),
              borderRadius: BorderRadius.circular(34),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 25,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              children: [
                _item(Icons.home_rounded, "Home", 0),
                _item(Icons.calculate_rounded, "Calculator", 1),
                // _item(Icons.handyman_rounded, "Tools", 2),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _item(IconData icon, String label, int index) {
    final bool active = currentIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          UISound.tap();   // 🔊 tap sound
          onChanged(index);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: active
                ? Colors.white.withValues(alpha: 0.22)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 26,
                color: Colors.white,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
