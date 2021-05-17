import 'dart:convert';

class UpdateGlobalPasswordRequestModel {
  int Id;
  String GlobalPassword;
  String CurrentPassword;

  UpdateGlobalPasswordRequestModel(
      {this.Id, this.GlobalPassword, this.CurrentPassword});

  toJson() {
    Map<String, dynamic> map = {
      'ID': Id,
      'GlobalPassword': GlobalPassword,
      'CurrentPassword': CurrentPassword
    };
    return jsonEncode(map);
  }
}

class UpdateGlobalPasswordResponseModel {
  int Status;
  String Message;

  UpdateGlobalPasswordResponseModel({this.Status, this.Message});
}
