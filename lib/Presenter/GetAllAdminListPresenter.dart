import 'package:teamupadmin/Contract/GetAllAdminListContract.dart';
import 'package:teamupadmin/DependancyInjector/Injector.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/WebService/Repos/Repos.dart';

class GetAllAdminListPresenter {
  GetAllAdminListContract _view;
  Repos _repos;

  GetAllAdminListPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void getAllAdmin(url) {
    _repos
        .getAllAdmin(url)
        .then((value) => _view.showSuccess(value))
        .catchError((onError) =>
            _view.showError(new FetchException(onError.toString())));
  }
}
