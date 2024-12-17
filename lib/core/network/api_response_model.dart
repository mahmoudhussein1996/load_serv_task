class ApiResponse {
  final String message;
  final dynamic data; // Use `Map` to hold an empty or future data

  ApiResponse({
    required this.message,
    required this.data,
  });

  // Factory constructor to create an instance from JSON
  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      message: json['message'] == false ? "": json['message'] as String,
      data: json['data'] ?? json['users'],
    );
  }

  // Method to convert instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data,
    };
  }
}