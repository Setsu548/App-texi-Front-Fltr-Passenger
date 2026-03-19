import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:texi_passenger/core/const/data_api_response.dart';
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
  Future<DataApiResponse<TripQuoteResEntity>> getTripQuote(
    TripQuoteEntity tripQuote,
  ) async {
    final token = await SecureStorageService().getString(SecureKeys.authToken);
    final dio = Dio(
      BaseOptions(
        baseUrl: dotenv.env['WEB_SOCKET']!,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    final tripQouteModel = TripQuoteModel.fromEntity(tripQuote);

    try {
      final response = await dio.post(
        getQuoteForTrip,
        data: tripQouteModel.toJson(),
      );
      switch (response.statusCode) {
        case 200:
          return DataApiResponse<TripQuoteResEntity>.fromSuccess(
            response.data,
            (data) => TripQuoteResModel.fromJson(data).toEntity(),
          );
        default:
          throw GlobalExceptions(response.data['message']);
      }
    } on DioException catch (e) {
      throw GlobalExceptions(e.response?.data['message']);
    }
  }

  @override
  Future<DataApiResponse<TripResEntity>> createTrip(TripEntity trip) async {
    final token = await SecureStorageService().getString(SecureKeys.authToken);
    final dio = Dio(
      BaseOptions(
        baseUrl: dotenv.env['WEB_SOCKET']!,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    final tripModel = TripModel.fromEntity(trip);
    print(tripModel);

    try {
      final response = await dio.post(createTripUrl, data: tripModel.toJson());
      return DataApiResponse<TripResEntity>.fromSuccess(
        response.data,
        (data) => TripResModel.fromJson(data).toEntity(),
      );
    } on DioException catch (e) {
      throw GlobalExceptions(e.response?.data['message']);
    }
  }
}
