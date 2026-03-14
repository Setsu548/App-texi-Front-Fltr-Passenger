class PassengerSendCodeResModel {
  final int typeUserId;
  final bool isVerified;
  final String status;
  final String message;

  PassengerSendCodeResModel({
    required this.typeUserId,
    required this.isVerified,
    required this.status,
    required this.message,
  });

  factory PassengerSendCodeResModel.fromJson(Map<String, dynamic> json) {
    return PassengerSendCodeResModel(
      typeUserId: json['type_user_id'] ?? 0,
      isVerified: json['is_verified'] ?? false,
      status: json['status'] ?? '',
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'type_user_id': typeUserId,
    'is_verified': isVerified,
    'status': status,
    'message': message,
  };
}