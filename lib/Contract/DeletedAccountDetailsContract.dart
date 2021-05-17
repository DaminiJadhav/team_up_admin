import 'package:teamupadmin/Model/DeletedAccountDetailsModel.dart';
import 'package:teamupadmin/Utils/FetchException.dart';

abstract class DeletedAccountDetailsContract {
  void showSuccess(DeletedAccountDetailsModel detailsModel);

  void showError(FetchException exception);
}
