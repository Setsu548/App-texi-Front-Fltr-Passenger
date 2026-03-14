import 'package:dio/dio.dart';
import 'package:texi_passenger/features/home/data/endpoints/travel_endpoints.dart' as TravelEndpoints;
import 'package:texi_passenger/features/home/domain/entities/travel_request_entity.dart';
import 'package:texi_passenger/features/home/data/model/travel_request_model.dart';
import 'package:texi_passenger/features/home/domain/repo/travel_repo.dart';

class TravelRepoImpl implements TravelRepo {
  final Dio _dio;

  TravelRepoImpl(this._dio);

  @override
  Future<void> createTravelRequest(TravelRequestEntity travelRequest) async {
    final TravelRequestModel travelRequestModel =
        TravelRequestModel.fromEntity(travelRequest);
    final response = await _dio.post(
      TravelEndpoints.getQuoteForTrip,
      data: travelRequestModel.toJson(),
    );
    switch (response.statusCode) {
      case 200:
        return;
      default:
        throw Exception('Failed to create travel request');
    }
  }
}