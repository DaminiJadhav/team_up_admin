import 'package:teamupadmin/Contract/GetSubmittedProjectListContract.dart';
import 'package:teamupadmin/DependancyInjector/Injector.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/WebService/Repos/Repos.dart';

class GetSubmittedProjectListPresenter {
  GetSubmittedProjectListContract _view;
  Repos _repos;

  GetSubmittedProjectListPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void getList(url) {
    _repos
        .getSubmittedProjectList(url)
        .then((value) => _view.showSuccess(value))
        .catchError((onError) =>
            _view.showError(new FetchException(onError.toString())));
  }
}
