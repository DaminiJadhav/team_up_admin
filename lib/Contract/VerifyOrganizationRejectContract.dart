import 'package:teamupadmin/Model/VeifryOrganizationRejectModel.dart';
import 'package:teamupadmin/Utils/FetchException.dart';

abstract class VerifyOrganizationRejectContract{
  void showRejectSuccess(VerifyOrganizationRejectResponseModel success);
  void showRejectOnError(FetchException exception);
}