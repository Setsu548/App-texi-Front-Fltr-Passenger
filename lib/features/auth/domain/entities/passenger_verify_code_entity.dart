class PassengerVerifyCodeEntity {
  final String brand;
  final String ip;
  final String model;
  final String os;
  final String phoneNumber;
  final int verificationCode;

  PassengerVerifyCodeEntity({
    required this.brand,
    required this.ip,
    required this.model,
    required this.os,
    required this.phoneNumber,
    required this.verificationCode,
  });
}
