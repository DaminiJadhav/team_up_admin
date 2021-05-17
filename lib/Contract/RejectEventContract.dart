import 'package:teamupadmin/Model/RejectEventModel.dart';
import 'package:teamupadmin/Utils/FetchException.dart';

abstract class RejectEventContract {
  void showRejectSuccess(RejectEventResponseModel success);

  void showRejectError(FetchException exception);
}
