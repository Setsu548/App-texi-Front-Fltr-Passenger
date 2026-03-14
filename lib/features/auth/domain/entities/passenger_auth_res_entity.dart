class PassengerAuthResEntity {
  final bool isVerified;
  final String message;
  final String status;
  final int typeUserId;
  final String token;

  PassengerAuthResEntity({
    required this.isVerified,
    required this.message,
    required this.status,
    required this.typeUserId,
    required this.token,
  });
}