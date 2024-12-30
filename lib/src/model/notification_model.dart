import 'dart:convert';

List<NotificationModel> notificationModelFromJson(String str) =>
    List<NotificationModel>.from(
        json.decode(str).map((x) => NotificationModel.fromJson(x)));

String notificationModelToJson(List<NotificationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationModel {
  String id;
  String createdBy;
  String createdAt;
  String title;
  String description;
  String status;

  NotificationModel({
    required this.id,
    required this.createdBy,
    required this.createdAt,
    required this.title,
    required this.description,
    required this.status,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["id"],
        createdBy: json["createdBy"] ?? "",
        createdAt: json["createdAt"] ?? "",
        title: json["title"] ?? "",
        description: json["description"] ?? "",
        status: json["status"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdBy": createdBy,
        "createdAt": createdAt,
        "title": title,
        "description": description,
        "status": status,
      };
}
