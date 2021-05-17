import 'package:teamupadmin/Model/VerifiedOrganizationListModel.dart';
import 'package:teamupadmin/Utils/FetchException.dart';

abstract class VerifiedOrganizationListContract{
  void showSuccess(VerifiedOrganizationListModel success);
  void showError(FetchException exception);
}