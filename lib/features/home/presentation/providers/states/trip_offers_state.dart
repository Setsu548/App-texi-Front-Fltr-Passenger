import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:texi_passenger/features/home/domain/entities/trip_entities/trip_res_entity.dart';

class TripOffersState {
  final AsyncValue<TripResEntity> tripResEntity;

  TripOffersState({required this.tripResEntity});

  TripOffersState copyWith({AsyncValue<TripResEntity>? tripResEntity}) {
    return TripOffersState(tripResEntity: tripResEntity ?? this.tripResEntity);
  }
}
