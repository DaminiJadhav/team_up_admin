import 'package:teamupadmin/Contract/CompletedProjectDetailsContract.dart';
import 'package:teamupadmin/Contract/CompletedProjectListContract.dart';
import 'package:teamupadmin/DependancyInjector/Injector.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/WebService/Repos/Repos.dart';

class CompletedProjectListPresenter {
  CompletedProjectListContract _view;
  Repos _repos;

  CompletedProjectListPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void getList(url) {
    _repos
        .getCompletedProjectList(url)
        .then((value) => _view.showSuccess(value))
        .catchError((onError) =>
            _view.showError(new FetchException(onError.toString())));
  }
}
