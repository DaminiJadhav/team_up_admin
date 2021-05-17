import 'package:teamupadmin/Model/VerifiedOrganizationDetailsModel.dart';
import 'package:teamupadmin/Utils/FetchException.dart';

abstract class VerifiedOrganizationDetailsContract {
  void showSuccess(VerifiedOrganizationDetailsModel success);

  void showError(FetchException exception);
}
