import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapRepository {
  Future<Position> getCurrentPosition();
  Future<String?> getAddressFromPosition(Position position);
  Future<List<LatLng>> getRoutePolyline(LatLng origin, LatLng destination);
}