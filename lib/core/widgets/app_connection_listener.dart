import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:texi_passenger/core/providers/internet_service_provider.dart';

class AppConnectionListener extends ConsumerStatefulWidget {
  final Widget child;

  const AppConnectionListener({super.key, required this.child});

  @override
  ConsumerState<AppConnectionListener> createState() =>
      _AppConnectionListenerState();
}

class _AppConnectionListenerState extends ConsumerState<AppConnectionListener> {
  @override
  Widget build(BuildContext context) {
    ref.listen(connectionStatusProvider, (previous, next) {
      next.whenData((status) {
        final router = ref.read(routerProvider);
        ref.read(connectionControllerProvider).handleConnection(status, router);
      });
    });

    return widget.child;
  }
}
