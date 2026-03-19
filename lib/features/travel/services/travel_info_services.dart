import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:texi_passenger/core/lang/extension_lang.dart';
import 'package:texi_passenger/core/providers/socket_provider.dart';
import 'package:texi_passenger/core/router/app_router.dart';
import 'package:texi_passenger/features/travel/presentation/providers/driver_location_provider.dart';
import 'package:texi_passenger/features/travel/presentation/providers/trip_status_provider.dart';

class TravelInfoServices {
  Future<void> initSocket(WidgetRef ref) async {
    await ref.read(socketProvider.future);
  }

  void acceptedTrip(WidgetRef ref) {
    final socket = ref.read(socketProvider).value;
    socket?.onMessage('trip:accepted', (data) {
      AppRouter().router.go(AppRouter.travelInfoPage);
    });
  }

  void statusTrip(WidgetRef ref) {
    final socket = ref.read(socketProvider).value;
    final tripStatusNotifier = ref.read(tripStatusProvider.notifier);
    final driverLocationNotifier = ref.read(driverLocationProvider.notifier);

    socket?.onMessage('trip:status', (data) {
      if (data != null && data is Map) {
        final status = data['status'];
        String displayText = '';
        if (status == 'arrived') {
          displayText = driverArrived.i18n;
        } else if (status == 'started') {
          displayText = tripInProgress.i18n;
        } else if (status == 'completed') {
          displayText = tripCompleted.i18n;
          AppRouter().router.go(AppRouter.homePage);
          tripStatusNotifier.reset();
          driverLocationNotifier.reset();
          socket.offMessage('trip:status');
          socket.offMessage('trip:driver_location');
          socket.offMessage('trip:accepted');
          return;
        } else if (status == 'cancelled' || status == 'expired') {
          final reason = data['reason'];
          displayText = reason != null
              ? '${tripCancelled.i18n}: $reason'
              : tripCancelled.i18n;
          AppRouter().router.go(AppRouter.homePage);
          tripStatusNotifier.reset();
          driverLocationNotifier.reset();
          socket.offMessage('trip:status');
          socket.offMessage('trip:driver_location');
          socket.offMessage('trip:accepted');
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
      }
    });
  }
}
