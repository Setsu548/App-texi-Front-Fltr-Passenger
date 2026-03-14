import 'package:texi_passenger/features/home/domain/entities/travel_request_entity.dart';

abstract class TravelRepo {
  Future<void> createTravelRequest(TravelRequestEntity travelRequest);
}