import 'dart:convert';

class UpdateAccountPasswordRequestModel{
  int Id;
  String AccountPassword;
  String CurrentPassword;

  UpdateAccountPasswordRequestModel({this.Id, this.AccountPassword,this.CurrentPassword});

  toJson(){
    Map<String,dynamic>map ={
      'ID':Id,
      'AccountPassword' : AccountPassword,
      'CurrentPassword' : CurrentPassword
    };
    return jsonEncode(map);
  }
}
class UpdateAccountPasswordResponseModel{
  int Status;
  String Message;

  UpdateAccountPasswordResponseModel({this.Status, this.Message});
}