import 'package:texi_passenger/features/auth/domain/entities/passenger_auth_res_entity.dart';

class PassengerAuthResModel extends PassengerAuthResEntity {
  PassengerAuthResModel({
    required super.isVerified,
    required super.message,
    required super.status,
    required super.typeUserId,
    required super.token,
  });

  factory PassengerAuthResModel.fromEntity(PassengerAuthResEntity entity) {
    return PassengerAuthResModel(
      isVerified: entity.isVerified,
      message: entity.message,
      status: entity.status,
      typeUserId: entity.typeUserId,
      token: entity.token,
    );
  }

  PassengerAuthResEntity toEntity() {
    return PassengerAuthResEntity(
      isVerified: isVerified,
      message: message,
      status: status,
      typeUserId: typeUserId,
      token: token,
    );
  }

  factory PassengerAuthResModel.fromJson(Map<String, dynamic> json) {
    return PassengerAuthResModel(
      isVerified: json['is_verified'] ?? false,
      message: json['message'] ?? '',
      status: json['status'] ?? '',
      typeUserId: json['type_user_id'] ?? 0,
      token: json['token'] ?? '',
    );
  }
}
