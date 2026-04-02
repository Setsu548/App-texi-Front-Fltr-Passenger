import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:texi_passenger/core/utils/position_controller.dart';
import 'package:texi_passenger/core/utils/position_services.dart';
import 'package:texi_passenger/core/utils/position_status_service.dart';

class PermissionStatusNotifier extends AsyncNotifier<LocationPermission>
    with WidgetsBindingObserver {
  @override
  FutureOr<LocationPermission> build() async {
    WidgetsBinding.instance.addObserver(this);
    ref.onDispose(() {
      WidgetsBinding.instance.removeObserver(this);
    });
    return await PositionServices().checkPermission();
  }

  Future<void> _checkPermission() async {
    state = const AsyncValue.loading();
    final permission = await PositionServices().checkPermission();
    state = AsyncValue.data(permission);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState appState) {
    if (appState == AppLifecycleState.resumed) {
      _checkPermission();
    }
  }

  Future<void> requestPermission() async {
    state = const AsyncValue.loading();
    final permission = await PositionServices().requestPermission();
    state = AsyncValue.data(permission);
  }
}

final permissionStatusProvider =
    AsyncNotifierProvider<PermissionStatusNotifier, LocationPermission>(
  PermissionStatusNotifier.new,
);

final positionStatusServiceProvider = Provider<PositionStatusService>((ref) {
  final positionStatusService = PositionStatusService();
  ref.onDispose(() {
    positionStatusService.dispose();
  });
  return positionStatusService;
});

final positionStatusProvider = StreamProvider<PositionStatus>((ref) {
  final service = ref.watch(positionStatusServiceProvider);
  return service.stream;
});

final positionControllerProvider = Provider((ref) => PositionController());

