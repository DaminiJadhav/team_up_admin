import 'dart:convert';

ApproveRequestedProjectRequestedModel approveRequestedProjectRequestedModelFromJson(String str) => ApproveRequestedProjectRequestedModel.fromJson(json.decode(str));

String approveRequestedProjectRequestedModelToJson(ApproveRequestedProjectRequestedModel data) => json.encode(data.toJson());

class ApproveRequestedProjectRequestedModel {
  ApproveRequestedProjectRequestedModel({
    this.projectId,
    this.userId,
    this.isAdmin,
  });

  String projectId;
  String userId;
  bool isAdmin;

  factory ApproveRequestedProjectRequestedModel.fromJson(Map<String, dynamic> json) => ApproveRequestedProjectRequestedModel(
    projectId: json["ProjectId"],
    userId: json["UserId"],
    isAdmin: json["IsAdmin"],
  );

  Map<String, dynamic> toJson() => {
    "ProjectId": projectId,
    "UserId": userId,
    "IsAdmin": isAdmin,
  };
}
ApproveRequestedProjectResponsedModel approveRequestedProjectResponsedModelFromJson(String str) => ApproveRequestedProjectResponsedModel.fromJson(json.decode(str));

String approveRequestedProjectResponsedModelToJson(ApproveRequestedProjectResponsedModel data) => json.encode(data.toJson());

class ApproveRequestedProjectResponsedModel {
  ApproveRequestedProjectResponsedModel({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory ApproveRequestedProjectResponsedModel.fromJson(Map<String, dynamic> json) => ApproveRequestedProjectResponsedModel(
    status: json["Status"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
  };
}
