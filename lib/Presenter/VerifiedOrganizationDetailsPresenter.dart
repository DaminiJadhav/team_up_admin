import 'package:teamupadmin/Contract/VerifiedOrganizationDetailsContract.dart';
import 'package:teamupadmin/DependancyInjector/Injector.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/WebService/Repos/Repos.dart';

class VerifiedOrganizationDetailsPresenter {
  VerifiedOrganizationDetailsContract _view;
  Repos _repos;

  VerifiedOrganizationDetailsPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void getVerifiedOrgDetails(url) {
    _repos
        .getVerifiedOrgDetails(url)
        .then((value) => _view.showSuccess(value))
        .catchError((onError) =>
            _view.showError(new FetchException(onError.toString())));
  }
}
