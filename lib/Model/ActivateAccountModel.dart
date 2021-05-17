import 'dart:convert';

ActivateAccountRequestModel activateAccountRequestModelFromJson(String str) =>
    ActivateAccountRequestModel.fromJson(json.decode(str));

String activateAccountRequestModelToJson(ActivateAccountRequestModel data) =>
    json.encode(data.toJson());

class ActivateAccountRequestModel {
  ActivateAccountRequestModel({
    this.adminId,
    this.userId,
    this.isStd,
  });

  String adminId;
  String userId;
  bool isStd;

  factory ActivateAccountRequestModel.fromJson(Map<String, dynamic> json) =>
      ActivateAccountRequestModel(
        adminId: json["AdminId"],
        userId: json["UserId"],
        isStd: json["IsStd"],
      );

  Map<String, dynamic> toJson() => {
        "AdminId": adminId,
        "UserId": userId,
        "IsStd": isStd,
      };
}

ActivateAccountResponseModel activateAccountResponseModelFromJson(String str) =>
    ActivateAccountResponseModel.fromJson(json.decode(str));

String activateAccountResponseModelToJson(ActivateAccountResponseModel data) =>
    json.encode(data.toJson());

class ActivateAccountResponseModel {
  ActivateAccountResponseModel({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory ActivateAccountResponseModel.fromJson(Map<String, dynamic> json) =>
      ActivateAccountResponseModel(
        status: json["Status"],
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
      };
}
