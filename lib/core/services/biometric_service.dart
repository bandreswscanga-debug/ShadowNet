import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:flutter/services.dart';

enum BiometricAuthResult { success, failed, notAvailable, notEnrolled, lockedOut, error }

class BiometricService {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> isBiometricAvailable() async {
    try {
      final canCheck = await _auth.canCheckBiometrics;
      final isSupported = await _auth.isDeviceSupported();
      return canCheck && isSupported;
    } on PlatformException {
      return false;
    }
  }

  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } on PlatformException {
      return [];
    }
  }

  Future<BiometricAuthResult> authenticate({
    String reason = 'Autenticación requerida para continuar',
    bool biometricOnly = true,
  }) async {
    try {
      if (!await isBiometricAvailable()) {
        final biometrics = await getAvailableBiometrics();
        return biometrics.isEmpty
            ? BiometricAuthResult.notEnrolled
            : BiometricAuthResult.notAvailable;
      }

      final result = await _auth.authenticate(
        localizedReason: reason,
        options: AuthenticationOptions(
          biometricOnly: biometricOnly,
          stickyAuth: true,
          sensitiveTransaction: true,
        ),
      );

      return result ? BiometricAuthResult.success : BiometricAuthResult.failed;
    } on PlatformException catch (e) {
      return _handleException(e);
    } catch (_) {
      return BiometricAuthResult.error;
    }
  }

  Future<void> cancelAuthentication() async => _auth.stopAuthentication();

  BiometricAuthResult _handleException(PlatformException e) {
    switch (e.code) {
      case auth_error.notAvailable:     return BiometricAuthResult.notAvailable;
      case auth_error.notEnrolled:      return BiometricAuthResult.notEnrolled;
      case auth_error.lockedOut:
      case auth_error.permanentlyLockedOut: return BiometricAuthResult.lockedOut;
      default:                          return BiometricAuthResult.error;
    }
  }
}