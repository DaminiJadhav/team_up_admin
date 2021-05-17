// To parse this JSON data, do
//
//     final allRequestedEventsListModel = allRequestedEventsListModelFromJson(jsonString);

import 'dart:convert';

AllRequestedEventsListModel allRequestedEventsListModelFromJson(String str) => AllRequestedEventsListModel.fromJson(json.decode(str));

String allRequestedEventsListModelToJson(AllRequestedEventsListModel data) => json.encode(data.toJson());

class AllRequestedEventsListModel {
  AllRequestedEventsListModel({
    this.status,
    this.message,
    this.event,
  });

  int status;
  String message;
  List<Event> event;

  factory AllRequestedEventsListModel.fromJson(Map<String, dynamic> json) => AllRequestedEventsListModel(
    status: json["Status"],
    message: json["Message"],
    event: List<Event>.from(json["Event"].map((x) => Event.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "Event": List<dynamic>.from(event.map((x) => x.toJson())),
  };
}

class Event {
  Event({
    this.id,
    this.eventName,
    this.publisherName,
    this.posterStatus,
    this.contentStatus,
    this.email,
    this.contactNo,
  });

  int id;
  String eventName;
  String publisherName;
  bool posterStatus;
  bool contentStatus;
  String email;
  String contactNo;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    id: json["ID"],
    eventName: json["EventName"],
    publisherName: json["PublisherName"],
    posterStatus: json["PosterStatus"],
    contentStatus: json["ContentStatus"],
    email: json["Email"],
    contactNo: json["ContactNo"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "EventName": eventName,
    "PublisherName": publisherName,
    "PosterStatus": posterStatus,
    "ContentStatus": contentStatus,
    "Email": email,
    "ContactNo": contactNo,
  };
}
