// To parse this JSON data, do
//
//     final organizationRegisterListModel = organizationRegisterListModelFromJson(jsonString);

import 'dart:convert';

OrganizationRegisterListModel organizationRegisterListModelFromJson(String str) => OrganizationRegisterListModel.fromJson(json.decode(str));

String organizationRegisterListModelToJson(OrganizationRegisterListModel data) => json.encode(data.toJson());

class OrganizationRegisterListModel {
  OrganizationRegisterListModel({
    this.status,
    this.message,
    this.registerOrganizationDetails,
  });

  int status;
  String message;
  List<RegisterOrganizationDetail> registerOrganizationDetails;

  factory OrganizationRegisterListModel.fromJson(Map<String, dynamic> json) => OrganizationRegisterListModel(
    status: json["Status"],
    message: json["Message"],
    registerOrganizationDetails: List<RegisterOrganizationDetail>.from(json["RegisterOrganizationDetails"].map((x) => RegisterOrganizationDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "RegisterOrganizationDetails": List<dynamic>.from(registerOrganizationDetails.map((x) => x.toJson())),
  };
}

class RegisterOrganizationDetail {
  RegisterOrganizationDetail({
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

  factory RegisterOrganizationDetail.fromJson(Map<String, dynamic> json) => RegisterOrganizationDetail(
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
