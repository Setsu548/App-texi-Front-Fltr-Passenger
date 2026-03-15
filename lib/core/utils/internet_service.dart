import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:texi_passenger/core/router/app_router.dart';

class InternetService with WidgetsBindingObserver {
  Timer? _timer;
  bool _isOfflinePageVisible = false;

  InternetService() {
    WidgetsBinding.instance.addObserver(this);
  }

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

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      stop();
      WidgetsBinding.instance.removeObserver(this);
    }
    super.didChangeAppLifecycleState(state);
  }
}
