class TravelRequestEntity {
  final TravelPosition origin;
  final TravelPosition destination;

  TravelRequestEntity({
    required this.origin,
    required this.destination,
  });
}

class TravelPosition {
  final double latitude;
  final double longitude;

  TravelPosition({
    required this.latitude,
    required this.longitude,
  });
}