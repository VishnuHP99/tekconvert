import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UISound {

  // Separate players so different sounds don't interrupt each other
  static final AudioPlayer _tapPlayer =
  AudioPlayer()..setReleaseMode(ReleaseMode.stop);

  static final AudioPlayer _keyboardPlayer =
  AudioPlayer()..setReleaseMode(ReleaseMode.stop);

  static final AudioPlayer _wheelPlayer =
  AudioPlayer()..setReleaseMode(ReleaseMode.stop);

  static Future<bool> _enabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("ui_sound") ?? true; // default ON
  }

  // ───────────────────────── TAP
  static Future<void> tap() async {
    if (!await _enabled()) return;

    await _tapPlayer.stop(); // prevent overlapping
    await _tapPlayer.play(
      AssetSource('sounds/tap.mp3'),
      volume: 0.5,
    );
  }

  // ───────────────────────── KEYPAD
  static Future<void> keyboard() async {
    if (!await _enabled()) return;

    await _keyboardPlayer.stop(); // prevent stacking
    await _keyboardPlayer.play(
      AssetSource('sounds/keyboard.mp3'),
      volume: 0.5,
    );
  }

  // ───────────────────────── WHEEL (throttled)
  static int _lastWheel = 0;

  static Future<void> wheel() async {
    final now = DateTime.now().millisecondsSinceEpoch;

    // limit to one sound every 60ms
    if (now - _lastWheel < 60) return;
    _lastWheel = now;

    if (!await _enabled()) return;

    await _wheelPlayer.stop();
    await _wheelPlayer.play(
      AssetSource('sounds/wheel.mp3'),
      volume: 0.4,
    );
  }
}