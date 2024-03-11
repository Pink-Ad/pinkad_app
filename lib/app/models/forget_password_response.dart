class ForgetPasswordResponse {
  final String? success;
  final String? message;

  ForgetPasswordResponse({this.success, this.message});

  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordResponse(
      success: json['success'],
      message: json['success'], // Assuming the message is in the 'success' field
    );
  }
}

class ForgetPasswordRequest {
  String? email;

  ForgetPasswordRequest({this.email});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    return data;
  }
}
