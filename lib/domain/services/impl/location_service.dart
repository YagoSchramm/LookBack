import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../location.dart';

LocationService newLocationService([GeolocatorPlatform? geolocator]) {
  return _LocationService(geolocator);
}

class _LocationService implements LocationService {
  _LocationService([GeolocatorPlatform? geolocator])
      : _geolocator = geolocator ?? GeolocatorPlatform.instance;

  final GeolocatorPlatform _geolocator;

  @override
  Future<Position> getCurrentPosition() async {
    final serviceEnabled = await _geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    LocationPermission permission = await _geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    if (permission == LocationPermission.denied) {
      throw Exception('Location permissions were denied.');
    }

    return _geolocator.getCurrentPosition();
  }

  @override
  Future<String> getAddressFromCoordinates({
    required double latitude,
    required double longitude,
  }) async {
    final placemarks = await placemarkFromCoordinates(latitude, longitude);
    if (placemarks.isEmpty) return formatCoordinates(latitude: latitude, longitude: longitude);

    final placemark = placemarks.first;
    final parts = <String?>[
      placemark.street,
      placemark.locality,
      placemark.administrativeArea,
      placemark.country,
    ].whereType<String>().where((value) => value.isNotEmpty).toList();

    return parts.isEmpty ? formatCoordinates(latitude: latitude, longitude: longitude) : parts.join(', ');
  }

  @override
  String formatCoordinates({
    required double latitude,
    required double longitude,
  }) {
    return '$latitude, $longitude';
  }
}
