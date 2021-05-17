import 'package:teamupadmin/Model/GetSubmittedProjectListModel.dart';
import 'package:teamupadmin/Utils/FetchException.dart';

abstract class GetSubmittedProjectListContract {
  void showSuccess(GetSubmittedProjectListModel listModel);

  void showError(FetchException exception);
}
