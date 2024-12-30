import 'dart:convert';

TwoFaModel twoFaModelFromJson(String str) =>
    TwoFaModel.fromJson(json.decode(str));

String twoFaModelToJson(TwoFaModel data) => json.encode(data.toJson());

class TwoFaModel {
  final String qrCodeUrl;
  final String secretKey;

  TwoFaModel({
    required this.qrCodeUrl,
    required this.secretKey,
  });

  factory TwoFaModel.fromJson(Map<String, dynamic> json) => TwoFaModel(
        qrCodeUrl: json["qr_code_url"] ?? "",
        secretKey: json["secret_key"] ?? 'N/A',
      );

  Map<String, dynamic> toJson() => {
        "qr_code_url": qrCodeUrl,
        "secret_key": secretKey,
      };
}
