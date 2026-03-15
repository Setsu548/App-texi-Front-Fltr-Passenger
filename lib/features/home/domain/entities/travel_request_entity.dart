class TravelRequestEntity {
  final TravelPositionEntity origin;
  final TravelPositionEntity destination;

  TravelRequestEntity({
    required this.origin,
    required this.destination,
  });
}

class TravelPositionEntity {
  final double latitude;
  final double longitude;

  TravelPositionEntity({
    required this.latitude,
    required this.longitude,
  });
}