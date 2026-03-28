import 'package:texi_passenger/features/travel/domain/entities/driver_info_entity.dart';

class DriverInfoModel {
  final String tripId;
  final int driverId;
  final String status;
  final double estimatedPrice;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String fullName;
  final String driverName;
  final String profilePhotoUrl;
  final DateTime profilePhotoExpiresAt;
  final String carModel;
  final String carPlate;
  final String? carColor;

  DriverInfoModel({
    required this.tripId,
    required this.driverId,
    required this.status,
    required this.estimatedPrice,
    required this.createdAt,
    required this.updatedAt,
    required this.fullName,
    required this.driverName,
    required this.profilePhotoUrl,
    required this.profilePhotoExpiresAt,
    required this.carModel,
    required this.carPlate,
    this.carColor,
  });

  factory DriverInfoModel.fromEntity(DriverInfoEntity entity) {
    return DriverInfoModel(
      tripId: entity.tripId,
      driverId: entity.driverId,
      status: entity.status,
      estimatedPrice: entity.estimatedPrice,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      fullName: entity.fullName,
      driverName: entity.driverName,
      profilePhotoUrl: entity.profilePhotoUrl,
      profilePhotoExpiresAt: entity.profilePhotoExpiresAt,
      carModel: entity.carModel,
      carPlate: entity.carPlate,
      carColor: entity.carColor,
    );
  }

  factory DriverInfoModel.fromJson(Map<String, dynamic> json) {
    return DriverInfoModel(
      tripId: json['tripId'],
      driverId: int.parse(json['driverId'].toString()),
      status: json['status'],
      estimatedPrice: double.parse(json['estimatedPrice'].toString()),
      createdAt: DateTime.parse(json['createdAt'].toString()),
      updatedAt: DateTime.parse(json['updatedAt'].toString()),
      fullName: json['fullName'],
      driverName: json['driverName'],
      profilePhotoUrl: json['profilePhotoUrl'],
      profilePhotoExpiresAt: DateTime.parse(json['profilePhotoExpiresAt'].toString()),
      carModel: json['carModel'],
      carPlate: json['carPlate'],
      carColor: json['carColor'],
    );
  }

  DriverInfoEntity toEntity() {
    return DriverInfoEntity(
      tripId: tripId,
      driverId: driverId,
      status: status,
      estimatedPrice: estimatedPrice,
      createdAt: createdAt,
      updatedAt: updatedAt,
      fullName: fullName,
      driverName: driverName,
      profilePhotoUrl: profilePhotoUrl,
      profilePhotoExpiresAt: profilePhotoExpiresAt,
      carModel: carModel,
      carPlate: carPlate,
      carColor: carColor,
    );
  }
}