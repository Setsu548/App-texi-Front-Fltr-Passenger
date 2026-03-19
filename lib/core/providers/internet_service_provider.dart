import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:texi_passenger/core/router/app_router.dart';
import 'package:texi_passenger/core/utils/connection_controller.dart';
import 'package:texi_passenger/core/utils/internet_service.dart';

final internetServiceProvider = Provider<InternetService>((ref) {
  final internetService = InternetService();
  ref.onDispose(() {
    internetService.dispose();
  });
  return internetService;
});

final connectionStatusProvider = StreamProvider<ConnectionStatus>((ref) {
  final internetService = ref.watch(internetServiceProvider);
  return internetService.stream;
});

final connectionControllerProvider =
    Provider((ref) => ConnectionController());

final routerProvider = Provider((ref) => AppRouter().router);
