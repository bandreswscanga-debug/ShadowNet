import 'package:geolocator/geolocator.dart';

enum LocationError { permissionDenied, permissionPermanentlyDenied, serviceDisabled, unknown }

class LocationResult {
  final Position? position;
  final LocationError? error;

  const LocationResult._({this.position, this.error});

  factory LocationResult.success(Position p) => LocationResult._(position: p);
  factory LocationResult.failure(LocationError e) => LocationResult._(error: e);

  bool get isSuccess => position != null;
}

class LocationService {
  Future<LocationResult> getCurrentLocation() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        return LocationResult.failure(LocationError.serviceDisabled);
      }

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return LocationResult.failure(LocationError.permissionDenied);
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return LocationResult.failure(LocationError.permissionPermanentlyDenied);
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      return LocationResult.success(position);
    } catch (_) {
      return LocationResult.failure(LocationError.unknown);
    }
  }

  /// Distancia en metros entre dos coordenadas
  double distanceTo({
    required double fromLat,
    required double fromLng,
    required double toLat,
    required double toLng,
  }) {
    return Geolocator.distanceBetween(fromLat, fromLng, toLat, toLng);
  }
}