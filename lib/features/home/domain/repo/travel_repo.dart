
import 'package:texi_passenger/core/const/data_api_response.dart';
import 'package:texi_passenger/features/home/domain/entities/trip_entities/trip_res_entity.dart';
import 'package:texi_passenger/features/home/domain/entities/trip_quote_entities/trip_quote_entity.dart';
import 'package:texi_passenger/features/home/domain/entities/trip_quote_entities/trip_quote_res_entity.dart';
import 'package:texi_passenger/features/home/domain/entities/trip_entities/trip_entity.dart';

abstract class TravelRepo {
  Future<DataApiResponse<TripQuoteResEntity>> getTripQuote(TripQuoteEntity tripQuote);
  Future<DataApiResponse<TripResEntity>> createTrip(TripEntity trip);
}