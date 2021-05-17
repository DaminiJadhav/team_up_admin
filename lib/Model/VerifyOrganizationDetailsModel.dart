import 'dart:convert';

VerifyOrganizationDetailsModel verifyOrganizationDetailsModelFromJson(String str) => VerifyOrganizationDetailsModel.fromJson(json.decode(str));

String verifyOrganizationDetailsModelToJson(VerifyOrganizationDetailsModel data) => json.encode(data.toJson());

class VerifyOrganizationDetailsModel {
  VerifyOrganizationDetailsModel({
    this.status,
    this.message,
    this.registerOrganizationDetails,
  });

  int status;
  String message;
  List<RegisterOrganizationDetail> registerOrganizationDetails;

  factory VerifyOrganizationDetailsModel.fromJson(Map<String, dynamic> json) => VerifyOrganizationDetailsModel(
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
    this.aboutUs,
    this.name,
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
  });

  int id;
  String orgName;
  String aboutUs;
  String name;
  String email;
  String phone;
  String website;
  String specialties;
  dynamic establishmentDate;
  String username;
  String address;
  String city;
  String state;
  String country;

  factory RegisterOrganizationDetail.fromJson(Map<String, dynamic> json) => RegisterOrganizationDetail(
    id: json["ID"],
    orgName: json["OrgName"],
    aboutUs: json["About_Us"],
    name: json["TypeName"],
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
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "OrgName": orgName,
    "About_Us": aboutUs,
    "TypeName": name,
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
  };
}
