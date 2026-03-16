class TravelInfoEntity {
  final String tripId;
  final int driverId;
  final String status;
  final double estimatedPrice;

  TravelInfoEntity({
    required this.tripId,
    required this.driverId,
    required this.status,
    required this.estimatedPrice,
  });
}