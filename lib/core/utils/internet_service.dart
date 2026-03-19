import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

enum ConnectionStatus { online, offline, checking }

class InternetService with WidgetsBindingObserver {
  final _controller = StreamController<ConnectionStatus>.broadcast();

  Stream<ConnectionStatus> get stream => _controller.stream;

  late final StreamSubscription _connectivitySub;

  InternetService() {
    _connectivitySub = Connectivity().onConnectivityChanged.listen(
      (_) => _checkInternet(),
    );

    _checkInternet();
  }

  Future<void> _checkInternet() async {
    _controller.add(ConnectionStatus.checking);

    final hasInternet = await InternetConnection().hasInternetAccess;

    if (hasInternet) {
      _controller.add(ConnectionStatus.online);
    } else {
      _controller.add(ConnectionStatus.offline);
    }
  }

  Future<bool> checkNow() async {
    return await InternetConnection().hasInternetAccess;
  }

  void dispose() {
    _connectivitySub.cancel();
    _controller.close();
  }
}
