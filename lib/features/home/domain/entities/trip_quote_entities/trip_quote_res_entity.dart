class TripQuoteResEntity {
  final CityQuoteResEntity city;
  final double distanceKm;
  final int durationMinutes;
  final List<ServiceOptionsResEntity> options;

  TripQuoteResEntity({
    required this.city,
    required this.distanceKm,
    required this.durationMinutes,
    required this.options,
  });
}

class CityQuoteResEntity {
  final String id;
  final String name;

  CityQuoteResEntity({required this.id, required this.name});
}

class ServiceOptionsResEntity {
  final String serviceTypeId;
  final String serviceTypeName;
  final double estimatedPrice;

  ServiceOptionsResEntity({
    required this.serviceTypeId,
    required this.serviceTypeName,
    required this.estimatedPrice,
  });
}
