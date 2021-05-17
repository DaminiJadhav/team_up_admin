import 'package:teamupadmin/Contract/LoginContract.dart';
import 'package:teamupadmin/DependancyInjector/Injector.dart';
import 'package:teamupadmin/Model/LoginModel.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/WebService/Repos/Repos.dart';

class LoginPresenter {
  LoginContract _view;
  Repos _repos;

  LoginPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void login(LoginRequestModel, url) {
    _repos
        .login(LoginRequestModel, url)
        .then((value) => _view.showLoginSucces(value))
        .catchError((onError) =>
            _view.showLoginError(new FetchException(onError.toString())));
  }
}
