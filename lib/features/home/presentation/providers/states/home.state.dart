import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeState {
  final bool isLoading;
  final LatLng? currentPosition;
  final String originAddress;
  final String destinationAddress;
  final bool isSelectingOrigin;
  final bool isSelectingDestination;
  final Set<Marker> markers;
  final Set<Polyline> polylines;
  final String selectedVehicleId;
  final String selectedQuickAction;

  HomeState({
    this.isLoading = true,
    this.currentPosition,
    this.originAddress = 'Obteniendo ubicación...',
    this.destinationAddress = '¿A dónde vas?',
    this.isSelectingOrigin = false,
    this.isSelectingDestination = false,
    this.markers = const {},
    this.polylines = const {},
    this.selectedVehicleId = '1',
    this.selectedQuickAction = '',
  });

  HomeState copyWith({
    bool? isLoading,
    LatLng? currentPosition,
    String? originAddress,
    String? destinationAddress,
    bool? isSelectingOrigin,
    bool? isSelectingDestination,
    Set<Marker>? markers,
    Set<Polyline>? polylines,
    String? selectedVehicleId,
    String? selectedQuickAction,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      currentPosition: currentPosition ?? this.currentPosition,
      originAddress: originAddress ?? this.originAddress,
      destinationAddress: destinationAddress ?? this.destinationAddress,
      isSelectingOrigin: isSelectingOrigin ?? this.isSelectingOrigin,
      isSelectingDestination:
          isSelectingDestination ?? this.isSelectingDestination,
      markers: markers ?? this.markers,
      polylines: polylines ?? this.polylines,
      selectedVehicleId: selectedVehicleId ?? this.selectedVehicleId,
      selectedQuickAction: selectedQuickAction ?? this.selectedQuickAction,
    );
  }
}
