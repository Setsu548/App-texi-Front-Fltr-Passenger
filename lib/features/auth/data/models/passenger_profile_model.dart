
import 'package:texi_passenger/features/auth/domain/entities/passenger_profile_entity.dart';

class PassengerProfileModel {
  final String phoneNumber;
  final String aliasName;
  final String profilePicture;
  final String brand;
  final String model;
  final String os;

  PassengerProfileModel({
    required this.phoneNumber,
    required this.aliasName,
    required this.profilePicture,
    required this.brand,
    required this.model,
    required this.os,
  });

  factory PassengerProfileModel.fromEntity(PassengerProfileEntity entity) =>
      PassengerProfileModel(
        phoneNumber: entity.phoneNumber,
        aliasName: entity.aliasName,
        profilePicture: entity.profilePicture,
        brand: entity.brand,
        model: entity.model,
        os: entity.os,
      );
      
  factory PassengerProfileModel.fromJson(Map<String, dynamic> json) =>
      PassengerProfileModel(
        phoneNumber: json['phone_number'],
        aliasName: json['alias_name'],
        profilePicture: json['profile_picture'],
        brand: json['brand'],
        model: json['model'],
        os: json['os'],
      );

  Map<String, dynamic> toJson() => {
        'phone_number': phoneNumber,
        'alias_name': aliasName,
        'profile_picture': profilePicture,
        'brand': brand,
        'model': model,
        'os': os,
      };
}
