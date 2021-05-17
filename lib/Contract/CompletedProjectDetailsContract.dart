import 'package:teamupadmin/Model/CompletedProjectDetailsModel.dart';
import 'package:teamupadmin/Utils/FetchException.dart';

abstract class CompletedProjectDetailsContract {
  void showSuccess(CompletedProjectDetailsModel detailsModel);

  void showError(FetchException exception);
}
