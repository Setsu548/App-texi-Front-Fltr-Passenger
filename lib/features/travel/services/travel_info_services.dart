import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:texi_passenger/core/lang/extension_lang.dart';
import 'package:texi_passenger/core/providers/socket_provider.dart';
import 'package:texi_passenger/core/router/app_router.dart';
import 'package:texi_passenger/features/travel/presentation/providers/trip_status_provider.dart';

class TravelInfoServices {
  void statusTrip(WidgetRef ref) async {
    final socket = await ref.read(socketProvider.future);
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
          ref.invalidate(tripStatusProvider);
        } else if (status == 'cancelled' || status == 'expired') {
          final reason = data['reason'];
          displayText = reason != null
              ? '${tripCancelled.i18n}: $reason'
              : tripCancelled.i18n;
        } else {
          displayText = status?.toString() ?? unknownStatus.i18n;
        }

        ref.read(tripStatusProvider.notifier).setStatus(displayText);
      }
    });
  }
}
