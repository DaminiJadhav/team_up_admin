import 'package:teamupadmin/Contract/UnApprovedAllHackathonListContract.dart';
import 'package:teamupadmin/DependancyInjector/Injector.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/WebService/Repos/Repos.dart';

class UnApprovedAllHackathonListPresenter {
  UnApprovedAllHackathonListContract _view;
  Repos _repos;

  UnApprovedAllHackathonListPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void getAllList(url) {
    _repos
        .getRequestedHackathonList(url)
        .then((value) => _view.showSuccess(value))
        .catchError((onError) =>
            _view.showError(new FetchException(onError.toString())));
  }
}
