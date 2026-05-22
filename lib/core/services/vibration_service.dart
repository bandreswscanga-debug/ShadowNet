import 'package:vibration/vibration.dart';

class VibrationService {
  Future<bool> get _hasVibrator async => await Vibration.hasVibrator() ?? false;

  Future<void> vibrateSuccess() async {
    if (!await _hasVibrator) return;
    await Vibration.vibrate(duration: 200);
  }

  Future<void> vibrateError() async {
    if (!await _hasVibrator) return;
    await Vibration.vibrate(pattern: [0, 300, 100, 300]);
  }

  Future<void> vibrateWarning() async {
    if (!await _hasVibrator) return;
    await Vibration.vibrate(pattern: [0, 100, 50, 100]);
  }

  Future<void> cancel() async => Vibration.cancel();
}