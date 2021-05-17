import 'dart:convert';

GetAllAdminResponseModel getAllAdminResponseModelFromJson(String str) => GetAllAdminResponseModel.fromJson(json.decode(str));

String getAllAdminResponseModelToJson(GetAllAdminResponseModel data) => json.encode(data.toJson());

class GetAllAdminResponseModel {
  GetAllAdminResponseModel({
    this.status,
    this.message,
    this.admin,
  });

  int status;
  String message;
  List<Admin> admin;

  factory GetAllAdminResponseModel.fromJson(Map<String, dynamic> json) => GetAllAdminResponseModel(
    status: json["Status"],
    message: json["Message"],
    admin: List<Admin>.from(json["Admin"].map((x) => Admin.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "Admin": List<dynamic>.from(admin.map((x) => x.toJson())),
  };
}

class Admin {
  Admin({
    this.id,
    this.name,
    this.username,
    this.email,
    this.phone,
  });

  int id;
  String name;
  String username;
  String email;
  String phone;

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
    id: json["ID"],
    name: json["Name"],
    username: json["Username"],
    email: json["Email"] == null ? null : json["Email"],
    phone: json["Phone"] == null ? null : json["Phone"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Name": name,
    "Username": username,
    "Email": email == null ? null : email,
    "Phone": phone == null ? null : phone,
  };
}
