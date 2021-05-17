// To parse this JSON data, do
//
//     final unApprovedAllHackathonListModel = unApprovedAllHackathonListModelFromJson(jsonString);

import 'dart:convert';

UnApprovedAllHackathonListModel unApprovedAllHackathonListModelFromJson(String str) => UnApprovedAllHackathonListModel.fromJson(json.decode(str));

String unApprovedAllHackathonListModelToJson(UnApprovedAllHackathonListModel data) => json.encode(data.toJson());

class UnApprovedAllHackathonListModel {
  UnApprovedAllHackathonListModel({
    this.status,
    this.message,
    this.hackathonList,
  });

  int status;
  String message;
  List<HackathonList> hackathonList;

  factory UnApprovedAllHackathonListModel.fromJson(Map<String, dynamic> json) => UnApprovedAllHackathonListModel(
    status: json["Status"],
    message: json["Message"],
    hackathonList: List<HackathonList>.from(json["HackathonList"].map((x) => HackathonList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "HackathonList": List<dynamic>.from(hackathonList.map((x) => x.toJson())),
  };
}

class HackathonList {
  HackathonList({
    this.hackathonId,
    this.hackathonName,
    this.lastDate,
    this.winningPrice,
    this.contactNo,
    this.isApproved,
    this.orgName,
  });

  int hackathonId;
  String hackathonName;
  String lastDate;
  String winningPrice;
  String contactNo;
  bool isApproved;
  String orgName;

  factory HackathonList.fromJson(Map<String, dynamic> json) => HackathonList(
    hackathonId: json["HackathonId"],
    hackathonName: json["HackathonName"],
    lastDate: json["LastDate"],
    winningPrice: json["WinningPrice"] == null ? null : json["WinningPrice"],
    contactNo: json["ContactNo"] == null ? null : json["ContactNo"],
    isApproved: json["IsApproved"],
    orgName: json["OrgName"],
  );

  Map<String, dynamic> toJson() => {
    "HackathonId": hackathonId,
    "HackathonName": hackathonName,
    "LastDate": lastDate,
    "WinningPrice": winningPrice == null ? null : winningPrice,
    "ContactNo": contactNo == null ? null : contactNo,
    "IsApproved": isApproved,
    "OrgName": orgName,
  };
}
