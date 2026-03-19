import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final driverLocationProvider =
    NotifierProvider<DriverLocationNotifier, DriverLocationState>(
      DriverLocationNotifier.new,
    );

class DriverLocationState {
  final LatLng? position;
  final double bearing;
  final double speed;
  final String? tripId;

  const DriverLocationState({
    this.position,
    this.bearing = 0.0,
    this.speed = 0.0,
    this.tripId,
  });

  DriverLocationState copyWith({
    LatLng? position,
    double? bearing,
    double? speed,
    String? tripId,
  }) {
    return DriverLocationState(
      position: position ?? this.position,
      bearing: bearing ?? this.bearing,
      speed: speed ?? this.speed,
      tripId: tripId ?? this.tripId,
    );
  }
}

class DriverLocationNotifier extends Notifier<DriverLocationState> {
  @override
  DriverLocationState build() {
    return const DriverLocationState();
  }

  void updateLocation({
    required double lat,
    required double lng,
    required double bearing,
    required double speed,
    required String tripId,
  }) {
    state = state.copyWith(
      position: LatLng(lat, lng),
      bearing: bearing,
      speed: speed,
      tripId: tripId,
    );
  }

  void reset() {
    state = const DriverLocationState();
  }
}
