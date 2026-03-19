import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:texi_passenger/core/const/global_exceptions.dart';
import 'package:texi_passenger/core/lang/extension_lang.dart';
import 'package:texi_passenger/features/home/domain/entities/travel_request_entity.dart';
import 'package:texi_passenger/features/home/domain/entities/trip_entities/trip_entity.dart';
import 'package:texi_passenger/features/home/domain/entities/trip_quote_entities/trip_quote_entity.dart';
import 'package:texi_passenger/features/home/domain/entities/trip_quote_entities/trip_quote_res_entity.dart';
import 'package:texi_passenger/features/home/presentation/providers/home_provider.dart';
import 'package:texi_passenger/features/home/presentation/providers/modal_quotes_provider.dart';
import 'package:texi_passenger/features/home/presentation/providers/trip_offers_provider.dart';

class TripQuoteServices {
  Future<void> getTripQuotes(WidgetRef ref) async {
    final homeState = ref.read(homeProvider);
    final modalQuotesState = ref.read(modalQuotesProvider.notifier);
    final origin = homeState.currentPosition;
    final destination = homeState.destinationPosition;

    if (origin == null || destination == null) {
      throw GlobalExceptions(errorGettingLocation.i18n);
    } else {
      final tripQuote = TripQuoteEntity(
        origin: TravelPositionEntity(
          latitude: origin.latitude,
          longitude: origin.longitude,
        ),
        destination: TravelPositionEntity(
          latitude: destination.latitude,
          longitude: destination.longitude,
        ),
      );

      modalQuotesState.getTripQuote(tripQuote);
    }
  }

  void createTrip(
    WidgetRef ref,
    String cityId,
    ServiceOptionsResEntity option,
  ) {
    final homeState = ref.read(homeProvider);
    final origin = homeState.currentPosition;
    final destination = homeState.destinationPosition;

    if (origin == null || destination == null) {
      throw GlobalExceptions(errorGettingLocation.i18n);
    } else {
      final tripEntity = TripEntity(
        origin: TravelPositionEntity(
          latitude: origin.latitude,
          longitude: origin.longitude,
        ),
        destination: TravelPositionEntity(
          latitude: destination.latitude,
          longitude: destination.longitude,
        ),
        cityId: cityId,
        serviceTypeId: option.serviceTypeId,
        estimatedPrice: option.estimatedPrice,
      );
      ref.read(tripOffersProvider.notifier).getTripOffers(tripEntity);
    }
  }
}
