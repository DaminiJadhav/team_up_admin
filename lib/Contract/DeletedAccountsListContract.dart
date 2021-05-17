import 'package:teamupadmin/Model/DeletedAccountsListModel.dart';
import 'package:teamupadmin/Utils/FetchException.dart';

abstract class DeletedAccountsListContract {
  void showSuccess(DeletedAccountsListModel listModel);

  void showError(FetchException exception);
}
