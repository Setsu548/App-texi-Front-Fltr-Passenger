import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:texi_passenger/features/home/domain/repo/map_repository.dart';
import 'package:texi_passenger/features/home/services/maps_services.dart';

class MapRepositoryImp implements MapRepository {
  @override
  Future<String?> getAddressFromPosition(Position position) async {
    return await MapsServices.getAddressFromPosition(position);
  }

  @override
  Future<Position> getCurrentPosition() async {
    return await MapsServices.getCurrentPosition();
  }

  @override
  Future<List<LatLng>> getRoutePolyline(
    LatLng origin,
    LatLng destination,
  ) async {
    final PolylinePoints polylinePoints = PolylinePoints(
      apiKey: dotenv.env['MAP_API_KEY']!,
    );
    try {
      RoutesApiRequest request = RoutesApiRequest(
        origin: PointLatLng(origin.latitude, origin.longitude),
        destination: PointLatLng(destination.latitude, destination.longitude),
      );
      RoutesApiResponse response = await polylinePoints
          .getRouteBetweenCoordinatesV2(request: request);
      if (response.routes.isNotEmpty) {
        Route route = response.routes.first;
        List<PointLatLng> points = route.polylinePoints ?? [];
        final latLngPoints = points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();
        return latLngPoints;
      } else {
        throw Exception(response.errorMessage);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
