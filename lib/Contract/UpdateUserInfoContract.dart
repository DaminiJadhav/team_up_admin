import 'package:teamupadmin/Model/UpdateUserInfoModel.dart';
import 'package:teamupadmin/Utils/FetchException.dart';

abstract class UpdateUserInfoContract{
  void showSuccess(UpdateUserInfoResponseModel succee);
  void showError(FetchException exception);
}