import 'package:go_router/go_router.dart';
import 'package:texi_passenger/core/router/app_router.dart';
import 'package:texi_passenger/core/utils/internet_service.dart';

class ConnectionController {
  bool _offlinePageVisible = false;

  void handleConnection(ConnectionStatus status, GoRouter router) {
    switch (status) {
      case ConnectionStatus.online:
        if (_offlinePageVisible && router.canPop()) {
          router.pop();
        }
        _offlinePageVisible = false;
        break;
      case ConnectionStatus.offline:
        if (!_offlinePageVisible) {
          _offlinePageVisible = true;
          router.push(AppRouter.offlinePage).then((_) {
            _offlinePageVisible = false;
          });
        }
        break;
      case ConnectionStatus.checking:
        break;
    }
  }
}
