import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:texi_passenger/features/travel/data/models/driver_info_model.dart';
import 'package:texi_passenger/features/travel/domain/entities/driver_info_entity.dart';

class DriverInformationNotifier extends Notifier<DriverInfoEntity?> {
  @override
  DriverInfoEntity? build() {
    return null;
  }

  void setDriverInformation(DriverInfoModel driverInformation) {
    state = driverInformation.toEntity();
  }

  void reset() {
    state = null;
  }
}

final driverInformationProvider = NotifierProvider<DriverInformationNotifier, DriverInfoEntity?>(
  DriverInformationNotifier.new,
);

