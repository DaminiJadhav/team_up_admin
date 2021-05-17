import 'dart:convert';

RequestedHackathonDetailsModel requestedHackathonDetailsModelFromJson(String str) => RequestedHackathonDetailsModel.fromJson(json.decode(str));

String requestedHackathonDetailsModelToJson(RequestedHackathonDetailsModel data) => json.encode(data.toJson());

class RequestedHackathonDetailsModel {
  RequestedHackathonDetailsModel({
    this.status,
    this.message,
    this.hackathonList,
  });

  int status;
  String message;
  HackathonList hackathonList;

  factory RequestedHackathonDetailsModel.fromJson(Map<String, dynamic> json) => RequestedHackathonDetailsModel(
    status: json["Status"],
    message: json["Message"],
    hackathonList: HackathonList.fromJson(json["HackathonList"]),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "HackathonList": hackathonList.toJson(),
  };
}

class HackathonList {
  HackathonList({
    this.hackathonId,
    this.hackathonName,
    this.description,
    this.startDate,
    this.endDate,
    this.companyName,
    this.website,
    this.orgName,
    this.isApproved,
    this.noOfProblemStatement,
  });

  int hackathonId;
  String hackathonName;
  String description;
  String startDate;
  String endDate;
  dynamic companyName;
  dynamic website;
  String orgName;
  bool isApproved;
  List<NoOfProblemStatement> noOfProblemStatement;

  factory HackathonList.fromJson(Map<String, dynamic> json) => HackathonList(
    hackathonId: json["HackathonId"],
    hackathonName: json["HackathonName"],
    description: json["Description"],
    startDate: json["StartDate"],
    endDate: json["EndDate"],
    companyName: json["CompanyName"],
    website: json["Website"],
    orgName: json["OrgName"],
    isApproved: json["IsApproved"],
    noOfProblemStatement: List<NoOfProblemStatement>.from(json["NoOfProblemStatement"].map((x) => NoOfProblemStatement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "HackathonId": hackathonId,
    "HackathonName": hackathonName,
    "Description": description,
    "StartDate": startDate,
    "EndDate": endDate,
    "CompanyName": companyName,
    "Website": website,
    "OrgName": orgName,
    "IsApproved": isApproved,
    "NoOfProblemStatement": List<dynamic>.from(noOfProblemStatement.map((x) => x.toJson())),
  };
}

class NoOfProblemStatement {
  NoOfProblemStatement({
    this.problemStatementId,
    this.problemStatementHeading,
    this.teamSize,
  });

  int problemStatementId;
  String problemStatementHeading;
  int teamSize;

  factory NoOfProblemStatement.fromJson(Map<String, dynamic> json) => NoOfProblemStatement(
    problemStatementId: json["ProblemStatementId"],
    problemStatementHeading: json["ProblemStatementHeading"],
    teamSize: json["TeamSize"],
  );

  Map<String, dynamic> toJson() => {
    "ProblemStatementId": problemStatementId,
    "ProblemStatementHeading": problemStatementHeading,
    "TeamSize": teamSize,
  };
}
