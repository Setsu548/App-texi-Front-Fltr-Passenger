import 'package:texi_passenger/features/home/data/model/trip_models/trip_offers_model.dart';
import 'package:texi_passenger/features/home/domain/entities/trip_entities/trip_res_entity.dart';

class TripResModel {
  final String tripId;
  final String status;
  final double estimatedPrice;
  final List<TripOffersModel> offers;

  TripResModel({
    required this.tripId,
    required this.status,
    required this.estimatedPrice,
    required this.offers,
  });

  factory TripResModel.fromEntity(TripResEntity entity) {
    return TripResModel(
      tripId: entity.tripId,
      status: entity.status,
      estimatedPrice: entity.estimatedPrice,
      offers: entity.offers.map((x) => TripOffersModel.fromEntity(x)).toList(),
    );
  }

  TripResEntity toEntity() {
    return TripResEntity(
      tripId: tripId,
      status: status,
      estimatedPrice: estimatedPrice,
      offers: offers.map((x) => x.toEntity()).toList(),
    );
  }

  factory TripResModel.fromJson(Map<String, dynamic> json) {
    return TripResModel(
      tripId: json['tripId'],
      status: json['status'],
      estimatedPrice: (json['estimatedPrice'] as num).toDouble(),
      offers: List<TripOffersModel>.from(
        json['offers'].map((x) => TripOffersModel.fromJson(x)),
      ),
    );
  }
}
