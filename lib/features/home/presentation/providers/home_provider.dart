import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:texi_passenger/core/lang/extension_lang.dart';
import 'package:texi_passenger/core/theme/app_theme.dart';
import 'package:texi_passenger/features/home/data/repo_impl/map_repository_imp.dart';
import 'package:texi_passenger/features/home/domain/repo/map_repository.dart';
import 'package:texi_passenger/features/home/presentation/providers/states/home.state.dart';

final mapRepositoryProvider = Provider<MapRepository>((ref) {
  return MapRepositoryImp();
});

final homeProvider = NotifierProvider<HomeNotifier, HomeState>(
  HomeNotifier.new,
);

class HomeNotifier extends Notifier<HomeState> {
  late final MapRepository _repository;
  LatLng? _destinationLatLng;

  @override
  HomeState build() {
    _repository = ref.read(mapRepositoryProvider);
    _init();
    return HomeState();
  }

  Future<void> _init() async {
    try {
      final position = await _repository.getCurrentPosition();
      final latLng = LatLng(position.latitude, position.longitude);
      final address = await _repository.getAddressFromPosition(position);
      final originMarker = Marker(
        markerId: const MarkerId('origin'),
        position: latLng,
        infoWindow: InfoWindow(title: origin.i18n),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      );
      state = state.copyWith(
        isLoading: false,
        currentPosition: latLng,
        originAddress: address,
        markers: {originMarker},
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        originAddress: errorGettingLocation.i18n,
      );
    }
  }

  void toggleOrigenSelection() {
    state = state.copyWith(
      isSelectingOrigin: true,
      isSelectingDestination: false,
    );
  }

  void toggleDestinationSelection() {
    state = state.copyWith(
      isSelectingOrigin: false,
      isSelectingDestination: true,
    );
  }

  void selectVehicle(String vehicleId) {
    state = state.copyWith(selectedVehicleId: vehicleId);
  }

  void selectQuickAction(String action) {
    state = state.copyWith(selectedQuickAction: action);
  }

  Future<void> handleMapTap(LatLng tappedPoint) async {
    final position = Position(
      latitude: tappedPoint.latitude,
      longitude: tappedPoint.longitude,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0,
      headingAccuracy: 0,
      altitudeAccuracy: 0,
    );
    if (state.isSelectingOrigin) {
      final address = await _repository.getAddressFromPosition(position);
      state = state.copyWith(
        currentPosition: tappedPoint,
        originAddress: address,
        isSelectingOrigin: false,
      );
      await _updateAddressAndMarker(tappedPoint, isOrigin: true);
      await _drawPolyline();
    } else if (state.isSelectingDestination) {
      final address = await _repository.getAddressFromPosition(position);
      _destinationLatLng = tappedPoint;
      state = state.copyWith(
        destinationAddress: address,
        isSelectingDestination: false,
      );

      await _updateAddressAndMarker(tappedPoint, isOrigin: false);
      await _drawPolyline();
    }
  }

  Future<void> _updateAddressAndMarker(
    LatLng latLng, {
    bool isOrigin = false,
  }) async {
    final position = Position(
      latitude: latLng.latitude,
      longitude: latLng.longitude,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0,
      headingAccuracy: 0,
      altitudeAccuracy: 0,
    );
    final newAddress = await _repository.getAddressFromPosition(position);

    final newMarker = Marker(
      markerId: MarkerId(isOrigin ? 'origin' : 'destination'),
      position: latLng,
      infoWindow: InfoWindow(title: isOrigin ? origin.i18n : destination.i18n),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        isOrigin ? BitmapDescriptor.hueGreen : BitmapDescriptor.hueRed,
      ),
    );

    final updatedMarkers =
        state.markers
            .where(
              (m) => m.mapsId.value != (isOrigin ? 'origin' : 'destination'),
            )
            .toSet()
          ..add(newMarker);

    if (isOrigin) {
      state = state.copyWith(
        originAddress: newAddress,
        markers: updatedMarkers,
        isSelectingOrigin: false,
      );
    } else {
      state = state.copyWith(
        destinationAddress: newAddress,
        markers: updatedMarkers,
        isSelectingDestination: false,
      );
    }
  }

  Future<void> _drawPolyline() async {
    if (state.currentPosition == null || _destinationLatLng == null) return;

    final points = await _repository.getRoutePolyline(
      state.currentPosition!,
      _destinationLatLng!,
    );

    if (points.isNotEmpty) {
      final polyline = Polyline(
        polylineId: const PolylineId('main_route'),
        points: points,
        width: 5,
        color: AppTheme.darkTheme.primaryColor,
      );
      state = state.copyWith(polylines: {polyline});
    }
  }
}
