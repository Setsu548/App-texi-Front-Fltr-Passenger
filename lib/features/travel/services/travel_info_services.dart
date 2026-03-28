import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:texi_passenger/core/lang/extension_lang.dart';
import 'package:texi_passenger/core/providers/socket_provider.dart';
import 'package:texi_passenger/core/router/app_router.dart';
import 'package:texi_passenger/features/home/presentation/providers/home_provider.dart';
import 'package:texi_passenger/features/travel/data/models/driver_info_model.dart';
import 'package:texi_passenger/features/travel/presentation/providers/driver_information_provider.dart';
import 'package:texi_passenger/features/travel/presentation/providers/driver_location_provider.dart';
import 'package:texi_passenger/features/travel/presentation/providers/rate_providers.dart';
import 'package:texi_passenger/features/travel/presentation/providers/route_polyline_provider.dart';
import 'package:texi_passenger/features/travel/presentation/providers/trip_status_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TravelInfoServices {
  Future<void> initSocket(WidgetRef ref) async {
    await ref.read(socketProvider.future);
  }

  void acceptedTrip(WidgetRef ref) {
    final socket = ref.read(socketProvider).value;
    final driverInfoNotifier = ref.read(driverInformationProvider.notifier);

    socket?.onMessage('trip:accepted', (data) {
      final driverInfo = DriverInfoModel.fromJson(data);
      driverInfoNotifier.setDriverInformation(driverInfo);
      AppRouter().router.go(AppRouter.travelInfoPage);
    });
  }

  void statusTrip(WidgetRef ref) {
    final socket = ref.read(socketProvider).value;
    final tripStatusNotifier = ref.read(tripStatusProvider.notifier);
    final driverLocationNotifier = ref.read(driverLocationProvider.notifier);
    final tripAlertNotifier = ref.read(tripAlertProvider.notifier);
    final homeNotifier = ref.read(homeProvider.notifier);
    final showRateAlertNotifier = ref.read(showRateAlertProvider.notifier);

    socket?.onMessage('trip:status', (data) {
      if (data != null && data is Map) {
        final status = data['status'];
        String displayText = '';
        if (status == 'arrived') {
          HapticFeedback.heavyImpact();
          displayText = driverArrived.i18n;
          tripAlertNotifier.setAlert(true);
        } else if (status == 'started') {
          displayText = tripInProgress.i18n;
          final driverPos = ref.read(driverLocationProvider).position;
          final destination = ref.read(homeProvider).destinationPosition;
          if (driverPos != null && destination != null) {
            final repo = ref.read(mapRepositoryProvider);
            repo.getRoutePolyline(driverPos, destination).then((points) {
               ref.read(routePolylineProvider.notifier).setPolyline(points);
            });
          }
        } else if (status == 'completed') {
          displayText = tripCompleted.i18n;
          tripStatusNotifier.reset();
          driverLocationNotifier.reset();
          ref.read(routePolylineProvider.notifier).reset();
          socket.offMessage('trip:status');
          socket.offMessage('trip:driver_location');
          socket.offMessage('trip:accepted');
          homeNotifier.reset();
          showRateAlertNotifier.setShowRateAlert(true);
          AppRouter().router.go(AppRouter.homePage);
          return;
        } else if (status == 'cancelled' || status == 'expired') {
          final reason = data['reason'];
          displayText = reason != null
              ? '${tripCancelled.i18n}: $reason'
              : tripCancelled.i18n;
          AppRouter().router.go(AppRouter.homePage);
          tripStatusNotifier.reset();
          driverLocationNotifier.reset();
          ref.read(routePolylineProvider.notifier).reset();
          socket.offMessage('trip:status');
          socket.offMessage('trip:driver_location');
          socket.offMessage('trip:accepted');
          homeNotifier.reset();
          return;
        } else {
          displayText = status?.toString() ?? unknownStatus.i18n;
        }

        tripStatusNotifier.setStatus(displayText);
      }
    });
  }

  void listenDriverLocation(WidgetRef ref) {
    final socket = ref.read(socketProvider).value;
    final driverLocationNotifier = ref.read(driverLocationProvider.notifier);

    socket?.onMessage('trip:driver_location', (data) {
      if (data != null && data is Map) {
        final tripId = data['tripId']?.toString() ?? '';
        final lat = double.tryParse(data['lat'].toString()) ?? 0.0;
        final lng = double.tryParse(data['lng'].toString()) ?? 0.0;
        final bearing = double.tryParse(data['bearing'].toString()) ?? 0.0;
        final speed = double.tryParse(data['speed'].toString()) ?? 0.0;

        driverLocationNotifier.updateLocation(
          lat: lat,
          lng: lng,
          bearing: bearing,
          speed: speed,
          tripId: tripId,
        );

        final status = ref.read(tripStatusProvider);
        if (status == tripInProgress.i18n) {
          final shouldUpdate = ref.read(routePolylineProvider.notifier).shouldUpdate();
          if (shouldUpdate) {
            final destination = ref.read(homeProvider).destinationPosition;
            if (destination != null) {
              final repo = ref.read(mapRepositoryProvider);
              repo.getRoutePolyline(LatLng(lat, lng), destination).then((
                points,
              ) {
                ref.read(routePolylineProvider.notifier).setPolyline(points);
              });
            }
          }
        }
      }
    });
  }
}
