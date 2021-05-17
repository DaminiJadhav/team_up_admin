import 'package:teamupadmin/Contract/OrganizationRegisterListContract.dart';
import 'package:teamupadmin/DependancyInjector/Injector.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/WebService/Repos/Repos.dart';

class OrganizationRegisterListPresenter {
  OrganizationRegisterListContract _view;
  Repos _repos;

  OrganizationRegisterListPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void getorgList(url) {
    _repos
        .getRegisterOrgList(url)
        .then((value) => _view.showSuccess(value))
        .catchError((onError) =>
            _view.showError(new FetchException(onError.toString())));
  }
}
