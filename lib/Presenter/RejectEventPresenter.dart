import 'package:teamupadmin/Contract/RejectEventContract.dart';
import 'package:teamupadmin/DependancyInjector/Injector.dart';
import 'package:teamupadmin/Model/RejectEventModel.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/WebService/Repos/Repos.dart';

class RejectEventPresenter {
  RejectEventContract _view;
  Repos _repos;

  RejectEventPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void reject(RejectEventRequestModel, url) {
    _repos
        .rejectEvent(RejectEventRequestModel, url)
        .then((value) => _view.showRejectSuccess(value))
        .catchError((onError) =>
            _view.showRejectError(new FetchException(onError.toString())));
  }
}
