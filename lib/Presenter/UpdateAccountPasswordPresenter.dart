import 'package:teamupadmin/Contract/UpdateAccountPasswordContract.dart';
import 'package:teamupadmin/DependancyInjector/Injector.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/WebService/Repos/Repos.dart';

class UpdateAccountPasswordPresenter {
  UpdateAccountPasswordContract _view;
  Repos _repos;

  UpdateAccountPasswordPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void updateAccountPassword(UpdateAccountPasswordRequestModel, url) {
    _repos
        .updateAccountPassword(UpdateAccountPasswordRequestModel, url)
        .then((value) => _view.showAccountSuccess(value))
        .catchError((onError) =>
            _view.showAccountError(new FetchException(onError.toString())));
  }
}
