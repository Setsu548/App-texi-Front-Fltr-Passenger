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
}

class TravelPositionModel {
  final double latitude;
  final double longitude;

  TravelPositionModel({required this.latitude, required this.longitude});

  Map<String, dynamic> toJson() {
    return {'lat': latitude, 'lng': longitude};
  }

  factory TravelPositionModel.fromEntity(TravelPosition entity) {
    return TravelPositionModel(
      latitude: entity.latitude,
      longitude: entity.longitude,
    );
  }
}
