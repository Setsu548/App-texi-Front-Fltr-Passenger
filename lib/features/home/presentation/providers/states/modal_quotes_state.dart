import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:texi_passenger/features/home/domain/entities/trip_quote_entities/trip_quote_res_entity.dart';

class ModalQuotesState {
  final bool isVisible;
  final AsyncValue<TripQuoteResEntity> tripQuotes;

  ModalQuotesState({
    required this.isVisible,
    required this.tripQuotes,
  });
}
