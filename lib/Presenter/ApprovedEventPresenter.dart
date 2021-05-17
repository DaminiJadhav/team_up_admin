import 'package:teamupadmin/Contract/ApprovedEventContract.dart';
import 'package:teamupadmin/DependancyInjector/Injector.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/WebService/Repos/Repos.dart';

class ApprovedEventPresenter {
  ApprovedEventContract _view;
  Repos _repos;

  ApprovedEventPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void getApprovedEventList(url) {
    _repos
        .getApprovedEvent(url)
        .then((value) => _view.showSuccess(value))
        .catchError((onError) =>
            _view.showError(new FetchException(onError.toString())));
  }
}
