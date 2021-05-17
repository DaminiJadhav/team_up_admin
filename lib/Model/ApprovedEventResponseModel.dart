
import 'dart:convert';

ApprovedEventResponseModel approvedEventResponseModelFromJson(String str) => ApprovedEventResponseModel.fromJson(json.decode(str));

String approvedEventResponseModelToJson(ApprovedEventResponseModel data) => json.encode(data.toJson());

class ApprovedEventResponseModel {
  ApprovedEventResponseModel({
    this.status,
    this.message,
    this.eventList,
  });

  int status;
  String message;
  List<EventList> eventList;

  factory ApprovedEventResponseModel.fromJson(Map<String, dynamic> json) => ApprovedEventResponseModel(
    status: json["Status"],
    message: json["Message"],
    eventList: List<EventList>.from(json["EventList"].map((x) => EventList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "EventList": List<dynamic>.from(eventList.map((x) => x.toJson())),
  };
}

class EventList {
  EventList({
    this.id,
    this.eventName,
    this.approvedDate,
    this.postedDate,
    this.contentStatus,
    this.posterStatus,
    this.posterImage,
    this.content,
  });

  int id;
  String eventName;
  String approvedDate;
  String postedDate;
  bool contentStatus;
  bool posterStatus;
  String posterImage;
  dynamic content;

  factory EventList.fromJson(Map<String, dynamic> json) => EventList(
    id: json["ID"],
    eventName: json["EventName"],
    approvedDate: json["ApprovedDate"],
    postedDate: json["PostedDate"],
    contentStatus: json["ContentStatus"],
    posterStatus: json["PosterStatus"],
    posterImage: json["PosterImage"],
    content: json["Content"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "EventName": eventName,
    "ApprovedDate": approvedDate,
    "PostedDate": postedDate,
    "ContentStatus": contentStatus,
    "PosterStatus": posterStatus,
    "PosterImage": posterImage,
    "Content": content,
  };
}
