import 'dart:convert';

class ApproveEventRequestModel {
  int eventId;
  int adminId;

  ApproveEventRequestModel({this.eventId, this.adminId});

  toJson() {
    Map<String, dynamic> map = {'ID': eventId, 'AdminId': adminId};
    return jsonEncode(map);
  }
}

ApproveEventResponseModel approveEventResponseModelFromJson(String str) =>
    ApproveEventResponseModel.fromJson(json.decode(str));

String approveEventResponseModelToJson(ApproveEventResponseModel data) =>
    json.encode(data.toJson());

class ApproveEventResponseModel {
  ApproveEventResponseModel({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory ApproveEventResponseModel.fromJson(Map<String, dynamic> json) =>
      ApproveEventResponseModel(
        status: json["Status"],
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
      };
}
