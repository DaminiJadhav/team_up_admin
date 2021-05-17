import 'package:teamupadmin/Contract/ApproveHackathonContrct.dart';
import 'package:teamupadmin/DependancyInjector/Injector.dart';
import 'package:teamupadmin/Model/ApproveHackathonModel.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/WebService/Repos/Repos.dart';

class ApproveHackathonPresenter {
  ApproveHackathonContrct _view;
  Repos _repos;

  ApproveHackathonPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void hackathonApprove(ApproveHackathonRequestModel, url) {
    _repos
        .approveHackathon(ApproveHackathonRequestModel, url)
        .then((value) => _view.showApproveSuccess(value))
        .catchError((onError) =>
            _view.showApproveError(new FetchException(onError.toString())));
  }

  void hackathonReject(ApproveHackathonRequestModel, url) {
    _repos
        .rejectHackathon(ApproveHackathonRequestModel, url)
        .then((value) => _view.showRejectSuccess(value))
        .catchError((onError) =>
            _view.showRejectError(new FetchException(onError.toString())));
  }
}
