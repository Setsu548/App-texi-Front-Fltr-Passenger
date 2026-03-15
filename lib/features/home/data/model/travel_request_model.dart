import 'package:texi_passenger/features/home/domain/entities/travel_request_entity.dart';

class TravelRequestModel {
  final TravelPositionModel origin;
  final TravelPositionModel destination;

  TravelRequestModel({required this.origin, required this.destination});

  Map<String, dynamic> toJson() {
    return {'origin': origin.toJson(), 'destination': destination.toJson()};
  }

  factory TravelRequestModel.fromEntity(TravelRequestEntity entity) {
    return TravelRequestModel(
      origin: TravelPositionModel.fromEntity(entity.origin),
      destination: TravelPositionModel.fromEntity(entity.destination),
    );
  }

  factory TravelRequestModel.fromJson(Map<String, dynamic> json) {
    return TravelRequestModel(
      origin: TravelPositionModel.fromJson(json['origin']),
      destination: TravelPositionModel.fromJson(json['destination']),
    );
  }
}

class TravelPositionModel {
  final double latitude;
  final double longitude;

  TravelPositionModel({required this.latitude, required this.longitude});

  Map<String, dynamic> toJson() {
    return {'lat': latitude, 'lng': longitude};
  }

  factory TravelPositionModel.fromEntity(TravelPositionEntity entity) {
    return TravelPositionModel(
      latitude: entity.latitude,
      longitude: entity.longitude,
    );
  }

  TravelPositionEntity toEntity() {
    return TravelPositionEntity(latitude: latitude, longitude: longitude);
  }

  factory TravelPositionModel.fromJson(Map<String, dynamic> json) {
    return TravelPositionModel(latitude: json['lat'], longitude: json['lng']);
  }
}
