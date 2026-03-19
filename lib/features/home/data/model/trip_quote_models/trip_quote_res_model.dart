import 'package:texi_passenger/features/home/domain/entities/trip_quote_entities/trip_quote_res_entity.dart';

class TripQuoteResModel {
  final CityQuoteResModel city;
  final double distanceKm;
  final int durationMinutes;
  final List<ServiceOptionsResModel> options;

  TripQuoteResModel({
    required this.city,
    required this.distanceKm,
    required this.durationMinutes,
    required this.options,
  });

  factory TripQuoteResModel.fromJson(Map<String, dynamic> json) {
    return TripQuoteResModel(
      city: CityQuoteResModel.fromJson(json['city']),
      distanceKm: json['distanceKm'] as double,
      durationMinutes: json['durationMinutes'] as int,
      options: (json['options'] as List)
          .map((e) => ServiceOptionsResModel.fromJson(e))
          .toList(),
    );
  }

  TripQuoteResEntity toEntity() {
    return TripQuoteResEntity(
      city: city.toEntity(),
      distanceKm: distanceKm,
      durationMinutes: durationMinutes,
      options: options.map((e) => e.toEntity()).toList(),
    );
  }
}

class CityQuoteResModel {
  final String id;
  final String name;

  CityQuoteResModel({required this.id, required this.name});

  factory CityQuoteResModel.fromJson(Map<String, dynamic> json) {
    return CityQuoteResModel(id: json['id'], name: json['name']);
  }

  CityQuoteResEntity toEntity() {
    return CityQuoteResEntity(id: id, name: name);
  }
}

class ServiceOptionsResModel {
  final String serviceTypeId;
  final String serviceTypeName;
  final double estimatedPrice;

  ServiceOptionsResModel({
    required this.serviceTypeId,
    required this.serviceTypeName,
    required this.estimatedPrice,
  });

  ServiceOptionsResEntity toEntity() {
    return ServiceOptionsResEntity(
      serviceTypeId: serviceTypeId,
      serviceTypeName: serviceTypeName,
      estimatedPrice: estimatedPrice,
    );
  }

  factory ServiceOptionsResModel.fromJson(Map<String, dynamic> json) {
    return ServiceOptionsResModel(
      serviceTypeId: json['serviceTypeId'] as String,
      serviceTypeName: json['serviceTypeName'] as String,
      estimatedPrice: (json['estimatedPrice'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'serviceTypeId': serviceTypeId,
      'serviceTypeName': serviceTypeName,
      'estimatedPrice': estimatedPrice,
    };
  }
}
