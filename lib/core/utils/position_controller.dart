import 'package:go_router/go_router.dart';
import 'package:texi_passenger/core/router/app_router.dart';
import 'package:texi_passenger/core/utils/position_status_service.dart';

class PositionController {
  bool _offlinePositionPageVisible = false;

  void handlePositionStatus(PositionStatus status, GoRouter router) {
    switch (status) {
      case PositionStatus.enabled:
        if (_offlinePositionPageVisible && router.canPop()) {
          router.pop();
        }
        _offlinePositionPageVisible = false;
        break;
      case PositionStatus.disabled:
        if (!_offlinePositionPageVisible) {
          _offlinePositionPageVisible = true;
          router.push(AppRouter.offlinePositionPage).then((_) {
            _offlinePositionPageVisible = false;
          });
        }
        break;
      case PositionStatus.checking:
        break;
    }
  }
}
