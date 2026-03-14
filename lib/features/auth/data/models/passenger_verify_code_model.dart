import 'package:texi_passenger/features/auth/domain/entities/passenger_verify_code_entity.dart';

class PassengerVerifyCodeModel extends PassengerVerifyCodeEntity {
  PassengerVerifyCodeModel({
    required super.brand,
    required super.ip,
    required super.model,
    required super.os,
    required super.phoneNumber,
    required super.verificationCode,
  });

  factory PassengerVerifyCodeModel.fromEntity(
    PassengerVerifyCodeEntity entity,
  ) {
    return PassengerVerifyCodeModel(
      brand: entity.brand,
      ip: entity.ip,
      model: entity.model,
      os: entity.os,
      phoneNumber: entity.phoneNumber,
      verificationCode: entity.verificationCode,
    );
  }

  PassengerVerifyCodeEntity toEntity() {
    return PassengerVerifyCodeEntity(
      brand: brand,
      ip: ip,
      model: model,
      os: os,
      phoneNumber: phoneNumber,
      verificationCode: verificationCode,
    );
  }

  factory PassengerVerifyCodeModel.fromJson(Map<String, dynamic> json) {
    return PassengerVerifyCodeModel(
      brand: json['brand'] ?? '',
      ip: json['ip'] ?? '',
      model: json['model'] ?? '',
      os: json['os'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      verificationCode: json['verification_code'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'brand': brand,
    'ip': ip,
    'model': model,
    'os': os,
    'phone_number': phoneNumber,
    'verification_code': verificationCode,
  };
}

/* {
  "brand": "Apple",
  "ip": "192.168.1.1",
  "model": "iPhone 12",
  "os": "iOS 14",
  "phone_number": "1234567890",
  "verification_code": 1234
} */
