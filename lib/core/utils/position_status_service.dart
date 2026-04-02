import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:texi_passenger/core/utils/position_services.dart';

enum PositionStatus { enabled, disabled, checking }

class PositionStatusService with WidgetsBindingObserver {
  final _controller = StreamController<PositionStatus>.broadcast();

  Stream<PositionStatus> get stream => _controller.stream;

  late final StreamSubscription _serviceStatusSub;

  PositionStatusService() {
    _serviceStatusSub = Geolocator.getServiceStatusStream().listen(
      (ServiceStatus status) {
        if (status == ServiceStatus.enabled) {
          _controller.add(PositionStatus.enabled);
        } else {
          _controller.add(PositionStatus.disabled);
        }
      },
    );

    _checkPositionStatus();
  }

  Future<void> _checkPositionStatus() async {
    _controller.add(PositionStatus.checking);

    final isEnabled = await PositionServices().isLocationServiceEnabled();

    if (isEnabled) {
      _controller.add(PositionStatus.enabled);
    } else {
      _controller.add(PositionStatus.disabled);
    }
  }

  Future<bool> checkNow() async {
    return await PositionServices().isLocationServiceEnabled();
  }

  void dispose() {
    _serviceStatusSub.cancel();
    _controller.close();
  }
}
