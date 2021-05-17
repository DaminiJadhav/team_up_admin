// To parse this JSON data, do
//
//     final verifiedOrganizationDetailsModel = verifiedOrganizationDetailsModelFromJson(jsonString);

import 'dart:convert';

VerifiedOrganizationDetailsModel verifiedOrganizationDetailsModelFromJson(String str) => VerifiedOrganizationDetailsModel.fromJson(json.decode(str));

String verifiedOrganizationDetailsModelToJson(VerifiedOrganizationDetailsModel data) => json.encode(data.toJson());

class VerifiedOrganizationDetailsModel {
  VerifiedOrganizationDetailsModel({
    this.status,
    this.message,
    this.verifiedOrganizations,
  });

  int status;
  String message;
  List<VerifiedOrganization> verifiedOrganizations;

  factory VerifiedOrganizationDetailsModel.fromJson(Map<String, dynamic> json) => VerifiedOrganizationDetailsModel(
    status: json["Status"],
    message: json["Message"],
    verifiedOrganizations: List<VerifiedOrganization>.from(json["VerifiedOrganizations"].map((x) => VerifiedOrganization.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "VerifiedOrganizations": List<dynamic>.from(verifiedOrganizations.map((x) => x.toJson())),
  };
}

class VerifiedOrganization {
  VerifiedOrganization({
    this.name,
    this.id,
    this.orgName,
    this.orgtypename,
    this.email,
    this.phone,
    this.website,
    this.specialties,
    this.establishmentDate,
    this.username,
    this.address,
    this.city,
    this.state,
    this.country,
    this.fromDateContract,
    this.toDateContract,
  });

  String name;
  int id;
  String orgName;
  String orgtypename;
  String email;
  String phone;
  String website;
  String specialties;
  String establishmentDate;
  String username;
  String address;
  String city;
  String state;
  String country;
  String fromDateContract;
  String toDateContract;

  factory VerifiedOrganization.fromJson(Map<String, dynamic> json) => VerifiedOrganization(
    name: json["Name"],
    id: json["ID"],
    orgName: json["OrgName"],
    orgtypename: json["orgtypename"],
    email: json["Email"],
    phone: json["Phone"],
    website: json["Website"],
    specialties: json["Specialties"],
    establishmentDate: json["Establishment_date"],
    username: json["Username"],
    address: json["Address"],
    city: json["City"],
    state: json["State"],
    country: json["Country"],
    fromDateContract: json["FromDateContract"],
    toDateContract: json["ToDateContract"],
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "ID": id,
    "OrgName": orgName,
    "orgtypename": orgtypename,
    "Email": email,
    "Phone": phone,
    "Website": website,
    "Specialties": specialties,
    "Establishment_date": establishmentDate,
    "Username": username,
    "Address": address,
    "City": city,
    "State": state,
    "Country": country,
    "FromDateContract": fromDateContract,
    "ToDateContract": toDateContract,
  };
}
