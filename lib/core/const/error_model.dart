class ErrorModel {
  String message;
  String details;

  ErrorModel({required this.message, required this.details});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(message: json['message'], details: json['details']);
  }
}
