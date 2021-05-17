import 'package:teamupadmin/Contract/VerifyOrganizationContract.dart';
import 'package:teamupadmin/DependancyInjector/Injector.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/WebService/Repos/Repos.dart';

class VerifyOrganizationPresenter {
  VerifyOrganizationContract _view;
  Repos _repos;

  VerifyOrganizationPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void approveOrg(VerifyOrganizationRequestModel, url) {
    _repos
        .organizationContractApprove(VerifyOrganizationRequestModel, url)
        .then((value) => _view.showSuccess(value))
        .catchError((onError) =>
            _view.showError(new FetchException(onError.toString())));
  }
}
