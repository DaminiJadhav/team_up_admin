import 'package:teamupadmin/Model/UnApprovedAllHackathonListModel.dart';
import 'package:teamupadmin/Utils/FetchException.dart';

abstract class UnApprovedAllHackathonListContract {
  void showSuccess(UnApprovedAllHackathonListModel listModel);

  void showError(FetchException exception);
}
