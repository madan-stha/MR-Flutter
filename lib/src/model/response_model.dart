import 'dart:convert';

ApiResponse apiResponseFromJson(String str) =>
    ApiResponse.fromJson(json.decode(str));

String apiResponseToJson(ApiResponse body) => json.encode(body.toJson());

class ApiResponse {
  String? status;
  dynamic data;
  String accessToken;
  bool f2fa;
  bool twoFa;
  String expiresAt;
  String role;
  String message;
  String exception;

  ApiResponse({
    this.status,
    this.data,
    this.accessToken = '',
    this.f2fa = false,
    this.twoFa = false,
    this.expiresAt = '',
    this.role = '',
    this.message = '',
    this.exception = '',
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        status: json["status"],
        data: json["data"],
        accessToken: json["access_token"] ?? "",
        f2fa: json["f2fa"] ?? false,
        twoFa: json["2fa"] ?? false,
        expiresAt: json["expires_at"] ?? "",
        role: json["role"] ?? "",
        message: json["message"] == null || json['message'] == ""
            ? ""
            : json['message'],
        exception: json["exception"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data,
        "accessToken": accessToken,
        "f2fa": f2fa,
        "twoFa": twoFa,
        "expiresAt": expiresAt,
        "role": role,
        "message": message,
        "exception": exception,
      };
}
