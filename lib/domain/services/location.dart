import 'package:geolocator/geolocator.dart';

abstract class LocationService {
  /// Gets the user's current device position.
  Future<Position> getCurrentPosition();

  /// Resolves a readable address for the provided coordinates.
  Future<String> getAddressFromCoordinates({
    required double latitude,
    required double longitude,
  });

  /// Formats coordinates into a simple display string.
  String formatCoordinates({
    required double latitude,
    required double longitude,
  });
}
