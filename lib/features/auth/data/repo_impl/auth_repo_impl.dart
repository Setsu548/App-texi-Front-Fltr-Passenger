import 'package:dio/dio.dart';
import 'package:texi_passenger/core/const/data_api_response.dart';
import 'package:texi_passenger/core/lang/extension_lang.dart';
import 'package:texi_passenger/features/auth/data/auth_end_points.dart';
import 'package:texi_passenger/features/auth/data/models/passenger_data_model.dart';
import 'package:texi_passenger/features/auth/data/models/passenger_auth_res_model.dart';
import 'package:texi_passenger/features/auth/data/models/passenger_profile_model.dart';
import 'package:texi_passenger/features/auth/data/models/passenger_send_code_res_model.dart';
import 'package:texi_passenger/features/auth/data/models/passenger_verify_code_model.dart';
import 'package:texi_passenger/features/auth/domain/entities/passenger_auth_data_entity.dart';
import 'package:texi_passenger/features/auth/domain/entities/passenger_auth_res_entity.dart';
import 'package:texi_passenger/features/auth/domain/entities/passenger_profile_entity.dart';
import 'package:texi_passenger/features/auth/domain/entities/passenger_verify_code_entity.dart';
import 'package:texi_passenger/features/auth/domain/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final Dio _dio;

  AuthRepoImpl(this._dio);

  @override
  Future<DataApiResponse<PassengerSendCodeResModel>> passengerSendCode(
    PassengerAuthDataEntity passengerData,
  ) async {
    final passengerDataModel = PassengerAuthDataModel.fromEntity(passengerData);
    try {
      final userResModel = await _dio.post(
        passengerLoginEndPoint,
        data: passengerDataModel.toJson(),
      );
      switch (userResModel.statusCode) {
        case 200:
          return DataApiResponse.fromSuccess(
            userResModel.data,
            (json) => PassengerSendCodeResModel.fromJson(json),
          );
        default:
          return DataApiResponse.fromError(userResModel.data);
      }
    } on DioException catch (e) {
      return DataApiResponse.fromError(e.response?.data);
    } catch (e) {
      return DataApiResponse(
        code: 'error',
        message: errorVerifyAccount.i18n,
        statusCode: 400,
        success: false,
      );
    }
  }

  @override
  Future<DataApiResponse<PassengerAuthResEntity>> loginAccount(
    PassengerAuthDataEntity passengerData,
  ) async {
    final passengerDataModel = PassengerAuthDataModel.fromEntity(passengerData);
    try {
      final response = await _dio.post(
        passengerLoginEndPoint,
        data: passengerDataModel.toJson(),
      );
      if (response.statusCode != 200) {
        return DataApiResponse.fromError(response.data);
      }
      return DataApiResponse.fromSuccess(
        response.data,
        (json) => PassengerAuthResModel.fromJson(json).toEntity(),
      );
    } on DioException catch (e) {
      return DataApiResponse.fromError(e.response?.data);
    } catch (e) {
      return DataApiResponse(
        code: 'error',
        message: errorVerifyAccount.i18n,
        statusCode: 400,
        success: false,
      );
    }
  }

  @override
  Future<DataApiResponse<void>> verifyCode(
    PassengerVerifyCodeEntity passengerVerifyCodeEntity,
  ) async {
    final passengerVerifyCodeModel = PassengerVerifyCodeModel.fromEntity(
      passengerVerifyCodeEntity,
    );
    try {
      final response = await _dio.post(
        passengerVerifyCodeEndPoint,
        data: passengerVerifyCodeModel.toJson(),
      );
      if (response.statusCode != 200) {
        return DataApiResponse.fromError(response.data);
      }
      return DataApiResponse.fromSuccess(response.data, null);
    } on DioException catch (e) {
      return DataApiResponse.fromError(e.response?.data);
    } catch (e) {
      return DataApiResponse(
        code: 'error',
        message: errorVerifyCode.i18n,
        statusCode: 400,
        success: false,
      );
    }
  }

  @override
  Future<DataApiResponse<bool>> registerPassenger(
    PassengerProfileEntity passengerProfileEntity,
  ) async {
    final passengerProfileModel = PassengerProfileModel.fromEntity(
      passengerProfileEntity,
    );
    try {
      final response = await _dio.post(
        passengerRegisterEndPoint,
        data: passengerProfileModel.toJson(),
      );
      print(response);
      if (response.statusCode != 200) {
        return DataApiResponse.fromError(response.data);
      }
      return DataApiResponse.fromSuccess(response.data, (json) => true);
    } on DioException catch (e) {
      return DataApiResponse.fromError(e.response?.data);
    } catch (e) {
      return DataApiResponse(
        code: 'error',
        message: 'error',
        statusCode: 400,
        success: false,
      );
    }
  }
}
