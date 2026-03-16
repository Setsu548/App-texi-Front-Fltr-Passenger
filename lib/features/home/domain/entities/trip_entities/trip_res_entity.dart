import 'package:texi_passenger/features/home/domain/entities/trip_entities/trip_offers_entity.dart';

class TripResEntity {
  final String tripId;
  final String status;
  final double estimatedPrice;
  final List<TripOffersEntity> offers;

  TripResEntity({
    required this.tripId,
    required this.status,
    required this.estimatedPrice,
    required this.offers,
  });
}
