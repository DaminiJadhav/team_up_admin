import 'package:teamupadmin/Model/UpdateAccountPasswordModel.dart';
import 'package:teamupadmin/Utils/FetchException.dart';

abstract class UpdateAccountPasswordContract {
  void showAccountSuccess(UpdateAccountPasswordResponseModel success);
  void showAccountError(FetchException exception);
}
