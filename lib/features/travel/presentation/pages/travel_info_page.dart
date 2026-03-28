import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:texi_passenger/core/lang/extension_lang.dart';
import 'package:texi_passenger/core/theme/styles_for_texts.dart';
import 'package:texi_passenger/core/widgets/another_elevated_button_widget.dart';
import 'package:texi_passenger/features/travel/data/models/travel_info_model.dart';
import 'package:texi_passenger/features/travel/presentation/providers/driver_information_provider.dart';
import 'package:texi_passenger/features/travel/presentation/providers/driver_location_provider.dart';
import 'package:texi_passenger/features/travel/presentation/providers/route_polyline_provider.dart';
import 'package:texi_passenger/features/travel/presentation/providers/trip_status_provider.dart';
import 'package:texi_passenger/features/travel/presentation/widgets/alert_arrive_driver.dart';
import 'package:texi_passenger/features/travel/services/travel_info_services.dart';

class TravelInfoPage extends ConsumerStatefulWidget {
  final TravelInfoModel? data;

  const TravelInfoPage({super.key, this.data});

  @override
  ConsumerState<TravelInfoPage> createState() => _TravelInfoPageState();
}

class _TravelInfoPageState extends ConsumerState<TravelInfoPage> {
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      TravelInfoServices().statusTrip(ref);
      TravelInfoServices().acceptedTrip(ref);
      TravelInfoServices().listenDriverLocation(ref);
    });
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _animateCameraToDriver(LatLng position, double bearing) {
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 16.0, bearing: bearing),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentStatusText = ref.watch(tripStatusProvider);
    final driverLocation = ref.watch(driverLocationProvider);
    final driverInformation = ref.watch(driverInformationProvider);
    final polylines = ref.watch(routePolylineProvider);

    ref.listen(tripAlertProvider, (previous, next) {
      if (next == true) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const AlertArriveDriver(),
        ).then((_) {
          ref.read(tripAlertProvider.notifier).reset();
        });
      }
    });

    // Animate camera when driver location changes
    if (driverLocation.position != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _animateCameraToDriver(
          driverLocation.position!,
          driverLocation.bearing,
        );
      });
    }

    // Build markers set
    final Set<Marker> markers = {};
    if (driverLocation.position != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('driver'),
          position: driverLocation.position!,
          rotation: driverLocation.bearing,
          anchor: const Offset(0.5, 0.5),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueAzure,
          ),
          infoWindow: const InfoWindow(title: 'Conductor'),
        ),
      );
    }
    // Initial camera position
    final initialPosition = driverLocation.position ?? const LatLng(0, 0);
    final initialZoom = driverLocation.position != null ? 16.0 : 14.0;

    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                tripInformation.i18n,
                textAlign: TextAlign.center,
                style: StylesForTexts(context: context).headerStyle(),
              ),
              SizedBox(height: 1.5.h),
              Card(
                elevation: 7.5.sp,
                shadowColor: Theme.of(context).colorScheme.primary,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 1.5.w,
                    vertical: 1.h,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 22.5.w,
                        height: 22.5.w,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(35.sp),
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 8.75.sp,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(35.sp),
                          child: Image.network(
                            driverInformation?.profilePhotoUrl ?? '',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            driverInformation?.driverName ?? '',
                            style: StylesForTexts(
                              context: context,
                            ).headerStyleSmall(),
                          ),
                          Text(
                            driverInformation?.carModel ?? '',
                            style: StylesForTexts(
                              context: context,
                            ).headerStyleSmall(),
                          ),
                          Text(
                            driverInformation?.carPlate ?? '',
                            style: StylesForTexts(
                              context: context,
                            ).headerStyleSmall(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 1.5.h),
              Text(
                currentStatusText,
                textAlign: TextAlign.center,
                style: StylesForTexts(
                  context: context,
                ).headerStyle().copyWith(fontSize: 19.75.sp),
              ),
              SizedBox(height: 1.5.h),
              Container(
                width: double.infinity,
                height: 60.h,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(15.sp),
                ),
                clipBehavior: Clip.hardEdge,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: initialPosition,
                    zoom: initialZoom,
                  ),
                  onMapCreated: _onMapCreated,
                  markers: markers,
                  polylines: polylines,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                ),
              ),
              SizedBox(height: 1.5.h),
              //AnotherElevatedButtonWidget(label: cancel.i18n),
            ],
          ),
        ),
      ),
    );
  }
}
