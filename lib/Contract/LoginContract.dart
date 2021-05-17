import 'package:teamupadmin/Model/LoginModel.dart';
import 'package:teamupadmin/Utils/FetchException.dart';

abstract class LoginContract{
  void showLoginSucces(LoginResponseModel loginResponseModel);
  void showLoginError(FetchException exception);
}