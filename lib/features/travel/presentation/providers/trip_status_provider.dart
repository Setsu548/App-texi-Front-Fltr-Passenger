import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:texi_passenger/core/lang/extension_lang.dart';

//final tripStatusProvider = StateProvider<String>((ref) => 'El conductor va en camino');
final tripStatusProvider = NotifierProvider<TripStatusProvider, String>(
  TripStatusProvider.new,
);

class TripStatusProvider extends Notifier<String> {
  @override
  String build() {
    return driverOnRoad.i18n;
  }

  void setStatus(String status) {
    state = status;
  }

  void reset() {
    state = driverOnRoad.i18n;
  }
}
