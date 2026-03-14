import 'package:texi_passenger/core/const/error_model.dart';

class DataApiResponse<T> {
  final String code;
  final T? data;
  final ErrorModel? error;
  final String message;
  final int statusCode;
  final bool success;

  DataApiResponse({
    required this.code,
    this.data,
    this.error,
    required this.message,
    required this.statusCode,
    required this.success,
  });

  factory DataApiResponse.fromSuccess(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic> json)? fromJsonT,
  ) {
    return DataApiResponse(
      code: json['code'],
      data: json['data'] != null && fromJsonT != null
          ? fromJsonT(json['data'])
          : null,
      error: json['error'] != null ? ErrorModel.fromJson(json['error']) : null,
      message: json['message'],
      statusCode: json['status_code'],
      success: json['success'] ?? false,
    );
  }

  factory DataApiResponse.fromError(Map<String, dynamic> json) {
    return DataApiResponse(
      code: json['code'],
      error: json['error'] != null ? ErrorModel.fromJson(json['error']) : null,
      message: json['message'],
      statusCode: json['status_code'],
      success: json['success'] ?? false,
    );
  }
}
