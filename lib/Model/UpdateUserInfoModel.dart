import 'dart:convert';

class UpdateUserInfoRequestModel {
  String name;
  String username;
  String emailId;
  int Id;

  UpdateUserInfoRequestModel(
      {this.name, this.username, this.emailId,this.Id});

  toJson() {
    Map<String, dynamic> map = {
      'Name': name,
      'Username': username,
      'Email': emailId,
      'ID': Id
    };
    return jsonEncode(map);
  }
}

UpdateUserInfoResponseModel updateUserInfoResponseModelFromJson(String str) => UpdateUserInfoResponseModel.fromJson(json.decode(str));

String updateUserInfoResponseModelToJson(UpdateUserInfoResponseModel data) => json.encode(data.toJson());

class UpdateUserInfoResponseModel {
  UpdateUserInfoResponseModel({
    this.status,
    this.message,
    this.admin,
  });

  int status;
  String message;
  List<Admin> admin;

  factory UpdateUserInfoResponseModel.fromJson(Map<String, dynamic> json) => UpdateUserInfoResponseModel(
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
    this.name,
    this.username,
    this.email,
  });

  String name;
  String username;
  String email;

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
    name: json["Name"],
    username: json["Username"],
    email: json["Email"],
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "Username": username,
    "Email": email,
  };
}
