import 'package:teamupadmin/Contract/UpdateGlobalPasswordContract.dart';
import 'package:teamupadmin/DependancyInjector/Injector.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/WebService/Repos/Repos.dart';

class UpdateGlobalPasswordPresenter {
  UpdateGlobalPasswordContract _view;
  Repos _repos;

  UpdateGlobalPasswordPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void updateGlobalPassword(UpdateGlobalPasswordRequestModel, url) {
    _repos
        .updateGlobalPassword(UpdateGlobalPasswordRequestModel, url)
        .then((value) => _view.showGlobalSuccess(value))
        .catchError((onError) =>
            _view.showGlobalError(new FetchException(onError.toString())));
  }
}
