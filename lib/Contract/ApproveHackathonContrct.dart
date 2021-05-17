import 'package:teamupadmin/Model/ApproveHackathonModel.dart';
import 'package:teamupadmin/Utils/FetchException.dart';

abstract class ApproveHackathonContrct {
  void showApproveSuccess(ApproveHackathonResponseModel responseModel);

  void showApproveError(FetchException exception);

  void showRejectSuccess(ApproveHackathonResponseModel responseModel);

  void showRejectError(FetchException exception);
}
