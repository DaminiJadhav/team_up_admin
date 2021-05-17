import 'package:teamupadmin/Contract/CompletedProjectDetailsContract.dart';
import 'package:teamupadmin/DependancyInjector/Injector.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/WebService/Repos/Repos.dart';

class CompletedProjectDetailsPresenter {
  CompletedProjectDetailsContract _view;
  Repos _repos;

  CompletedProjectDetailsPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void getDetails(url) {
    _repos
        .getCompletedProjectDetails(url)
        .then((value) => _view.showSuccess(value))
        .catchError((onError) =>
            _view.showError(new FetchException(onError.toString())));
  }
}
