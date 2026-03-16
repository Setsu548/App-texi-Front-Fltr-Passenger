import 'package:dio/dio.dart';
import 'package:texi_passenger/core/const/global_exceptions.dart';
import 'package:texi_passenger/core/utils/secure_storage_services.dart';
import 'package:texi_passenger/features/home/data/endpoints/travel_endpoints.dart';
import 'package:texi_passenger/features/home/data/model/trip_models/trip_model.dart';
import 'package:texi_passenger/features/home/data/model/trip_models/trip_res_model.dart';
import 'package:texi_passenger/features/home/data/model/trip_quote_models/trip_quote_model.dart';
import 'package:texi_passenger/features/home/data/model/trip_quote_models/trip_quote_res_model.dart';
import 'package:texi_passenger/features/home/domain/entities/trip_entities/trip_entity.dart';
import 'package:texi_passenger/features/home/domain/entities/trip_entities/trip_res_entity.dart';
import 'package:texi_passenger/features/home/domain/entities/trip_quote_entities/trip_quote_entity.dart';
import 'package:texi_passenger/features/home/domain/entities/trip_quote_entities/trip_quote_res_entity.dart';
import 'package:texi_passenger/features/home/domain/repo/travel_repo.dart';

class TravelRepoImpl implements TravelRepo {
  @override
  Future<TripQuoteResEntity> getTripQuote(TripQuoteEntity tripQuote) async {
    final token = await SecureStorageService().getString(SecureKeys.authToken);
    final dio = Dio(BaseOptions(headers: {'Authorization': 'Bearer $token'}));
    final tripQouteModel = TripQuoteModel.fromEntity(tripQuote);

    try {
      final response = await dio.post(
        getQuoteForTrip,
        data: tripQouteModel.toJson(),
      );
      return TripQuoteResModel.fromJson(response.data!).toEntity();
    } on DioException catch (e) {
      return TripQuoteResModel.fromJson(e.response?.data).toEntity();
    }
  }

  @override
  Future<TripResEntity> createTrip(TripEntity trip) async {
    final token = await SecureStorageService().getString(SecureKeys.authToken);
    final dio = Dio(BaseOptions(headers: {'Authorization': 'Bearer $token'}));
    final tripModel = TripModel.fromEntity(trip);

    try {
      final response = await dio.post(createTriUrl, data: tripModel.toJson());
      return TripResModel.fromJson(response.data!).toEntity();
    } on DioException catch (e) {
      throw GlobalExceptions(e.response?.data['message']);
    }
  }
}
