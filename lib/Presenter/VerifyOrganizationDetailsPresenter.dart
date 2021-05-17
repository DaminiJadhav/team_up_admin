import 'package:teamupadmin/Contract/VerifyOrganizationDetailsContract.dart';
import 'package:teamupadmin/DependancyInjector/Injector.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/WebService/Repos/Repos.dart';

class VerifyOrganizationDetailsPresenter {
  VerifyOrganizationDetailsContract _view;
  Repos _repos;

  VerifyOrganizationDetailsPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void getVerifyOrgDetails(url) {
    _repos
        .getVerifyOrgDetails(url)
        .then((value) => _view.showSuccessDetails(value))
        .catchError((onError) =>
            _view.showErrorDetails(new FetchException(onError.toString())));
  }
}
