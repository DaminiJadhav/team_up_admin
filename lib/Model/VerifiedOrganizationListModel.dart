// To parse this JSON data, do
//
//     final verifiedOrganizationListModel = verifiedOrganizationListModelFromJson(jsonString);

import 'dart:convert';

VerifiedOrganizationListModel verifiedOrganizationListModelFromJson(String str) => VerifiedOrganizationListModel.fromJson(json.decode(str));

String verifiedOrganizationListModelToJson(VerifiedOrganizationListModel data) => json.encode(data.toJson());

class VerifiedOrganizationListModel {
  VerifiedOrganizationListModel({
    this.status,
    this.message,
    this.verifiedOrganizations,
  });

  int status;
  String message;
  List<VerifiedOrganization> verifiedOrganizations;

  factory VerifiedOrganizationListModel.fromJson(Map<String, dynamic> json) => VerifiedOrganizationListModel(
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
    this.id,
    this.orgName,
    this.name,
    this.email,
    this.phone,
    this.website,
  });

  int id;
  String orgName;
  String name;
  String email;
  String phone;
  String website;

  factory VerifiedOrganization.fromJson(Map<String, dynamic> json) => VerifiedOrganization(
    id: json["ID"],
    orgName: json["OrgName"],
    name: json["Name"],
    email: json["Email"],
    phone: json["Phone"],
    website: json["Website"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "OrgName": orgName,
    "Name": name,
    "Email": email,
    "Phone": phone,
    "Website": website,
  };
}
