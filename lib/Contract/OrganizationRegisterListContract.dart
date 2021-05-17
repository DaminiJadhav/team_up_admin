import 'package:teamupadmin/Model/OrganizationRegisterListModel.dart';
import 'package:teamupadmin/Utils/FetchException.dart';

abstract class OrganizationRegisterListContract {
  void showSuccess(OrganizationRegisterListModel success);

  void showError(FetchException exception);
}
