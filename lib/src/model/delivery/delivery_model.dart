import 'dart:convert';

List<DeliveryModel> deliveryModelFromJson(String str) =>
    List<DeliveryModel>.from(
        json.decode(str).map((x) => DeliveryModel.fromJson(x)));

String deliveryModelToJson(List<DeliveryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DeliveryModel {
  final int id;
  final int scheduleId;
  final int driverId;
  final int truckId;
  final String tripName;
  final int tripNumber;
  final String status;
  final String tripDate;
  final String note;
  final dynamic attachment;
  final dynamic driverCoordinates;
  final dynamic startAt;
  final dynamic endedAt;
  final dynamic deletedAt;
  final String createdAt;
  final String updatedAt;
  Customeer customer;

  final double weightOfMaterials;
  final List<double> coordinate;
  final double tripWeight;
  final List<Item> items;

  DeliveryModel({
    required this.id,
    required this.scheduleId,
    required this.driverId,
    required this.truckId,
    required this.tripName,
    required this.tripNumber,
    required this.status,
    required this.tripDate,
    required this.note,
    required this.attachment,
    required this.driverCoordinates,
    required this.startAt,
    required this.endedAt,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.weightOfMaterials,
    required this.customer,
    required this.coordinate,
    required this.tripWeight,
    required this.items,
  });

  factory DeliveryModel.fromJson(Map<String, dynamic> json) => DeliveryModel(
        id: json["id"],
        scheduleId: json["schedule_id"] ?? 0,
        driverId: json["driver_id"] ?? 0,
        truckId: json["truck_id"] ?? 0,
        tripName: json["trip_name"] ?? "",
        tripNumber: json["trip_number"],
        // tripNumber: int.tryParse(json["trip_number"]) ?? 0,
        status: json["status"] ?? "",
        tripDate: json["trip_date"] ?? "",
        note: json["note"] ?? "",
        attachment: json["attachment"] ?? "",
        driverCoordinates: json["driver_coordinates"],
        startAt: json["start_at"] ?? "",
        endedAt: json["ended_at"] ?? "",
        deletedAt: json["deleted_at"] ?? "",
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        weightOfMaterials: json["weight_of_materials"]?.toDouble(),
        customer: Customeer.fromJson(
          json["customer"] ?? {},
        ),
        coordinate: json["coordinate"] == null
            ? []
            : List<double>.from(
                json["coordinate"].map(
                  (x) => x,
                ),
              ),
        tripWeight: json["tripWeight"]?.toDouble(),
        items: json["items"] == null
            ? []
            : List<Item>.from(
                json["items"].map(
                  (x) => Item.fromJson(
                    x,
                  ),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "schedule_id": scheduleId,
        "driver_id": driverId,
        "truck_id": truckId,
        "trip_name": tripName,
        "trip_number": tripNumber,
        "status": status,
        "trip_date": tripDate,
        "note": note,
        "attachment": attachment,
        "driver_coordinates": driverCoordinates,
        "start_at": startAt,
        "ended_at": endedAt,
        "deleted_at": deletedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "weight_of_materials": weightOfMaterials,
        "customer": customer.toJson(),
        "coordinate": List<dynamic>.from(coordinate.map((x) => x)),
        "tripWeight": tripWeight,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item {
  final int id;
  final String name;
  final double weight;

  Item({
    required this.id,
    required this.name,
    required this.weight,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"] ?? "",
        weight: json["weight"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "weight": weight,
      };
}

class Customeer {
  String name;
  String contact;

  Customeer({
    required this.name,
    required this.contact,
  });

  factory Customeer.fromJson(Map<String, dynamic> json) => Customeer(
        name: json["name"] ?? "",
        contact: json["contact"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "contact": contact,
      };
}
