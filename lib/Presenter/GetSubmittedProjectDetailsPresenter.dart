import 'package:teamupadmin/Contract/GetSubmittedProjectDetailsContract.dart';
import 'package:teamupadmin/DependancyInjector/Injector.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/WebService/Repos/Repos.dart';

class GetSubmittedProjectDetailsPresenter {
  GetSubmittedProjectDetailContract _view;
  Repos _repos;

  GetSubmittedProjectDetailsPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void getDetails(url) {
    _repos
        .getSubmittedPDetails(url)
        .then((value) => _view.showSuccess(value))
        .catchError((onError) =>
            _view.showError(new FetchException(onError.toString())));
  }
}
