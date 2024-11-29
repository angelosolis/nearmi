class ResultApiModel {
  final bool success;
  final dynamic data;
  final Map<String, dynamic> origin;
  final String message;

  ResultApiModel({
    required this.success,
    required this.message,
    this.data,
    required this.origin,
  });

  factory ResultApiModel.fromJson(Map<String, dynamic> json) {
    return ResultApiModel(
      success: json['success'] ?? false,
      data: json['data'],
      origin: json,
      message: json['message'] ?? json['msg'] ?? "unknown",
    );
  }
}
