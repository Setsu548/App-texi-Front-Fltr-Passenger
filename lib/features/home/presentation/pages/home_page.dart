import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:texi_passenger/core/lang/extension_lang.dart';
import 'package:texi_passenger/core/router/app_router.dart';
import 'package:texi_passenger/core/theme/styles_for_texts.dart';
import 'package:texi_passenger/features/home/presentation/providers/home_provider.dart';
import 'package:texi_passenger/features/home/presentation/widgets/address_selector.dart';
import 'package:texi_passenger/features/home/presentation/widgets/quick_action_button.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeProvider);
    final notifier = ref.read(homeProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left_outlined,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () => context.go(AppRouter.authPage),
        ),
        title: Text(
          solicitRequest.i18n,
          style: StylesForTexts(
            context: context,
          ).headerStyle().copyWith(fontSize: 19.sp),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.menu,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(
                  children: [
                    AddressSelector(
                      icon: Icons.location_on,
                      address: state.originAddress,
                      isActive: state.isSelectingOrigin,
                      onTap: () {
                        notifier.toggleOrigenSelection();
                      },
                    ),
                    SizedBox(height: 2.h),
                    AddressSelector(
                      icon: Icons.location_on,
                      address: state.destinationAddress,
                      isActive: state.isSelectingDestination,
                      onTap: () {
                        notifier.toggleDestinationSelection();
                      },
                    ),
                    SizedBox(height: 2.h),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          QuickActionButton(
                            icon: Icons.home_outlined,
                            label: 'Casa',
                            isSelected: state.selectedQuickAction == 'Casa',
                            onTap: () => notifier.selectQuickAction('Casa'),
                          ),
                          SizedBox(width: 2.w),
                          QuickActionButton(
                            icon: Icons.work_outline,
                            label: 'Oficina',
                            isSelected: state.selectedQuickAction == 'Oficina',
                            onTap: () => notifier.selectQuickAction('Oficina'),
                          ),
                          SizedBox(width: 2.w),
                          QuickActionButton(
                            icon: Icons.add,
                            label: 'Agregar',
                            isOutline: true,
                            isSelected: state.selectedQuickAction == 'Agregar',
                            onTap: () => notifier.selectQuickAction('Agregar'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Container(
                      height: 55.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.sp),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.sp),
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: state.currentPosition!,
                            zoom: 15,
                          ),
                          markers: state.markers,
                          polylines: state.polylines,
                          onTap: notifier.handleMapTap,
                          myLocationEnabled: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}


/* import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:texi_passenger/core/lang/extension_lang.dart';
import 'package:texi_passenger/core/router/app_router.dart';
import 'package:texi_passenger/core/theme/styles_for_texts.dart';
import 'package:texi_passenger/core/widgets/custom_snack_bar.dart';
import 'package:texi_passenger/features/home/services/maps_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  Position? _currentPosition;
  LatLng? _currentPositionLatLng;
  String _currentAddress = 'Obteniendo ubicación...';
  String destinationAddress = whereAreYouGoing.i18n;
  bool _showOptionsAndPrice = false;

  // New state variables for marker interactions
  bool _isSelectingOrigin = false;
  bool _isSelectingDestination = false;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  LatLng? _selectedDestinationLatLng;
  PolylinePoints polylinePoints = PolylinePoints(
    apiKey: 'AIzaSyCiPWUT7LoCjEFruA6ebXaBBRwgptjQ4lQ',
  );

  @override
  void initState() {
    super.initState();
    _loadPosition();
  }

  void _loadPosition() async {
    _currentPosition = await MapsServices.getCurrentPosition();
    _currentPositionLatLng = LatLng(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
    );
    setState(() {});

    String? address = await MapsServices.getAddressFromLatLng(
      _currentPosition!,
    );
    if (address != null && address.isNotEmpty) {
      setState(() {
        _currentAddress = address;
        // Optionally place an initial marker for the origin
        _updateOriginMarker(_currentPositionLatLng!);
      });
    } else {
      setState(() {
        _currentAddress = 'No se pudo obtener la dirección';
      });
    }
  }

  void _updateOriginMarker(LatLng position) {
    _markers.removeWhere((m) => m.markerId.value == 'origin');
    _markers.add(
      Marker(
        markerId: const MarkerId('origin'),
        position: position,
        infoWindow: const InfoWindow(title: 'Origen'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
    );
  }

  void _updateDestinationMarker(LatLng position) {
    _markers.removeWhere((m) => m.markerId.value == 'destination');
    _markers.add(
      Marker(
        markerId: const MarkerId('destination'),
        position: position,
        infoWindow: const InfoWindow(title: 'Destino'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );
  }

  Future<void> _handleMapTap(LatLng tappedPoint) async {
    if (_isSelectingOrigin) {
      setState(() {
        _currentPositionLatLng = tappedPoint;
        _updateOriginMarker(tappedPoint);
        _currentAddress = 'Actualizando origen...';
        _isSelectingOrigin = false;
      });
      // Fetch new physical address for the new origin
      Position tempPos = Position(
        longitude: tappedPoint.longitude,
        latitude: tappedPoint.latitude,
        timestamp: DateTime.now(),
        accuracy: 0.0,
        altitude: 0.0,
        heading: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0,
        altitudeAccuracy: 0.0,
        headingAccuracy: 0.0,
      );
      String? newAddress = await MapsServices.getAddressFromLatLng(tempPos);
      if (mounted) {
        setState(() {
          _currentAddress = newAddress ?? 'Dirección desconocida';
        });
      }
    } else if (_isSelectingDestination) {
      setState(() {
        _selectedDestinationLatLng = tappedPoint;
        _updateDestinationMarker(tappedPoint);
        destinationAddress = 'Actualizando destino...';
        _isSelectingDestination = false;
      });
      _getPolyline();
      // Fetch new physical address for destination
      Position tempPos = Position(
        longitude: tappedPoint.longitude,
        latitude: tappedPoint.latitude,
        timestamp: DateTime.now(),
        accuracy: 0.0,
        altitude: 0.0,
        heading: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0,
        altitudeAccuracy: 0.0,
        headingAccuracy: 0.0,
      );
      String? newAddress = await MapsServices.getAddressFromLatLng(tempPos);
      if (mounted) {
        setState(() {
          destinationAddress = newAddress ?? 'Dirección desconocida';
        });
      }
    }
  }

  Future<void> _getPolyline() async {
    if (_currentPositionLatLng == null || _selectedDestinationLatLng == null) {
      return;
    }

    RoutesApiRequest request = RoutesApiRequest(
      origin: PointLatLng(
        _currentPositionLatLng!.latitude,
        _currentPositionLatLng!.longitude,
      ),
      destination: PointLatLng(
        _selectedDestinationLatLng!.latitude,
        _selectedDestinationLatLng!.longitude,
      ),
    );

    RoutesApiResponse response = await polylinePoints
        .getRouteBetweenCoordinatesV2(request: request);

    if (response.routes.isNotEmpty) {
      Route route = response.routes.first;
      List<PointLatLng> points = route.polylinePoints ?? [];
      final latLngPoints = points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();
      setState(() {
        _polylines.clear();
        _polylines.add(
          Polyline(
            polylineId: PolylineId('main_route'),
            points: latLngPoints,
            color: Theme.of(context).primaryColor,
            geodesic: true,
          ),
        );
      });
    }
  }

  final List<VehicleOption> _vehicles = [
    VehicleOption(
      id: '1',
      name: 'Económico',
      price: 12.50,
      capacity: 4,
      waitTime: 3,
      icon: Icons.directions_car,
    ),
    VehicleOption(
      id: '2',
      name: 'Confort',
      price: 18.00,
      capacity: 4,
      waitTime: 5,
      icon: Icons.local_taxi,
    ),
    VehicleOption(
      id: '3',
      name: 'Premium XL',
      price: 25.50,
      capacity: 6,
      waitTime: 8,
      icon: Icons.airport_shuttle,
    ),
  ];

  String _selectedVehicleId = '1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left_outlined,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () => context.go(AppRouter.authPage),
        ),
        title: Text(
          'Solicitar Viaje',
          style: StylesForTexts(
            context: context,
          ).headerStyle().copyWith(fontSize: 19.sp),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.menu,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              // Space for origen
              GestureDetector(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: _isSelectingOrigin
                        ? Theme.of(context).primaryColor.withValues(alpha: 0.2)
                        : Theme.of(
                            context,
                          ).colorScheme.secondary.withValues(alpha: 0.085),
                    borderRadius: BorderRadius.circular(12),
                    border: _isSelectingOrigin
                        ? Border.all(color: Theme.of(context).primaryColor)
                        : null,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Theme.of(context).colorScheme.primary,
                        size: 20,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _currentAddress,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  setState(() {
                    _isSelectingOrigin = true;
                    _isSelectingDestination = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    customSnackBar(
                      'Toca el mapa para seleccionar tu origen',
                      context,
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              GestureDetector(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: _isSelectingDestination
                        ? Theme.of(context).primaryColor.withValues(alpha: 0.2)
                        : Theme.of(
                            context,
                          ).colorScheme.secondary.withValues(alpha: 0.015),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _isSelectingDestination
                          ? Theme.of(context).primaryColor
                          : Theme.of(
                              context,
                            ).colorScheme.secondary.withValues(alpha: 0.5),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey, size: 20),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          destinationAddress,
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  setState(() {
                    _isSelectingDestination = true;
                    _isSelectingOrigin = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    customSnackBar(
                      'Toca el mapa para seleccionar tu destino',
                      context,
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              // Botones rápidos
              Row(
                children: [
                  _buildQuickActionBtn(Icons.home_outlined, 'Casa'),
                  const SizedBox(width: 12),
                  _buildQuickActionBtn(Icons.work_outline, 'Oficina'),
                  const SizedBox(width: 12),
                  _buildQuickActionBtn(Icons.add, 'Agregar', isOutline: true),
                ],
              ),
              const SizedBox(height: 24),
              // Google Map showing current location
              Container(
                height: 48.75.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF151515),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: _currentPosition == null
                      ? const Center(child: CircularProgressIndicator())
                      : GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: _currentPositionLatLng!,
                            zoom: 15,
                          ),
                          myLocationEnabled: true,
                          myLocationButtonEnabled: true,
                          zoomControlsEnabled: false,
                          zoomGesturesEnabled: true,
                          markers: _markers,
                          polylines: _polylines,
                          onTap: _handleMapTap,
                          gestureRecognizers:
                              <Factory<OneSequenceGestureRecognizer>>{
                                Factory<OneSequenceGestureRecognizer>(
                                  () => EagerGestureRecognizer(),
                                ),
                              },
                          onMapCreated: (GoogleMapController controller) {
                            if (!_mapController.isCompleted) {
                              _mapController.complete(controller);
                            }
                          },
                        ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        decoration: BoxDecoration(
          color: const Color(0xFF1D1D1D),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFD600),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Solicitar taxi ahora',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.chevron_right, size: 24),
                ],
              ),
            ),
            const SizedBox(height: 12),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.phone_in_talk_outlined,
                size: 18,
                color: Colors.grey,
              ),
              label: const Text(
                'Llamar a un operador',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionBtn(
    IconData icon,
    String label, {
    bool isOutline = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isOutline ? Colors.transparent : const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(20),
        border: isOutline
            ? Border.all(
                color: Theme.of(
                  context,
                ).colorScheme.secondary.withValues(alpha: 0.35),
              )
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Theme.of(context).primaryColor, size: 16),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleCard(VehicleOption vehicle, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedVehicleId = vehicle.id;
        });
      },
      child: Container(
        width: 40.w,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(
            context,
          ).colorScheme.secondary.withValues(alpha: 0.095),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).primaryColor.withValues(alpha: 0.1)
                    : Theme.of(
                        context,
                      ).colorScheme.secondary.withValues(alpha: 0.075),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                vehicle.icon,
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).colorScheme.secondary,
                size: 28,
              ),
            ),
            Text(
              'Bs/ ${vehicle.price.toStringAsFixed(2)}',
              style: TextStyle(
                color: isSelected ? const Color(0xFFFFD600) : Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vehicle.name,
                    style: TextStyle(
                      color: isSelected
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).colorScheme.secondary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.person_outline,
                        color: Colors.grey,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${vehicle.capacity}  •  ${vehicle.waitTime} min. de espera',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 */