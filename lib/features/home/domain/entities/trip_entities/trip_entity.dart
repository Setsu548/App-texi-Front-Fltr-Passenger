import 'package:texi_passenger/features/home/domain/entities/travel_request_entity.dart';

class TripEntity {
  final TravelPositionEntity origin;
  final TravelPositionEntity destination;
  final String cityId;
  final String serviceTypeId;
  final double estimatedPrice;

  TripEntity({
    required this.origin,
    required this.destination,
    required this.cityId,
    required this.serviceTypeId,
    required this.estimatedPrice,
  });
}