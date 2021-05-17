import 'package:teamupadmin/Model/ApproveEventModel.dart';
import 'package:teamupadmin/Utils/FetchException.dart';

abstract class ApproveEventContract {
  void showApproveSuccess(ApproveEventResponseModel success);

  void showApproveError(FetchException exception);
}
