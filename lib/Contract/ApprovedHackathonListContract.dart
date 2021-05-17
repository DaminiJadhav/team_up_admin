import 'package:teamupadmin/Model/ApprovedHackathonListModel.dart';
import 'package:teamupadmin/Utils/FetchException.dart';

abstract class ApprovedHackathonListContract {
  void showSuccess(ApprovedHackathonListModel approvedHackathonListModel);

  void showError(FetchException exception);
}
