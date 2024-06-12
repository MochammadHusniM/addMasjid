import 'package:geolocator/geolocator.dart';

class LocationService {
  Position? _currentPosition;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Memeriksa apakah layanan lokasi diaktifkan.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> updateCurrentLocation() async {
    try {
      _currentPosition = await _determinePosition();
      print(
          'Current Position: ${_currentPosition?.latitude}, ${_currentPosition?.longitude}');
    } catch (e) {
      print('Error: $e');
    }
  }

  Position? get currentPosition => _currentPosition;
}
