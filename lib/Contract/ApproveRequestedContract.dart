import 'package:teamupadmin/Model/ApproveProjectModel.dart';
import 'package:teamupadmin/Model/RejectProjectModel.dart';
import 'package:teamupadmin/Utils/FetchException.dart';

abstract class ApproveRequestedContract {
  void showApproveSuccess(ApproveRequestedProjectResponsedModel responsedModel);

  void showApproveError(FetchException exception);

  void showRejectSuccess(RejectRequestedProjectResponseModel responseModel);

  void showRejectError(FetchException exception);
}
