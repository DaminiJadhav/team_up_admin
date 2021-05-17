import 'package:teamupadmin/Contract/ActivateAccountContract.dart';
import 'package:teamupadmin/DependancyInjector/Injector.dart';
import 'package:teamupadmin/Model/ActivateAccountModel.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/WebService/Repos/Repos.dart';

class ActivateAccountPresenter {
  ActivateAccountContract _view;
  Repos _repos;

  ActivateAccountPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void accountActivate(ActivateAccountRequestModel, url) {
    _repos
        .activateAccount(ActivateAccountRequestModel, url)
        .then((value) => _view.showActivateSuccess(value))
        .catchError((onError) =>
            _view.showActivateError(new FetchException(onError.toString())));
  }
}
