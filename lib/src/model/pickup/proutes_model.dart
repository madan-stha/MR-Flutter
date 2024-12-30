import 'dart:convert';

List<PickUpRoutesModel> pickUpRoutesModelFromJson(String str) =>
    List<PickUpRoutesModel>.from(
        json.decode(str).map((x) => PickUpRoutesModel.fromJson(x)));

String pickUpRoutesModelToJson(List<PickUpRoutesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PickUpRoutesModel {
  final int id;
  final String name;
  final String description;
  final String status;
  final String startDate;
  final String createdAt;
  final String updatedAt;
  final dynamic driverCoordinates;
  List<Custome> customers;
  List<List<dynamic>> coordinates;
  final int totalMaterials;

  PickUpRoutesModel({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
    required this.startDate,
    required this.createdAt,
    required this.updatedAt,
    required this.driverCoordinates,
    required this.customers,
    required this.coordinates,
    required this.totalMaterials,
  });

  factory PickUpRoutesModel.fromJson(Map<String, dynamic> json) =>
      PickUpRoutesModel(
        id: json["id"],
        name: json["name"] ?? "",
        description: json["description"] ?? "",
        status: json["status"] ?? "",
        startDate: json["start_date"] ?? "",
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        driverCoordinates: json["driver_coordinates"],
        customers: json["customers"] != null
            ? List<Custome>.from(
                json["customers"].map(
                  (x) => Custome.fromJson(x),
                ),
              )
            : [],
        coordinates: json["coordinates"] != null
            ? List<List<double>>.from(
                json["coordinates"].map(
                  (x) => List<double>.from(
                    x.map(
                      (x) => x,
                    ),
                  ),
                ),
              )
            : [],
        totalMaterials: json["total_materials"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "status": status,
        "start_date": startDate,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "driver_coordinates": driverCoordinates,
        "customers": List<dynamic>.from(customers.map((x) => x)),
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
        "total_materials": totalMaterials,
      };
}

class Custome {
  String name;
  String contact;

  Custome({
    required this.name,
    required this.contact,
  });

  factory Custome.fromJson(Map<String, dynamic> json) => Custome(
        name: json["name"] ?? "",
        contact: json["contact"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "contact": contact,
      };
}
