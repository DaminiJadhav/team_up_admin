import 'package:teamupadmin/Model/VerifyOraginzationModel.dart';
import 'package:teamupadmin/Utils/FetchException.dart';

abstract class VerifyOrganizationContract{
  void showSuccess(VerifyOrganizationResponseModel success);
  void showError(FetchException exception);
}