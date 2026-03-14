import 'dart:async';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:texi_passenger/core/router/app_router.dart';

class InternetService {
  Timer? _timer;
  bool _isOfflinePageVisible = false;

  void start() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      bool hasInternet = await InternetConnection().hasInternetAccess;
      if (!hasInternet && !_isOfflinePageVisible) {
        _isOfflinePageVisible = true;
        AppRouter().router.push(AppRouter.offlinePage).then((value) {
          _isOfflinePageVisible = false;
        });
      } else if (hasInternet && _isOfflinePageVisible) {
        if (AppRouter().router.canPop()) {
          AppRouter().router.pop();
        } else {
          AppRouter().router.go(AppRouter.authPage);
        }
        _isOfflinePageVisible = false;
      }
    });
  }

  void stop() {
    _timer?.cancel();
  }
}
