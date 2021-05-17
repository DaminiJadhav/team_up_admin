// To parse this JSON data, do
//
//     final addProblemStatementRequestModel = addProblemStatementRequestModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

AddProblemStatementRequestModel addProblemStatementRequestModelFromJson(
        String str) =>
    AddProblemStatementRequestModel.fromJson(json.decode(str));

String addProblemStatementRequestModelToJson(
        AddProblemStatementRequestModel data) =>
    json.encode(data.toJson());

class AddProblemStatementRequestModel {
  AddProblemStatementRequestModel({
    this.adminId,
    this.problemStatementHeading,
    this.description,
    this.teamSize,
    this.hackathonId,
  });

  String adminId;
  String problemStatementHeading;
  String description;
  String teamSize;
  String hackathonId;

  factory AddProblemStatementRequestModel.fromJson(Map<String, dynamic> json) =>
      AddProblemStatementRequestModel(
        adminId: json["AdminId"],
        problemStatementHeading: json["ProblemStatementHeading"],
        description: json["Description"],
        teamSize: json["TeamSize"],
        hackathonId: json["HackathonId"],
      );

  Map<String, dynamic> toJson() => {
        "AdminId": adminId,
        "ProblemStatementHeading": problemStatementHeading,
        "Description": description,
        "TeamSize": teamSize,
        "HackathonId": hackathonId,
      };
}

AddProblemStatementResponseModel addProblemStatementResponseModelFromJson(
        String str) =>
    AddProblemStatementResponseModel.fromJson(json.decode(str));

String addProblemStatementResponseModelToJson(
        AddProblemStatementResponseModel data) =>
    json.encode(data.toJson());

class AddProblemStatementResponseModel {
  AddProblemStatementResponseModel({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory AddProblemStatementResponseModel.fromJson(
          Map<String, dynamic> json) =>
      AddProblemStatementResponseModel(
        status: json["Status"],
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
      };
}
