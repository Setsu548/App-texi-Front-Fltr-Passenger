import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:texi_passenger/features/home/domain/entities/trip_entities/trip_entity.dart';
import 'package:texi_passenger/features/home/presentation/providers/modal_quotes_provider.dart';
import 'package:texi_passenger/features/home/presentation/providers/states/trip_offers_state.dart';

class TripOffersProvider extends Notifier<TripOffersState> {
  @override
  TripOffersState build() {
    return TripOffersState(tripResEntity: AsyncValue.loading());
  }

  Future<void> getTripOffers(TripEntity trip) async {
    state = TripOffersState(tripResEntity: AsyncValue.loading());
    final tripOffers = await ref.read(travelRepoProvider).createTrip(trip);
    state = TripOffersState(tripResEntity: AsyncValue.data(tripOffers));
  }
}

final tripOffersProvider =
    NotifierProvider<TripOffersProvider, TripOffersState>(
      TripOffersProvider.new,
    );
