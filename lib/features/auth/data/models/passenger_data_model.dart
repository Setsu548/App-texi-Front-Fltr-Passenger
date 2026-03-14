import 'dart:convert';

import 'package:texi_passenger/features/auth/domain/entities/passenger_auth_data_entity.dart';

class PassengerAuthDataModel extends PassengerAuthDataEntity {
  PassengerAuthDataModel({
    required super.brand,
    required super.ip,
    required super.model,
    required super.os,
    required super.phoneNumber,
    required super.countryCode,
  });

  factory PassengerAuthDataModel.fromEntity(PassengerAuthDataEntity entity) {
    return PassengerAuthDataModel(
      brand: entity.brand,
      ip: entity.ip,
      model: entity.model,
      os: entity.os,
      phoneNumber: entity.phoneNumber,
      countryCode: entity.countryCode,
    );
  }

  PassengerAuthDataEntity toEntity() {
    return PassengerAuthDataEntity(
      brand: brand,
      ip: ip,
      model: model,
      os: os,
      phoneNumber: phoneNumber,
      countryCode: countryCode,
    );
  }

  factory PassengerAuthDataModel.fromJson(Map<String, dynamic> json) {
    return PassengerAuthDataModel(
      brand: json['brand'],
      ip: json['ip'],
      model: json['model'],
      os: json['os'],
      phoneNumber: json['phone_number'],
      countryCode: json['country_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'brand': brand,
      'ip': ip,
      'model': model,
      'os': os,
      'phone_number': phoneNumber,
      'country_code': countryCode,
    };
  }

  PassengerAuthDataModel copyWith({
    String? brand,
    String? ip,
    String? model,
    String? os,
    String? phoneNumber,
    String? countryCode,
  }) {
    return PassengerAuthDataModel(
      brand: brand ?? this.brand,
      ip: ip ?? this.ip,
      model: model ?? this.model,
      os: os ?? this.os,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      countryCode: countryCode ?? this.countryCode,
    );
  }

  String toRawJson() => json.encode(toJson());

  factory PassengerAuthDataModel.fromRawJson(String str) =>
      PassengerAuthDataModel.fromJson(json.decode(str));
}
