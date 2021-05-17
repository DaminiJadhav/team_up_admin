import 'package:teamupadmin/Model/GetSubmittedProjectDetailsModel.dart';
import 'package:teamupadmin/Utils/FetchException.dart';

abstract class GetSubmittedProjectDetailContract {
  void showSuccess(GetSubmittedProjectDetailsModel detailsModel);

  void showError(FetchException exception);
}
