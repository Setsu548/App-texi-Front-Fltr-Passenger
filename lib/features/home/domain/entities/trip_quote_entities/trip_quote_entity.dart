import 'package:texi_passenger/features/home/domain/entities/travel_request_entity.dart';

class TripQuoteEntity {
  final TravelPositionEntity origin;
  final TravelPositionEntity destination;

  TripQuoteEntity({required this.origin, required this.destination});
}
