import 'package:teamupadmin/Model/VerifyOrganizationDetailsModel.dart';
import 'package:teamupadmin/Utils/FetchException.dart';

abstract class VerifyOrganizationDetailsContract {
  void showSuccessDetails(VerifyOrganizationDetailsModel success);

  void showErrorDetails(FetchException exception);
}
