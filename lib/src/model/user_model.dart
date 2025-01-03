// import 'dart:convert';

// UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

// String userModelToJson(UserModel data) => json.encode(data.toJson());

// class UserModel {
//   final int id;
//   final String name;
//   final String email;
//   final dynamic emailVerifiedAt;
//   final int roleId;
//   final int loginAttempts;
//   final String status;
//   final String image;
//   final String phoneNumber;
//   final String city;
//   final String state;
//   final String country;
//   final String zipCode;
//   final String language;
//   final String tfaSecret;
//   final String createdAt;
//   final String updatedAt;

//   UserModel({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.emailVerifiedAt,
//     required this.roleId,
//     required this.loginAttempts,
//     required this.status,
//     required this.image,
//     required this.phoneNumber,
//     required this.city,
//     required this.state,
//     required this.country,
//     required this.zipCode,
//     required this.language,
//     required this.tfaSecret,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
//         id: json["id"] as int,
//         name: json["name"] ?? "",
//         email: json["email"] ?? "",
//         emailVerifiedAt: json["email_verified_at"],
//         roleId: json["role_id"] ?? 0,
//         loginAttempts: json["login_attempts"] ?? 0,
//         status: json["status"] ?? "active",
//         image: json["image"] ?? "",
//         phoneNumber: json["phone_number"] ?? "",
//         city: json["city"] ?? "",
//         state: json["state"] ?? "",
//         country: json["country"] ?? "",
//         zipCode: json["zip_code"] ?? "",
//         language: json["language"] ?? "",
//         tfaSecret: json["tfa_secret"] ?? "",
//         createdAt: json["created_at"] ?? "",
//         updatedAt: json["updated_at"] ?? "",
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "email": email,
//         "email_verified_at": emailVerifiedAt,
//         "role_id": roleId,
//         "login_attempts": loginAttempts,
//         "status": status,
//         "image": image,
//         "phone_number": phoneNumber,
//         "city": city,
//         "state": state,
//         "country": country,
//         "zip_code": zipCode,
//         "language": language,
//         "tfa_secret": tfaSecret,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//       };
// }

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final int id;
  final String name;
  final String email;
  final dynamic emailVerifiedAt;
  final int roleId;
  final int loginAttempts;
  final String status;
  final String image;
  final String phoneNumber;
  final String city;
  final String state;
  final String country;
  final String zipCode;
  final String language;
  final String tfaSecret;
  final String createdAt;
  final String updatedAt;
  final BranchModel? branch;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.roleId,
    required this.loginAttempts,
    required this.status,
    required this.image,
    required this.phoneNumber,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
    required this.language,
    required this.tfaSecret,
    required this.createdAt,
    required this.updatedAt,
    this.branch,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"] as int,
        name: json["name"] ?? "",
        email: json["email"] ?? "",
        emailVerifiedAt: json["email_verified_at"],
        roleId: json["role_id"] ?? 0,
        loginAttempts: json["login_attempts"] ?? 0,
        status: json["status"] ?? "active",
        image: json["image"] ?? "",
        phoneNumber: json["phone_number"] ?? "",
        city: json["city"] ?? "",
        state: json["state"] ?? "",
        country: json["country"] ?? "",
        zipCode: json["zip_code"] ?? "",
        language: json["language"] ?? "",
        tfaSecret: json["tfa_secret"] ?? "",
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        branch: json["branch"] != null
            ? BranchModel.fromJson(json["branch"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "role_id": roleId,
        "login_attempts": loginAttempts,
        "status": status,
        "image": image,
        "phone_number": phoneNumber,
        "city": city,
        "state": state,
        "country": country,
        "zip_code": zipCode,
        "language": language,
        "tfa_secret": tfaSecret,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "branch": branch?.toJson(),
      };
}

class BranchModel {
  final int id;
  final String branchName;
  final String branchCity;
  final String branchState;
  final String branchCountry;
  final String branchZip;
  final String branchEmail;
  final String branchPhone;

  BranchModel({
    required this.id,
    required this.branchName,
    required this.branchCity,
    required this.branchState,
    required this.branchCountry,
    required this.branchZip,
    required this.branchEmail,
    required this.branchPhone,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) => BranchModel(
        id: json["id"] as int,
        branchName: json["branch_name"] ?? "",
        branchCity: json["branch_city"] ?? "",
        branchState: json["branch_state"] ?? "",
        branchCountry: json["branch_country"] ?? "",
        branchZip: json["branch_zip"] ?? "",
        branchEmail: json["branch_email"] ?? "",
        branchPhone: json["branch_phone"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "branch_name": branchName,
        "branch_city": branchCity,
        "branch_state": branchState,
        "branch_country": branchCountry,
        "branch_zip": branchZip,
        "branch_email": branchEmail,
        "branch_phone": branchPhone,
      };
}
