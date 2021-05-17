import 'package:teamupadmin/Contract/RequestedHackathonDetailsContract.dart';
import 'package:teamupadmin/DependancyInjector/Injector.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/WebService/Repos/Repos.dart';

class RequestedHackathonDetailsPresenter {
  RequestedHackathonDetailsContract _view;
  Repos _repos;

  RequestedHackathonDetailsPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void getDetails(url) {
    _repos
        .getRequestedHackathonDetails(url)
        .then((value) => _view.showSuccess(value))
        .catchError((onError) =>
            _view.showError(new FetchException(onError.toString())));
  }
}
