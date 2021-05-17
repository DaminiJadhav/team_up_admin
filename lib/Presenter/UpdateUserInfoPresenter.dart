import 'package:teamupadmin/Contract/UpdateUserInfoContract.dart';
import 'package:teamupadmin/DependancyInjector/Injector.dart';
import 'package:teamupadmin/Model/UpdateUserInfoModel.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/WebService/Repos/Repos.dart';

class UpdateUserInfoPresenter {
  UpdateUserInfoContract _view;
  Repos _repos;

  UpdateUserInfoPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void updateUserInfo(UpdateUserInfoRequestModel, url) {
    _repos
        .updateUserInfo(UpdateUserInfoRequestModel, url)
        .then((value) => _view.showSuccess(value))
        .catchError((onError) =>
            _view.showError(new FetchException(onError.toString())));
  }
}
