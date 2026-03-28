class DriverInfoEntity {
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

  DriverInfoEntity({
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
}
