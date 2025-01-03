import 'dart:convert';

DeliveryDetailModel deliveryDetailModelFromJson(String str) =>
    DeliveryDetailModel.fromJson(json.decode(str));

String deliveryDetailModelToJson(DeliveryDetailModel data) =>
    json.encode(data.toJson());

class DeliveryDetailModel {
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
  final dynamic startedAt;
  final dynamic endedAt;
  final String createdAt;
  final String updatedAt;
  final Customers customer;
  final double weightOfMaterials;
  final List<double> coordinate;
  final EmergencyContact emergencyContact;
  final double tripWeight;
  final List<Items> items;

  DeliveryDetailModel({
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
    required this.startedAt,
    required this.endedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.customer,
    required this.weightOfMaterials,
    required this.coordinate,
    required this.emergencyContact,
    required this.tripWeight,
    required this.items,
  });

  factory DeliveryDetailModel.fromJson(Map<String, dynamic> json) =>
      DeliveryDetailModel(
        id: json["id"],
        scheduleId: json["schedule_id"] ?? 0,
        driverId: json["driver_id"] ?? 0,
        truckId: json["truck_id"] ?? 0,
        tripName: json["trip_name"] ?? "",
        tripNumber: json["trip_number"],
        // tripNumber: int.tryParse(json["trip_number"]) ??  0,
        status: json["status"] ?? "",
        tripDate: json["trip_date"] ?? "",
        note: json["note"] ?? "",
        attachment: json["attachment"],
        driverCoordinates: json["driver_coordinates"],
        startedAt: json["started_at"] ?? "",
        endedAt: json["ended_at"] ?? "",
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        customer: Customers.fromJson(
          json["customer"] ?? {},
        ),
        weightOfMaterials: json["weight_of_materials"]?.toDouble(),
        coordinate: json["coordinate"] == null
            ? []
            : List<double>.from(
                json["coordinate"].map(
                  (x) => x.toDouble(),
                ),
              ),
        emergencyContact: EmergencyContact.fromJson(
          json["meta"] ?? {},
        ),
        tripWeight: json["tripWeight"]?.toDouble(),
        items: json["items"] == null
            ? []
            : List<Items>.from(
                json["items"].map(
                  (x) => Items.fromJson(
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
        "started_at": startedAt,
        "ended_at": endedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "customer": customer.toJson(),
        "weight_of_materials": weightOfMaterials,
        "coordinate": List<dynamic>.from(coordinate.map((x) => x)),
        "emergency_contact": emergencyContact.toJson(),
        "tripWeight": tripWeight,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };

  List<Map<String, dynamic>> mapToMaterials() {
    return items.map((item) {
      return {
        "id": item.id,
        "name": item.name,
        "weight": item.weight,
      };
    }).toList();
  }
}

class Customers {
  final String name;
  final String contact;
  final dynamic address;

  Customers({
    required this.name,
    required this.contact,
    required this.address,
  });

  factory Customers.fromJson(Map<String, dynamic> json) => Customers(
        name: json["name"] ?? "",
        contact: json["contact"] ?? "",
        address: json["address"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "contact": contact,
        "address": address,
      };
}

class EmergencyContact {
  final String name;
  final String contact;
  final String message;

  EmergencyContact({
    required this.name,
    required this.contact,
    required this.message,
  });

  factory EmergencyContact.fromJson(Map<String, dynamic> json) =>
      EmergencyContact(
        name: json["name"] ?? "",
        contact: json["contact"] ?? "",
        message: json["extra"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "contact": contact,
        "extra": message,
      };
}

class Items {
  final int id;
  final String name;
  final double weight;

  Items({
    required this.id,
    required this.name,
    required this.weight,
  });

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        id: json["id"],
        name: json["name"],
        weight: json["weight"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "weight": weight,
      };
}
