import 'package:teamupadmin/Contract/AddProblemStatementContract.dart';
import 'package:teamupadmin/DependancyInjector/Injector.dart';
import 'package:teamupadmin/Model/AddProblemStatementModel.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/WebService/Repos/Repos.dart';

class AddProblemStatementPresenter {
  AddProblemStatementContract _view;
  Repos _repos;

  AddProblemStatementPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void postProblemStatement(AddProblemStatementRequestModel, url) {
    _repos
        .addProblemStatement(AddProblemStatementRequestModel, url)
        .then((value) => _view.showSuccess(value))
        .catchError((onError) =>
            _view.showError(new FetchException(onError.toString())));
  }
}
