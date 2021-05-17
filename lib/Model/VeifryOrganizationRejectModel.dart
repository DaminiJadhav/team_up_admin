import 'dart:convert';

class VerifyOrganizationRejectRequestModel {
  int Id;
  int AdminId;

  VerifyOrganizationRejectRequestModel({this.Id, this.AdminId});

  toJson() {
    Map<String, dynamic> map = {
      'ID': Id,
      'AdminId' : AdminId
    };
    return jsonEncode(map);
  }
}

class VerifyOrganizationRejectResponseModel {
  int Status;
  String Message;

  VerifyOrganizationRejectResponseModel({this.Status, this.Message});
}
