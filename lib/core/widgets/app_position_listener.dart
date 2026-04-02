import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:texi_passenger/core/providers/internet_service_provider.dart';
import 'package:texi_passenger/core/providers/position_status_provider.dart';

class AppPositionListener extends ConsumerStatefulWidget {
  final Widget child;

  const AppPositionListener({super.key, required this.child});

  @override
  ConsumerState<AppPositionListener> createState() =>
      _AppPositionListenerState();
}

class _AppPositionListenerState extends ConsumerState<AppPositionListener> {
  @override
  Widget build(BuildContext context) {
    ref.listen(positionStatusProvider, (previous, next) {
      next.whenData((status) {
        final router = ref.read(routerProvider);
        ref.read(positionControllerProvider).handlePositionStatus(status, router);
      });
    });

    return widget.child;
  }
}
