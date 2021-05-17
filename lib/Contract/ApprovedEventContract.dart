import 'package:teamupadmin/Model/ApprovedEventResponseModel.dart';
import 'package:teamupadmin/Utils/FetchException.dart';

abstract class ApprovedEventContract {
  void showSuccess(ApprovedEventResponseModel approvedEventResponseModel);

  void showError(FetchException exception);
}
