import 'dart:convert';

import 'package:smc_flutter/src/constant/app_constant.dart';

ProuteDetailModel prouteDetailModelFromJson(String str) =>
    ProuteDetailModel.fromJson(json.decode(str));

String prouteDetaiModellToJson(ProuteDetailModel data) =>
    json.encode(data.toJson());

class ProuteDetailModel {
  final Route route;
  final List<Pickup> pickups;

  ProuteDetailModel({
    required this.route,
    required this.pickups,
  });

  factory ProuteDetailModel.fromJson(Map<String, dynamic> json) =>
      ProuteDetailModel(
        route: Route.fromJson(json["route"] ?? {}),
        pickups: json["pickups"] == null
            ? []
            : List<Pickup>.from(
                json["pickups"].map(
                  (x) => Pickup.fromJson(
                    x,
                  ),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "route": route.toJson(),
        "pickups": List<dynamic>.from(
          pickups.map(
            (x) => x.toJson(),
          ),
        ),
      };
}

//3rd
class Pickup {
  final int id;
  final int routeId;
  final int driverId;
  final int assetId;
  final int customerId;
  final String status;
  final String notes;
  final dynamic driverCoordinates;
  final List<Materials> materials;
  final Meta emergency;
  final dynamic nBins;
  final String startedAt;
  final String endedAt;
  final dynamic tareWeight;
  final dynamic image;
  final List<double> coordinates; // Changed to List<double>
  final String createdAt;
  final String updatedAt;
  final Customer customer;

  Pickup({
    required this.id,
    required this.routeId,
    required this.driverId,
    required this.assetId,
    required this.customerId,
    required this.status,
    required this.notes,
    required this.driverCoordinates,
    required this.materials,
    required this.emergency,
    required this.nBins,
    required this.startedAt,
    required this.endedAt,
    required this.tareWeight,
    required this.image,
    required this.coordinates,
    required this.createdAt,
    required this.updatedAt,
    required this.customer,
  });

  factory Pickup.fromJson(Map<String, dynamic> json) {
    // Handle coordinates parsing
    List<dynamic> coordinatesJson = json["coordinates"] ?? [];
    List<double> coordinates =
        coordinatesJson.map((e) => (e as num).toDouble()).toList();

    return Pickup(
      id: json["id"],
      routeId: json["route_id"] ?? 0,
      driverId: json["driver_id"] ?? 0,
      assetId: json["asset_id"] ?? 0,
      customerId: json["customer_id"] ?? 0,
      status: json["status"] ?? "",
      driverCoordinates: json["driver_coordinates"] ?? "",
      notes: json["notes"] ?? "",
      materials: List<Materials>.from(
        json["materials"].map(
          (x) => Materials.fromJson(x),
        ),
      ),
      emergency: Meta.fromJson(json["meta"] ?? {}),
      nBins: json["n_bins"],
      tareWeight: json["tare_weight"] ?? "",
      image: json["image"] ?? "",
      coordinates: coordinates,
      startedAt: json["started_at"] ?? "",
      endedAt: json["ended_at"] ?? "",
      createdAt: json["created_at"] ?? "",
      updatedAt: json["updated_at"] ?? "",
      customer: json["customer"] == null
          ? Customer(
              id: 0,
              name: "",
              phoneNumber: "",
              customerImage: AppConstants.profileImage)
          : Customer.fromJson(json["customer"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "route_id": routeId,
        "driver_id": driverId,
        "asset_id": assetId,
        "customer_id": customerId,
        "status": status,
        "started_at": startedAt,
        "ended_at": endedAt,
        "driver_coordinates": driverCoordinates,
        "notes": notes,
        "meta": emergency.toJson(),
        "materials": List<dynamic>.from(materials.map((x) => x.toJson())),
        "n_bins": nBins,
        "tare_weight": tareWeight,
        "image": image,
        "coordinates": coordinates,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "customer": customer.toJson(),
      };
}

//2nd
// class Pickup {
//   final int id;
//   final int routeId;
//   final int driverId;
//   final int assetId;
//   final int customerId;
//   final String status;
//   final String notes;
//   final dynamic driverCoordinates;
//   final List<Materials> materials;
//   final Meta emergency;

//   final dynamic nBins;
//   final String startedAt;
//   final String endedAt;
//   final dynamic tareWeight; // Changed from List<int> to dynamic
//   final dynamic image; // Changed from List<String> to dynamic
//   final dynamic coordinates; // Changed from List<dynamic> to dynamic
//   final String createdAt;
//   final String updatedAt;
//   final Customer customer;

//   Pickup({
//     required this.id,
//     required this.routeId,
//     required this.driverId,
//     required this.assetId,
//     required this.customerId,
//     required this.status,
//     required this.notes,
//     required this.driverCoordinates,
//     required this.materials,
//     required this.emergency,
//     required this.nBins,
//     required this.startedAt,
//     required this.endedAt,
//     required this.tareWeight,
//     required this.image,
//     required this.coordinates,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.customer,
//   });

//   factory Pickup.fromJson(Map<String, dynamic> json) => Pickup(
//         id: json["id"],
//         routeId: json["route_id"] ?? 0,
//         driverId: json["driver_id"] ?? 0,
//         assetId: json["asset_id"] ?? 0,
//         customerId: json["customer_id"] ?? 0,
//         status: json["status"] ?? "",
//         driverCoordinates: json["driver_coordinates"] ?? "",
//         notes: json["notes"] ?? "",
//         materials: List<Materials>.from(
//           json["materials"].map(
//             (x) => Materials.fromJson(x),
//           ),
//         ),
//         emergency: Meta.fromJson(json["meta"] ?? {}),
//         nBins: json["n_bins"],
//         tareWeight: json["tare_weight"] ?? "", // Now accepts any type
//         image: json["image"]?? "", // Now accepts any type
//         coordinates: json["coordinates"] ?? "", // Now accepts any type
//         startedAt: json["started_at"] ?? "",
//         endedAt: json["ended_at"] ?? "",
//         createdAt: json["created_at"] ?? "",
//         updatedAt: json["updated_at"] ?? "",
//         customer: json["customer"] == null
//             ? Customer(
//                 id: 0,
//                 name: "",
//                 phoneNumber: "",
//               )
//             : Customer.fromJson(json["customer"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "route_id": routeId,
//         "driver_id": driverId,
//         "asset_id": assetId,
//         "customer_id": customerId,
//         "status": status,
//         "started_at": startedAt,
//         "ended_at": endedAt,
//         "driver_coordinates": driverCoordinates,
//         "notes": notes,
//         "meta": emergency.toJson(),
//         "materials": List<dynamic>.from(materials.map((x) => x.toJson())),
//         "n_bins": nBins,
//         "tare_weight": tareWeight,
//         "image": image,
//         "coordinates": coordinates,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//         "customer": customer.toJson(),
//       };
// }

// class Pickup {
//   final int id;
//   final int routeId;
//   final int driverId;
//   final int assetId;
//   final int customerId;
//   // final String pickupDate;
//   final String status;
//   final String notes;
//   final dynamic driverCoordinates;
//   final List<Materials> materials;
//   final Meta emergency;

//   final dynamic nBins;
//   final String startedAt;
//   final String endedAt;
//   final List<int> tareWeight;
//   final List<String> image;
//   final List<dynamic> coordinates;
//   final String createdAt;
//   final String updatedAt;
//   final Customer customer;

//   Pickup({
//     required this.id,
//     required this.routeId,
//     required this.driverId,
//     required this.assetId,
//     required this.customerId,
//     // required this.pickupDate,
//     required this.status,
//     required this.notes,
//     required this.driverCoordinates,
//     required this.materials,
//     required this.emergency,
//     required this.nBins,
//     required this.startedAt,
//     required this.endedAt,
//     required this.tareWeight,
//     required this.image,
//     required this.coordinates,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.customer,
//   });

//   factory Pickup.fromJson(Map<String, dynamic> json) => Pickup(
//         id: json["id"],
//         routeId: json["route_id"] ?? 0,
//         driverId: json["driver_id"] ?? 0,
//         assetId: json["asset_id"] ?? 0,
//         customerId: json["customer_id"] ?? 0,
//         // pickupDate: json["pickup_date"] ?? "",
//         status: json["status"] ?? "",
//         driverCoordinates: json["driver_coordinates"],
//         notes: json["notes"] ?? "",
//         materials: List<Materials>.from(
//           json["materials"].map(
//             (x) => Materials.fromJson(
//               x,
//             ),
//           ),
//         ),
//         emergency: Meta.fromJson(json["meta"] ?? {}),
//         nBins: json["n_bins"],
//         tareWeight: json["tare_weight"] == null
//             ? []
//             : List<int>.from(
//                 json["tare_weight"].map(
//                   (x) => x,
//                 ),
//               ),
//         image: json["image"] == null
//             ? []
//             : List<String>.from(
//                 json["image"].map(
//                   (x) => x,
//                 ),
//               ),
//         coordinates: json["coordinates"] == null
//             ? []
//             : List<dynamic>.from(
//                 json["coordinates"].map(
//                   (x) => x,
//                 ),
//               ),
//         startedAt: json["started_at"] ?? "",
//         endedAt: json["ended_at"] ?? "",
//         createdAt: json["created_at"] ?? "",
//         updatedAt: json["updated_at"] ?? "",
//         customer: json["customer"] == null
//             ? Customer(
//                 id: 0,
//                 name: "",
//                 phoneNumber: "",
//               )
//             : Customer.fromJson(
//                 json["customer"],
//               ),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "route_id": routeId,
//         "driver_id": driverId,
//         "asset_id": assetId,
//         "customer_id": customerId,
//         // "pickup_date": pickupDate,
//         "status": status,
//         "started_at": startedAt,
//         "ended_at": endedAt,
//         "driver_coordinates": driverCoordinates,
//         "notes": notes, "meta": emergency.toJson(),

//         "materials": List<dynamic>.from(materials.map((x) => x.toJson())),
//         "n_bins": nBins,
//         "tare_weight": List<dynamic>.from(tareWeight.map((x) => x)),
//         "image": List<dynamic>.from(image.map((x) => x)),
//         "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//         "customer": customer.toJson(),
//       };
// }

class Customer {
  final int id;
  final String name;
  final dynamic phoneNumber;
  final dynamic customerImage;

  Customer({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.customerImage,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        name: json["name"] ?? "",
        phoneNumber: json["phone_number"] ?? "",
        customerImage: json["image"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone_number": phoneNumber,
        "image": customerImage
      };
}

class Route {
  final int id;
  final String name;

  Route({
    required this.id,
    required this.name,
  });

  factory Route.fromJson(Map<String, dynamic> json) => Route(
        id: json["id"],
        name: json["name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Materials {
  final int id;
  final String name;
  final dynamic amount;
  final dynamic rate;
  final String weighingType;

  Materials({
    required this.id,
    required this.name,
    required this.amount,
    required this.rate,
    required this.weighingType,
  });

  factory Materials.fromJson(Map<String, dynamic> json) => Materials(
        id: json["id"],
        name: json["name"] ?? "",
        amount: json["amount"],
        rate: json["rate"],
        weighingType: json["weighing_type"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "amount": amount,
        "rate": rate,
        "weighing_type": weighingType,
      };
}

class Meta {
  final String name;
  final String contact;
  final String extra;

  Meta({
    required this.name,
    required this.contact,
    required this.extra,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        name: json["name"] ?? "",
        contact: json["contact"] ?? " ",
        extra: json["extra"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "contact": contact,
        "extra": extra,
      };
}
