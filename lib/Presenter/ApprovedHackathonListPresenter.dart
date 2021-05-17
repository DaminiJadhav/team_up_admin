import 'package:teamupadmin/Contract/ApprovedHackathonListContract.dart';
import 'package:teamupadmin/DependancyInjector/Injector.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/WebService/Repos/Repos.dart';

class ApprovedHackathonListPresenter {
  ApprovedHackathonListContract _view;
  Repos _repos;

  ApprovedHackathonListPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void getApprovedList(url) {
    _repos
        .getApprovedHackathonList(url)
        .then((value) => _view.showSuccess(value))
        .catchError((onError) =>
            _view.showError(new FetchException(onError.toString())));
  }
}
