import 'package:texi_passenger/core/const/data_api_response.dart';
import 'package:texi_passenger/features/auth/data/models/passenger_send_code_res_model.dart';
import 'package:texi_passenger/features/auth/domain/entities/passenger_auth_data_entity.dart';
import 'package:texi_passenger/features/auth/domain/entities/passenger_auth_res_entity.dart';
import 'package:texi_passenger/features/auth/domain/entities/passenger_profile_entity.dart';
import 'package:texi_passenger/features/auth/domain/entities/passenger_verify_code_entity.dart';

abstract class AuthRepo {
  Future<DataApiResponse<PassengerSendCodeResModel>> passengerSendCode(
    PassengerAuthDataEntity passengerData,
  );

  Future<DataApiResponse<PassengerAuthResEntity>> loginAccount(
    PassengerAuthDataEntity passengerData,
  );

  Future<DataApiResponse> verifyCode(
    PassengerVerifyCodeEntity passengerVerifyCodeEntity,
  );

  Future<DataApiResponse<bool>> registerPassenger(
    PassengerProfileEntity passengerProfileEntity,
  );
}
