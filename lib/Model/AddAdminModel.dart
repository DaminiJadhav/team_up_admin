import 'dart:convert';

class AddAdminRequestModel {
  String Id;
  String name;
  String username;
  String emailId;
  String password;
  String globalPassword;
  String mobileNumber;
  String adminId;

  AddAdminRequestModel(
      {this.Id,
      this.name,
      this.username,
      this.emailId,
      this.password,
      this.globalPassword,
      this.mobileNumber,
      this.adminId});

  toJson() {
    Map<String, dynamic> map = {
      'ID' : Id,
      'Name': name,
      'Username': username,
      'Email': emailId,
      'AccountPassword': password,
      'GlobalPassword': globalPassword,
      'Phone':mobileNumber,
      'AdminId' : adminId,
    };
    return jsonEncode(map);
  }
}

class AddAdminResponseModel {
  int Status;
  String Message;

  AddAdminResponseModel({this.Status, this.Message});
}
