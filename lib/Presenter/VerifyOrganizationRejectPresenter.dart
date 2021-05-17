import 'package:teamupadmin/Contract/VerifyOrganizationRejectContract.dart';
import 'package:teamupadmin/DependancyInjector/Injector.dart';
import 'package:teamupadmin/Model/VeifryOrganizationRejectModel.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/WebService/Repos/Repos.dart';

class VerifyOrganizationRejectPresenter {
  VerifyOrganizationRejectContract _view;
  Repos _repos;

  VerifyOrganizationRejectPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void rejectOrgContract(VerifyOrganizationRejectRequestModel, url) {
    _repos
        .organizationContractReject(VerifyOrganizationRejectRequestModel, url)
        .then((value) => _view.showRejectSuccess(value))
        .catchError((onError) =>
            _view.showRejectOnError(new FetchException(onError.toString())));
  }
}
