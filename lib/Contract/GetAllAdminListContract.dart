import 'package:teamupadmin/Model/GetAllAdminListModel.dart';
import 'package:teamupadmin/Utils/FetchException.dart';

abstract class GetAllAdminListContract {
  void showSuccess(GetAllAdminResponseModel success);

  void showError(FetchException exception);
}
