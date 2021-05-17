import 'dart:convert';

class VerifyOrganizationRequestModel {
  int Id;
  String fromDate;
  String toDate;
  int AdminId;

  VerifyOrganizationRequestModel({this.Id, this.fromDate, this.toDate,this.AdminId});

  toJson() {
    Map<String, dynamic> map = {
      'ID': Id,
      'FromDateContract': fromDate,
      'ToDateContract': toDate,
      'AdminId' : AdminId
    };
    return jsonEncode(map);
  }
}

class VerifyOrganizationResponseModel {
  int Status;
  String Message;

  VerifyOrganizationResponseModel({this.Status, this.Message});
}
