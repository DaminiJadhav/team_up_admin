// To parse this JSON data, do
//
//     final deletedAccountsListModel = deletedAccountsListModelFromJson(jsonString);

import 'dart:convert';

DeletedAccountsListModel deletedAccountsListModelFromJson(String str) => DeletedAccountsListModel.fromJson(json.decode(str));

String deletedAccountsListModelToJson(DeletedAccountsListModel data) => json.encode(data.toJson());

class DeletedAccountsListModel {
  DeletedAccountsListModel({
    this.status,
    this.message,
    this.deletedAccounts,
  });

  int status;
  String message;
  List<DeletedAccount> deletedAccounts;

  factory DeletedAccountsListModel.fromJson(Map<String, dynamic> json) => DeletedAccountsListModel(
    status: json["Status"],
    message: json["Message"],
    deletedAccounts: List<DeletedAccount>.from(json["DeletedAccounts"].map((x) => DeletedAccount.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "DeletedAccounts": List<dynamic>.from(deletedAccounts.map((x) => x.toJson())),
  };
}

class DeletedAccount {
  DeletedAccount({
    this.id,
    this.name,
    this.username,
    this.mobileNo,
    this.email,
    this.isStd,
  });

  int id;
  String name;
  String username;
  String mobileNo;
  String email;
  bool isStd;

  factory DeletedAccount.fromJson(Map<String, dynamic> json) => DeletedAccount(
    id: json["ID"],
    name: json["Name"],
    username: json["Username"] == null ? null : json["Username"],
    mobileNo: json["MobileNo"],
    email: json["Email"],
    isStd: json["IsStd"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Name": name,
    "Username": username == null ? null : username,
    "MobileNo": mobileNo,
    "Email": email,
    "IsStd": isStd,
  };
}
