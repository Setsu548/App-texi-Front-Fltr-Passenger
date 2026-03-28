import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:texi_passenger/core/theme/app_theme.dart';

final routePolylineProvider =
    NotifierProvider<RoutePolylineNotifier, Set<Polyline>>(
      RoutePolylineNotifier.new,
    );

class RoutePolylineNotifier extends Notifier<Set<Polyline>> {
  DateTime? _lastUpdated;

  @override
  Set<Polyline> build() {
    return const {};
  }

  void setPolyline(List<LatLng> points) {
    _lastUpdated = DateTime.now();
    if (points.isEmpty) {
      state = const {};
      return;
    }
    final polyline = Polyline(
      polylineId: const PolylineId('driver_route'),
      points: points,
      width: 5,
      color: AppTheme.lightTheme.colorScheme.surface,
    );
    state = {polyline};
  }

  bool shouldUpdate() {
    if (state.isEmpty || _lastUpdated == null) return true;
    final now = DateTime.now();
    return now.difference(_lastUpdated!).inSeconds >= 3;
  }

  void reset() {
    state = const {};
    _lastUpdated = null;
  }
}
