
import 'package:texi_passenger/features/home/domain/entities/trip_entities/trip_res_entity.dart';
import 'package:texi_passenger/features/home/domain/entities/trip_quote_entities/trip_quote_entity.dart';
import 'package:texi_passenger/features/home/domain/entities/trip_quote_entities/trip_quote_res_entity.dart';
import 'package:texi_passenger/features/home/domain/entities/trip_entities/trip_entity.dart';

abstract class TravelRepo {
  Future<TripQuoteResEntity> getTripQuote(TripQuoteEntity tripQuote);
  Future<TripResEntity> createTrip(TripEntity trip);
}