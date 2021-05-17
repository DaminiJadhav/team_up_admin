import 'package:teamupadmin/Model/CompletedProjectListModel.dart';
import 'package:teamupadmin/Utils/FetchException.dart';

abstract class CompletedProjectListContract {
  void showSuccess(CompletedProjectListModel responseModel);

  void showError(FetchException exception);
}
