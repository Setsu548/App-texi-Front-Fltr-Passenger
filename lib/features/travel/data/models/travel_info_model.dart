import 'package:texi_passenger/features/travel/domain/entities/travel_info_entity.dart';

class TravelInfoModel {
  final String tripId;
  final int driverId;
  final String status;
  final double estimatedPrice;

  TravelInfoModel({
    required this.tripId,
    required this.driverId,
    required this.status,
    required this.estimatedPrice,
  });

  factory TravelInfoModel.fromEntity(TravelInfoEntity entity) {
    return TravelInfoModel(
      tripId: entity.tripId,
      driverId: entity.driverId,
      status: entity.status,
      estimatedPrice: entity.estimatedPrice,
    );
  }

  factory TravelInfoModel.fromJson(Map<String, dynamic> json) {
    return TravelInfoModel(
      tripId: json['tripId'],
      driverId: int.parse(json['driverId'].toString()),
      status: json['status'],
      estimatedPrice: double.parse(json['estimatedPrice'].toString()),
    );
  }
}
