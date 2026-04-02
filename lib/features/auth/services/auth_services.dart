import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:texi_passenger/core/const/data_api_response.dart';
import 'package:texi_passenger/core/lang/extension_lang.dart';
import 'package:texi_passenger/core/providers/dio_provider.dart';
import 'package:texi_passenger/core/utils/image_picker_services.dart';
import 'package:texi_passenger/core/utils/secure_storage_services.dart';
import 'package:texi_passenger/features/auth/data/models/passenger_data_model.dart';
import 'package:texi_passenger/features/auth/data/repo_impl/auth_repo_impl.dart';
import 'package:texi_passenger/features/auth/domain/entities/passenger_auth_data_entity.dart';
import 'package:texi_passenger/features/auth/domain/entities/passenger_auth_res_entity.dart';
import 'package:texi_passenger/features/auth/domain/entities/passenger_profile_entity.dart';
import 'package:texi_passenger/features/auth/domain/entities/passenger_verify_code_entity.dart';
import 'package:texi_passenger/features/auth/presentation/providers/auth_providers.dart';

class AuthServices {
  static Future<PassengerAuthDataEntity> requestingData(
    String phone,
    WidgetRef ref,
  ) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    NetworkInfo networkInfo = NetworkInfo();
    final secureStorage = GetIt.instance<SecureStorageService>();
    String? wifiIp;
    final country = ref.watch(selectedCountryProvider);
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.wifi)) {
      wifiIp = await networkInfo.getWifiIP();
    }
    await secureStorage.saveToken('phone', phone);
    final androidInfo = await deviceInfo.androidInfo;
    final brand = androidInfo.brand;
    final model = androidInfo.model;
    final os = androidInfo.version.release;
    final ip = wifiIp ?? '';
    return PassengerAuthDataEntity(
      brand: brand,
      ip: ip,
      model: model,
      os: os,
      phoneNumber: phone,
      countryCode: country.dialCode,
    );
  }

  static Future<void> getAuthResDataAndSaveToken(
    Dio dio,
    String phone,
    WidgetRef ref,
  ) async {
    final repo = AuthRepoImpl(dio);
    final secureStorage = GetIt.instance<SecureStorageService>();
    final passengerData = await secureStorage.getString(
      SecureKeys.newPassengerData,
    );
    if (passengerData != null) {
      final authResData = await repo.loginAccount(
        PassengerAuthDataModel.fromRawJson(passengerData).toEntity(),
      );
      saveAuthTokens(authResData.data!);
    } else {
      final passengerInfo = await requestingData(phone, ref);
      await secureStorage.saveToken('phone', phone);
      await secureStorage.saveToken(
        SecureKeys.newPassengerData,
        PassengerAuthDataModel.fromEntity(passengerInfo).toRawJson(),
      );
      final authResData = await repo.loginAccount(passengerInfo);
      saveAuthTokens(authResData.data!);
    }
  }

  static Future<void> saveSendCodeToken(
    PassengerAuthDataEntity passengerAuthDataEntity,
  ) async {
    final passengerAuthDataModel = PassengerAuthDataModel.fromEntity(
      passengerAuthDataEntity,
    );
    final secureStorage = GetIt.instance<SecureStorageService>();
    await secureStorage.saveToken(
      SecureKeys.newPassengerData,
      passengerAuthDataModel.toRawJson(),
    );
  }

  static Future<void> saveAuthTokens(
    PassengerAuthResEntity passengerAuthResEntity,
  ) async {
    final secureStorage = GetIt.instance<SecureStorageService>();
    await secureStorage.saveToken(
      SecureKeys.authToken,
      passengerAuthResEntity.token,
    );
    await secureStorage.saveToken(
      SecureKeys.refreshToken,
      passengerAuthResEntity.refreshToken,
    );
  }

  static Future<bool?> verifyAccount(
    PassengerAuthDataEntity passengerData,
    WidgetRef ref,
  ) async {
    final repo = AuthRepoImpl(ref.read(dioProvider));
    final response = await repo.loginAccount(passengerData);
    if (response.success) {
      final passenger = response.data;
      if (passenger!.isVerified == true && passenger.status == 'active') {
        saveAuthTokens(passenger);
        return true;
      }
      return false;
    }
    return null;
  }

  static Future<bool> verifyCode(String codeString, WidgetRef ref) async {
    final code = int.parse(codeString);
    final secureStorage = GetIt.instance<SecureStorageService>();
    final passengerInfoRawJson = await secureStorage.getString(
      SecureKeys.newPassengerData,
    );
    final passengerInfo = PassengerAuthDataModel.fromRawJson(
      passengerInfoRawJson!,
    );
    final passengerVerifyCode = PassengerVerifyCodeEntity(
      brand: passengerInfo.brand,
      ip: passengerInfo.ip,
      model: passengerInfo.model,
      os: passengerInfo.os,
      phoneNumber: passengerInfo.phoneNumber,
      verificationCode: code,
    );
    final repo = AuthRepoImpl(ref.read(dioProvider));
    final response = await repo.verifyCode(passengerVerifyCode);
    if (response.success) {
      return true;
    }
    return false;
  }

  static Future<DataApiResponse<bool>> registerPassenger(
    String phoneNumber,
    String fullName,
    XFile? image,
    WidgetRef ref,
  ) async {
    String? imageCoded;
    final repo = AuthRepoImpl(ref.read(dioProvider));
    final countryCode = ref.watch(selectedCountryProvider).dialCode;
    final secureStorage = GetIt.instance<SecureStorageService>();
    final passengerInfoRawJson = await secureStorage.getString(
      SecureKeys.newPassengerData,
    );
    final passengerInfo = PassengerAuthDataModel.fromRawJson(
      passengerInfoRawJson!,
    );
    final phone = '$countryCode$phoneNumber';

    if (image != null) {
      imageCoded = await ImagePickerService.imageToBase64(File(image.path));
      final passengerProfileEntity = PassengerProfileEntity(
        phoneNumber: phone,
        aliasName: fullName,
        profilePicture: imageCoded!,
        brand: passengerInfo.brand,
        model: passengerInfo.model,
        os: passengerInfo.os,
      );
      final response = await repo.registerPassenger(passengerProfileEntity);
      return response;
    }
    final passengerProfileEntity = PassengerProfileEntity(
      phoneNumber: phone,
      aliasName: fullName,
      profilePicture: '',
      brand: passengerInfo.brand,
      model: passengerInfo.model,
      os: passengerInfo.os,
    );
    final response = await repo.registerPassenger(passengerProfileEntity);
    return response;
  }

  static Future<bool> isPassengerTokenExpired() async {
    final secureStorage = GetIt.instance<SecureStorageService>();
    final token = await secureStorage.getString(SecureKeys.authToken);
    if (token == null) {
      throw Exception(tokenNotFound.i18n);
    }
    return Jwt.isExpired(token);
  }

  static Future<void> refreshPassengerToken() async {
    final secureStorage = GetIt.instance<SecureStorageService>();
    final token = await secureStorage.getString(SecureKeys.refreshToken);
    await dotenv.load();
    final url = dotenv.env['BASE_URL'];
    if (token == null) {
      throw Exception(tokenNotFound.i18n);
    }
    final dio = Dio(
      BaseOptions(
        baseUrl: url!,
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
    final repo = AuthRepoImpl(dio);
    final response = await repo.refreshPassengerToken(dio);
    if (response.success) {
      saveAuthTokens(response.data!);
    } else {
      throw Exception(response.message);
    }
  }
}
