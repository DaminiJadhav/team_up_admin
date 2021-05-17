import 'dart:convert';

class LoginRequestModel {
  String email;
  String username;
  String accountPassword;
  String globalPassword;


  LoginRequestModel({this.email,this.username, this.accountPassword, this.globalPassword});

  toJson() {
    Map<String, dynamic> map = {
      'Email' : email,
      'Username': username,
      'AccountPassword': accountPassword,
      'GlobalPassword': globalPassword,

    };
    return jsonEncode(map);
  }
}
// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);



LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  LoginResponseModel({
    this.status,
    this.message,
    this.organization,
  });

  int status;
  String message;
  List<Organization> organization;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    status: json["Status"],
    message: json["Message"],
    organization: List<Organization>.from(json["Organization"].map((x) => Organization.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "Organization": List<dynamic>.from(organization.map((x) => x.toJson())),
  };
}

class Organization {
  Organization({
    this.id,
    this.name,
    this.username,
    this.email,
  });

  int id;
  String name;
  String username;
  String email;

  factory Organization.fromJson(Map<String, dynamic> json) => Organization(
    id: json["ID"],
    name: json["Name"],
    username: json["Username"],
    email: json["Email"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Name": name,
    "Username": username,
    "Email": email,
  };
}

