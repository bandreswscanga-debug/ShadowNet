import 'package:flutter/material.dart';
import '../../core/services/biometric_service.dart';
import '../../core/services/vibration_service.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final BiometricService _biometric = BiometricService();
  final VibrationService _vibration = VibrationService();

  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _handleAuth() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final result = await _biometric.authenticate();

    if (!mounted) return;

    switch (result) {
      case BiometricAuthResult.success:
        await _vibration.vibrateSuccess();
        Navigator.pushReplacementNamed(context, '/terminal');
        break;

      case BiometricAuthResult.notEnrolled:
        await _vibration.vibrateError();
        setState(() => _errorMessage = 'No hay biometría registrada en el dispositivo.');
        break;

      case BiometricAuthResult.notAvailable:
        await _vibration.vibrateError();
        setState(() => _errorMessage = 'Biometría no disponible en este dispositivo.');
        break;

      case BiometricAuthResult.lockedOut:
        await _vibration.vibrateError();
        setState(() => _errorMessage = 'Demasiados intentos. Intenta más tarde.');
        break;

      case BiometricAuthResult.failed:
      case BiometricAuthResult.error:
        await _vibration.vibrateError();
        setState(() => _errorMessage = 'Autenticación fallida. Intenta de nuevo.');
        break;
    }

    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.fingerprint, size: 80),
              const SizedBox(height: 24),
              const Text(
                'Acceso Seguro',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Usa tu biometría para continuar',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              if (_errorMessage != null) ...[
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
              ],
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: _isLoading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.lock_open),
                  label: Text(_isLoading ? 'Verificando...' : 'Autenticarse'),
                  onPressed: _isLoading ? null : _handleAuth,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}