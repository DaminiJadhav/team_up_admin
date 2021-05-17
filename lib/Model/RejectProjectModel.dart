import 'dart:convert';

RejectRequestedProjectRequestdModel rejectRequestedProjectRequestdModelFromJson(
        String str) =>
    RejectRequestedProjectRequestdModel.fromJson(json.decode(str));

String rejectRequestedProjectRequestdModelToJson(
        RejectRequestedProjectRequestdModel data) =>
    json.encode(data.toJson());

class RejectRequestedProjectRequestdModel {
  RejectRequestedProjectRequestdModel({
    this.projectId,
    this.userId,
    this.isAdmin,
    this.rejectReason,
  });

  String projectId;
  String userId;
  bool isAdmin;
  String rejectReason;

  factory RejectRequestedProjectRequestdModel.fromJson(
          Map<String, dynamic> json) =>
      RejectRequestedProjectRequestdModel(
        projectId: json["ProjectId"],
        userId: json["UserId"],
        isAdmin: json["IsAdmin"],
        rejectReason: json["RejectReason"],
      );

  Map<String, dynamic> toJson() => {
        "ProjectId": projectId,
        "UserId": userId,
        "IsAdmin": isAdmin,
        "RejectReason": rejectReason,
      };
}

RejectRequestedProjectResponseModel rejectRequestedProjectResponseModelFromJson(
        String str) =>
    RejectRequestedProjectResponseModel.fromJson(json.decode(str));

String rejectRequestedProjectResponseModelToJson(
        RejectRequestedProjectResponseModel data) =>
    json.encode(data.toJson());

class RejectRequestedProjectResponseModel {
  RejectRequestedProjectResponseModel({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory RejectRequestedProjectResponseModel.fromJson(
          Map<String, dynamic> json) =>
      RejectRequestedProjectResponseModel(
        status: json["Status"],
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
      };
}
