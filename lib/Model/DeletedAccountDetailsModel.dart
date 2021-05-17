import 'dart:convert';

DeletedAccountDetailsModel deletedAccountDetailsModelFromJson(String str) => DeletedAccountDetailsModel.fromJson(json.decode(str));

String deletedAccountDetailsModelToJson(DeletedAccountDetailsModel data) => json.encode(data.toJson());

class DeletedAccountDetailsModel {
  DeletedAccountDetailsModel({
    this.status,
    this.message,
    this.userProfile,
  });

  int status;
  String message;
  List<UserProfile> userProfile;

  factory DeletedAccountDetailsModel.fromJson(Map<String, dynamic> json) => DeletedAccountDetailsModel(
    status: json["Status"],
    message: json["Message"],
    userProfile: List<UserProfile>.from(json["UserProfile"].map((x) => UserProfile.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "UserProfile": List<dynamic>.from(userProfile.map((x) => x.toJson())),
  };
}

class UserProfile {
  UserProfile({
    this.username,
    this.email,
    this.name,
    this.reason,
    this.phone,
    this.imagePath,
    this.id,
    this.isStd,
  });

  String username;
  String email;
  String name;
  String reason;
  String phone;
  dynamic imagePath;
  int id;
  bool isStd;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    username: json["Username"],
    email: json["Email"],
    name: json["Name"],
    reason: json["Reason"],
    phone: json["Phone"],
    imagePath: json["ImagePath"],
    id: json["ID"],
    isStd: json["IsStd"],
  );

  Map<String, dynamic> toJson() => {
    "Username": username,
    "Email": email,
    "Name": name,
    "Reason": reason,
    "Phone": phone,
    "ImagePath": imagePath,
    "ID": id,
    "IsStd": isStd,
  };
}
