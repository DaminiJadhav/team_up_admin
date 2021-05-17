import 'package:teamupadmin/Contract/DeletedAccountsListContract.dart';
import 'package:teamupadmin/DependancyInjector/Injector.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/WebService/Repos/Repos.dart';

class DeletedAccountsListPresenter {
  DeletedAccountsListContract _view;
  Repos _repos;

  DeletedAccountsListPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void getDeletedAccounts(url) {
    _repos
        .getListDeleted(url)
        .then((value) => _view.showSuccess(value))
        .catchError((onError) =>
            _view.showError(new FetchException(onError.toString())));
  }
}
