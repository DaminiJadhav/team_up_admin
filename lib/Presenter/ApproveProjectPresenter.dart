import 'package:teamupadmin/Contract/ApproveRequestedContract.dart';
import 'package:teamupadmin/DependancyInjector/Injector.dart';
import 'package:teamupadmin/Model/ApproveProjectModel.dart';
import 'package:teamupadmin/Model/RejectProjectModel.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/WebService/Repos/Repos.dart';

class ApproveRequestedProjectPresenter {
  ApproveRequestedContract _view;
  Repos _repos;

  ApproveRequestedProjectPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void approve(ApproveRequestedProjectRequestedModel, url) {
    _repos
        .approveProject(ApproveRequestedProjectRequestedModel, url)
        .then((value) => _view.showApproveSuccess(value))
        .catchError((onError) =>
            _view.showApproveError(new FetchException(onError.toString())));
  }

  void reject(RejectRequestedProjectRequestdModel, url) {
    _repos
        .rejectProject(RejectRequestedProjectRequestdModel, url)
        .then((value) => _view.showRejectSuccess(value))
        .catchError((onError) =>
            _view.showRejectError(new FetchException(onError.toString())));
  }
}
