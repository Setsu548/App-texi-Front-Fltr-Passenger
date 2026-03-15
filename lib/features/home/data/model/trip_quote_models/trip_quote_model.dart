import 'package:texi_passenger/features/home/data/model/travel_request_model.dart';
import 'package:texi_passenger/features/home/domain/entities/trip_quote_entities/trip_quote_entity.dart';

class TripQuoteModel {
  final TravelPositionModel origin;
  final TravelPositionModel destination;

  TripQuoteModel({required this.origin, required this.destination});

  factory TripQuoteModel.fromEntity(TripQuoteEntity entity) {
    return TripQuoteModel(
      origin: TravelPositionModel.fromEntity(entity.origin),
      destination: TravelPositionModel.fromEntity(entity.destination),
    );
  }

  TripQuoteEntity toEntity() {
    return TripQuoteEntity(
      origin: origin.toEntity(),
      destination: destination.toEntity(),
    );
  }

  factory TripQuoteModel.fromJson(Map<String, dynamic> json) {
    return TripQuoteModel(
      origin: TravelPositionModel.fromJson(json['origin']),
      destination: TravelPositionModel.fromJson(json['destination']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'origin': origin.toJson(), 'destination': destination.toJson()};
  }
}
