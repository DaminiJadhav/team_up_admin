import 'package:teamupadmin/Contract/VerifiedOrganizationListContract.dart';
import 'package:teamupadmin/DependancyInjector/Injector.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/WebService/Repos/Repos.dart';

class VerifiedOrganizationListPresenter {
  VerifiedOrganizationListContract _view;
  Repos _repos;

  VerifiedOrganizationListPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void getAllVerifiedOrgList(url) {
    _repos
        .getVerifiedOrgList(url)
        .then((value) => _view.showSuccess(value))
        .catchError((onError) =>
            _view.showError(new FetchException(onError.toString())));
  }
}
