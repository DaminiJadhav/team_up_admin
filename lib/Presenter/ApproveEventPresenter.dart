import 'package:teamupadmin/Contract/ApproveEventContract.dart';
import 'package:teamupadmin/DependancyInjector/Injector.dart';
import 'package:teamupadmin/Model/ApproveEventModel.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/WebService/Repos/Repos.dart';

class ApproveEventPresenter {
  ApproveEventContract _view;
  Repos _repos;

  ApproveEventPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void approve(ApproveEventRequestModel, url) {
    _repos
        .approveEvent(ApproveEventRequestModel, url)
        .then((value) => _view.showApproveSuccess(value))
        .catchError((onError) =>
            _view.showApproveError(new FetchException(onError.toString())));
  }
}
