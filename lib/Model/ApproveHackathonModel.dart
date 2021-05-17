// To parse this JSON data, do
//
//     final approveHackathonRequestModel = approveHackathonRequestModelFromJson(jsonString);

import 'dart:convert';

ApproveHackathonRequestModel approveHackathonRequestModelFromJson(String str) =>
    ApproveHackathonRequestModel.fromJson(json.decode(str));

String approveHackathonRequestModelToJson(ApproveHackathonRequestModel data) =>
    json.encode(data.toJson());

class ApproveHackathonRequestModel {
  ApproveHackathonRequestModel({
    this.adminId,
    this.hackathonId,
  });

  String adminId;
  String hackathonId;

  factory ApproveHackathonRequestModel.fromJson(Map<String, dynamic> json) =>
      ApproveHackathonRequestModel(
        adminId: json["AdminId"],
        hackathonId: json["HackathonId"],
      );

  Map<String, dynamic> toJson() => {
        "AdminId": adminId,
        "HackathonId": hackathonId,
      };
}

ApproveHackathonResponseModel approveHackathonResponseModelFromJson(
        String str) =>
    ApproveHackathonResponseModel.fromJson(json.decode(str));

String approveHackathonResponseModelToJson(
        ApproveHackathonResponseModel data) =>
    json.encode(data.toJson());

class ApproveHackathonResponseModel {
  ApproveHackathonResponseModel({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory ApproveHackathonResponseModel.fromJson(Map<String, dynamic> json) =>
      ApproveHackathonResponseModel(
        status: json["Status"],
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
      };
}
