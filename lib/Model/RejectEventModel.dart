import 'dart:convert';

class RejectEventRequestModel {
  int eventId;
  int adminId;

  RejectEventRequestModel({this.eventId, this.adminId});

  toJson() {
    Map<String, dynamic> map = {'ID': eventId, 'AdminId': adminId};
    return jsonEncode(map);
  }
}

RejectEventResponseModel rejectEventResponseModelFromJson(String str) =>
    RejectEventResponseModel.fromJson(json.decode(str));

String rejectEventResponseModelToJson(RejectEventResponseModel data) =>
    json.encode(data.toJson());

class RejectEventResponseModel {
  RejectEventResponseModel({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory RejectEventResponseModel.fromJson(Map<String, dynamic> json) =>
      RejectEventResponseModel(
        status: json["Status"],
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
      };
}
