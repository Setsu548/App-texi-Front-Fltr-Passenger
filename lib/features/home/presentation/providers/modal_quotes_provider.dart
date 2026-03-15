import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:texi_passenger/features/home/data/repo_impl/travel_repo_impl.dart';
import 'package:texi_passenger/features/home/domain/entities/trip_quote_entities/trip_quote_entity.dart';
import 'package:texi_passenger/features/home/domain/repo/travel_repo.dart';
import 'package:texi_passenger/features/home/presentation/providers/states/modal_quotes_state.dart';

final travelRepoProvider = Provider<TravelRepo>((ref) {
  return TravelRepoImpl();
});

class ModalQuotesProvider extends Notifier<ModalQuotesState> {
  @override
  ModalQuotesState build() {
    return ModalQuotesState(
      isVisible: false,
      tripQuotes: const AsyncValue.loading(),
    );
  }

  void toggleModalQuotes() {
    state = ModalQuotesState(
      isVisible: !state.isVisible,
      tripQuotes: state.tripQuotes,
    );
  }

  Future<void> getTripQuote(TripQuoteEntity tripQuote) async {
    state = ModalQuotesState(
      isVisible: state.isVisible,
      tripQuotes: const AsyncValue.loading(),
    );
    final tripQuotes = await ref
        .read(travelRepoProvider)
        .getTripQuote(tripQuote);
    toggleModalQuotes();
    state = ModalQuotesState(
      isVisible: state.isVisible,
      tripQuotes: AsyncValue.data(tripQuotes),
    );
  }
}

final modalQuotesProvider =
    NotifierProvider<ModalQuotesProvider, ModalQuotesState>(
      ModalQuotesProvider.new,
    );
