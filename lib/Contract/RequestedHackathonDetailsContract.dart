import 'package:teamupadmin/Model/RequestedHackathonDetailsModel.dart';
import 'package:teamupadmin/Utils/FetchException.dart';

abstract class RequestedHackathonDetailsContract {
  void showSuccess(RequestedHackathonDetailsModel detailsModel);

  void showError(FetchException exception);
}
