import 'dart:convert';

List<DashboardModel> dashboardModelFromJson(String str) =>
    List<DashboardModel>.from(
        json.decode(str).map((x) => DashboardModel.fromJson(x)));

String dashboardModelToJson(List<DashboardModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DashboardModel {
  final int id;
  final String name;
  final int driverId;
  final int assetId;
  final String description;
  final String status;
  final String startDate;
  final String createdAt;
  final String updatedAt;
  final String type;
  final dynamic driverCoordinates;

  final List<String> customerNames;
  final List<dynamic> amount;
  final List<Schedule> schedule;
  final int scheduleId;
  final int truckId;
  final String tripName;
  final List<String> materialsLoaded;
  final List<int> amountLoaded;
  final dynamic tripNumber;
  final String tripDate;
  final String note;
  final dynamic attachment;

  DashboardModel({
    required this.id,
    required this.name,
    required this.driverId,
    required this.assetId,
    required this.description,
    required this.status,
    required this.startDate,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
    required this.driverCoordinates,
    required this.customerNames,
    required this.amount,
    required this.schedule,
    required this.scheduleId,
    required this.truckId,
    required this.tripName,
    required this.materialsLoaded,
    required this.amountLoaded,
    this.tripNumber,
    required this.tripDate,
    required this.note,
    required this.attachment,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
        id: json["id"],
        name: json["name"] ?? '',
        driverId: json["driver_id"] ?? 0,
        assetId: json["asset_id"] ?? 0,
        description: json["description"] ?? '',
        status: json["status"] ?? '',
        startDate: json["start_date"] ?? '',
        createdAt: json["created_at"] ?? '',
        updatedAt: json["updated_at"] ?? '',
        type: json["type"] ?? '',
        driverCoordinates: json["driver_coordinates"],
        customerNames: json["customer_names"] != null
            ? List<String>.from(
                json["customer_names"].map(
                  (x) => x,
                ),
              )
            : [],
        amount: json["amount"] != null
            ? List<dynamic>.from(json["amount"].map((x) => x))
            : [],
        schedule: json["schedule"] == null
            ? []
            : List<Schedule>.from(
                json["schedule"].map(
                  (x) => Schedule.fromJson(
                    x,
                  ),
                ),
              ),
        scheduleId: json["schedule_id"] ?? 0,
        truckId: json["truck_id"] ?? 0,
        tripName: json["trip_name"] ?? '',
        materialsLoaded: json['materials_loaded'] == null
            ? []
            : List<String>.from(
                json["materials_loaded"].map(
                  (x) => x,
                ),
              ),
        amountLoaded: json["amount_loaded"] == null
            ? []
            : List<int>.from(
                json["amount_loaded"].map(
                  (x) => x,
                ),
              ),
        tripNumber: json["trip_number"],
        tripDate: json["trip_date"] ?? '',
        note: json["note"] ?? "",
        attachment: json["attachment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "driver_id": driverId,
        "asset_id": assetId,
        "description": description,
        "status": status,
        "driver_coordinates": driverCoordinates,
        "start_date": startDate,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "type": type,
        "amount": List<dynamic>.from(amount.map((x) => x)),
        "customer_names": List<dynamic>.from(customerNames.map((x) => x)),
        "schedule": List<dynamic>.from(schedule.map((x) => x.toJson())),
        "schedule_id": scheduleId,
        "truck_id": truckId,
        "trip_name": tripName,
        "materials_loaded": List<dynamic>.from(materialsLoaded.map((x) => x)),
        "amount_loaded": List<dynamic>.from(amountLoaded.map((x) => x)),
        "trip_number": tripNumber,
        "trip_date": tripDate,
        "note": note,
        "attachment": attachment,
      };
}

class Schedule {
  final int id;
  final int routeId;
  final int driverId;
  final int assetId;
  final int customerId;
  final String pickupDate;
  final String status;
  final String notes;
  final List<String> materials;
  final List<int> rate;
  final List<dynamic> amount;
  final List<String> weighingType;
  final String nBins;
  final List<int> tareWeight;
  final List<String> image;
  final List<String> coordinates;
  final String createdAt;
  final String updatedAt;

  Schedule({
    required this.id,
    required this.routeId,
    required this.driverId,
    required this.assetId,
    required this.customerId,
    required this.pickupDate,
    required this.status,
    required this.notes,
    required this.materials,
    required this.rate,
    required this.amount,
    required this.weighingType,
    required this.nBins,
    required this.tareWeight,
    required this.image,
    required this.coordinates,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        id: json["id"],
        routeId: json["route_id"] ?? 0,
        driverId: json["driver_id"] ?? 0,
        assetId: json["asset_id"] ?? 0,
        customerId: json["customer_id"] ?? 0,
        pickupDate: json["pickup_date"] ?? "",
        status: json["status"] ?? "",
        notes: json["notes"] ?? "",
        materials: json['materials'] == null
            ? []
            : List<String>.from(
                json["materials"].map(
                  (x) => x,
                ),
              ),
        rate: json['rate'] == null
            ? []
            : List<int>.from(
                json["rate"].map(
                  (x) => x,
                ),
              ),
        amount: json['amount'] == null
            ? []
            : List<dynamic>.from(
                json["amount"].map(
                  (x) => x,
                ),
              ),
        weighingType: json['weighing_type'] == null
            ? []
            : List<String>.from(
                json["weighing_type"].map(
                  (x) => x,
                ),
              ),
        nBins: json["n_bins"] ?? "",
        tareWeight: json['tare_weight'] == null
            ? []
            : List<int>.from(
                json["tare_weight"].map(
                  (x) => x,
                ),
              ),
        image: json['image'] == null
            ? []
            : List<String>.from(
                json["image"].map(
                  (x) => x,
                ),
              ),
        coordinates: json['coordinates'] == null
            ? []
            : List<String>.from(
                json["coordinates"].map(
                  (x) => x,
                ),
              ),
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "route_id": routeId,
        "driver_id": driverId,
        "asset_id": assetId,
        "customer_id": customerId,
        "pickup_date": pickupDate,
        "status": status,
        "notes": notes,
        "materials": List<dynamic>.from(materials.map((x) => x)),
        "rate": List<dynamic>.from(rate.map((x) => x)),
        "amount": List<dynamic>.from(amount.map((x) => x)),
        "weighing_type": List<dynamic>.from(weighingType.map((x) => x)),
        "n_bins": nBins,
        "tare_weight": List<dynamic>.from(tareWeight.map((x) => x)),
        "image": List<dynamic>.from(image.map((x) => x)),
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
