class AdminListModel {
  String name;
  String email;

  AdminListModel({this.name, this.email});

  AdminListModel.fromMap(Map<String, dynamic> map)
      : name = map[''],
        email = map[''];
}
class AdminListResponseModel {
  int Status;
  String Message;
}
