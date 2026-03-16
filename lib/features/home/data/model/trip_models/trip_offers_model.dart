import 'package:texi_passenger/features/home/domain/entities/trip_entities/trip_offers_entity.dart';

class TripOffersModel {
  final String driverId;
  final double offeredPrice;
  final int etaMinutes;

  TripOffersModel({
    required this.driverId,
    required this.offeredPrice,
    required this.etaMinutes,
  });

  factory TripOffersModel.fromEntity(TripOffersEntity entity) {
    return TripOffersModel(
      driverId: entity.driverId,
      offeredPrice: entity.offeredPrice,
      etaMinutes: entity.etaMinutes,
    );
  }

  TripOffersEntity toEntity() {
    return TripOffersEntity(
      driverId: driverId,
      offeredPrice: offeredPrice,
      etaMinutes: etaMinutes,
    );
  }

  factory TripOffersModel.fromJson(Map<String, dynamic> json) {
    return TripOffersModel(
      driverId: json['driverId'],
      offeredPrice: (json['offeredPrice'] as num).toDouble(),
      etaMinutes: json['etaMinutes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'driverId': driverId,
      'offeredPrice': offeredPrice,
      'etaMinutes': etaMinutes,
    };
  }
}
