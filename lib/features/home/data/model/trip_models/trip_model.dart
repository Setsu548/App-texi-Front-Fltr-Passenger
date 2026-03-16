import 'package:texi_passenger/features/home/data/model/travel_request_model.dart';
import 'package:texi_passenger/features/home/domain/entities/trip_entities/trip_entity.dart';

class TripModel {
  final TravelPositionModel origin;
  final TravelPositionModel destination;
  final String cityId;
  final String serviceTypeId;
  final double estimatedPrice;

  TripModel({
    required this.origin,
    required this.destination,
    required this.cityId,
    required this.serviceTypeId,
    required this.estimatedPrice,
  });

  factory TripModel.fromEntity(TripEntity entity) {
    return TripModel(
      origin: TravelPositionModel.fromEntity(entity.origin),
      destination: TravelPositionModel.fromEntity(entity.destination),
      cityId: entity.cityId,
      serviceTypeId: entity.serviceTypeId,
      estimatedPrice: entity.estimatedPrice,
    );
  }

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      origin: TravelPositionModel.fromJson(json['origin']),
      destination: TravelPositionModel.fromJson(json['destination']),
      cityId: json['cityId'],
      serviceTypeId: json['serviceTypeId'],
      estimatedPrice: (json['estimatedPrice'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'origin': origin.toJson(),
      'destination': destination.toJson(),
      'cityId': cityId,
      'serviceTypeId': serviceTypeId,
      'estimatedPrice': estimatedPrice,
    };
  }

  TripEntity toEntity() {
    return TripEntity(
      origin: origin.toEntity(),
      destination: destination.toEntity(),
      cityId: cityId,
      serviceTypeId: serviceTypeId,
      estimatedPrice: estimatedPrice,
    );
  }
}