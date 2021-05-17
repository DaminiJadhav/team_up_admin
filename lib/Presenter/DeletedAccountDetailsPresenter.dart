import 'package:teamupadmin/Contract/DeletedAccountDetailsContract.dart';
import 'package:teamupadmin/DependancyInjector/Injector.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/WebService/Repos/Repos.dart';

class DeletedAccountDetailsPresenter {
  DeletedAccountDetailsContract _view;
  Repos _repos;

  DeletedAccountDetailsPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void getDetails(url) {
    _repos
        .getDeletedAccountDetails(url)
        .then((value) => _view.showSuccess(value))
        .catchError((onError) =>
            _view.showError(new FetchException(onError.toString())));
  }
}
