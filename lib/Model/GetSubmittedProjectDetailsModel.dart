import 'dart:convert';

GetSubmittedProjectDetailsModel getSubmittedProjectDetailsModelFromJson(
        String str) =>
    GetSubmittedProjectDetailsModel.fromJson(json.decode(str));

String getSubmittedProjectDetailsModelToJson(
        GetSubmittedProjectDetailsModel data) =>
    json.encode(data.toJson());

class GetSubmittedProjectDetailsModel {
  GetSubmittedProjectDetailsModel({
    this.status,
    this.message,
    this.projectDetails,
  });

  int status;
  String message;
  PDetails projectDetails;

  factory GetSubmittedProjectDetailsModel.fromJson(Map<String, dynamic> json) =>
      GetSubmittedProjectDetailsModel(
        status: json["Status"],
        message: json["Message"],
        projectDetails: PDetails.fromJson(json["ProjectDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "ProjectDetails": projectDetails.toJson(),
      };
}

class PDetails {
  PDetails({
    this.ID,
    this.projectName,
    this.level,
    this.type,
    this.deadline,
    this.field,
    this.description,
    this.isApproved,
    this.startDate,
    this.endDate,
    this.isReview,
    this.projectTeamLists,
  });

  int ID;
  String projectName;
  String level;
  String type;
  dynamic deadline;
  String field;
  String description;
  bool isApproved;
  String startDate;
  String endDate;
  bool isReview;
  List<ProjectTeamList> projectTeamLists;

  factory PDetails.fromJson(Map<String, dynamic> json) => PDetails(
        ID: json["ID"],
        projectName: json["ProjectName"],
        level: json["Level"],
        type: json["Type"],
        deadline: json["Deadline"],
        field: json["Field"],
        description: json["Description"],
        isApproved: json["IsApproved"],
        startDate: json["StartDate"],
        endDate: json["EndDate"],
        isReview: json["IsReview"],
        projectTeamLists: List<ProjectTeamList>.from(
            json["ProjectTeamLists"].map((x) => ProjectTeamList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ID": ID,
        "ProjectName": projectName,
        "Level": level,
        "Type": type,
        "Deadline": deadline,
        "Field": field,
        "Description": description,
        "IsApproved": isApproved,
        "StartDate": startDate,
        "EndDate": endDate,
        "IsReview": isReview,
        "ProjectTeamLists":
            List<dynamic>.from(projectTeamLists.map((x) => x.toJson())),
      };
}

class ProjectTeamList {
  ProjectTeamList({
    this.id,
    this.name,
    this.email,
    this.userName,
    this.imagePath,
  });

  int id;
  String name;
  String email;
  dynamic userName;
  String imagePath;

  factory ProjectTeamList.fromJson(Map<String, dynamic> json) =>
      ProjectTeamList(
        id: json["ID"],
        name: json["Name"],
        email: json["Email"],
        userName: json["UserName"],
        imagePath: json["ImagePath"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Name": name,
        "Email": email,
        "UserName": userName,
        "ImagePath": imagePath,
      };
}
