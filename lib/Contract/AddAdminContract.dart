import 'package:teamupadmin/Model/AddAdminModel.dart';
import 'package:teamupadmin/Utils/FetchException.dart';

abstract class AddAdminContract{
  void showSuccess(AddAdminResponseModel responseModel);
  void showError(FetchException exception);
}