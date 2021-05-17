import 'package:flutter/material.dart';
import 'package:teamupadmin/Contract/LoginContract.dart';
import 'package:teamupadmin/Model/LoginModel.dart';
import 'package:teamupadmin/Presenter/LoginPresenter.dart';
import 'package:teamupadmin/Screens/DashboardScreen.dart';
import 'package:teamupadmin/SharedPreference/SharedPref.dart';
import 'package:teamupadmin/Utils/CheckInternet.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/Utils/Progressbar.dart';
import 'package:teamupadmin/Utils/Toast.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> implements LoginContract {
  LoginPresenter _loginPresenter;
  LoginRequestModel loginRequestModel;
  CheckInternet _checkInternet;

  _LoginState() {
    _loginPresenter = new LoginPresenter(this);
  }

  bool _passwordVisible = true;
  bool isApiCallProcess = false;

  final usernameController = TextEditingController();
  final accountPasswordController = TextEditingController();
  final globalPasswordController = TextEditingController();

  bool userNameValidate = false;
  bool accountPasswordValidate = false;
  bool globalPasswordValidate = false;

  void validateData() {
    setState(() {
      usernameController.text.isEmpty
          ? userNameValidate = true
          : userNameValidate = false;
      accountPasswordController.text.isEmpty
          ? accountPasswordValidate = true
          : accountPasswordValidate = false;
      globalPasswordController.text.isEmpty
          ? globalPasswordValidate = true
          : globalPasswordValidate = false;
    });
    if (userNameValidate == false &&
        accountPasswordValidate == false &&
        globalPasswordValidate == false) {
      _checkInternet.check().then((value) {
        if (value != null && value) {
          setState(() {
            isApiCallProcess = true;
          });
          loginApiCall(
              usernameController.text.trim(),
              accountPasswordController.text.trim(),
              globalPasswordController.text.trim());
        } else {
          ToastMessage().showToast('Please check your internet connection..');
        }
      });
    } else {
      setState(() {
        userNameValidate = true;
        accountPasswordValidate = true;
        globalPasswordValidate = true;
      });
    }
  }

  void loginApiCall(
      String username, String accountPassword, String globalPassword) {
    loginRequestModel.email = username;
    loginRequestModel.accountPassword = accountPassword;
    loginRequestModel.globalPassword = globalPassword;
    loginRequestModel.username = "";
    _loginPresenter.login(loginRequestModel, 'Login/AdminLogin');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkInternet = new CheckInternet();
    loginRequestModel = new LoginRequestModel();
    Preference.init();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressBar(
      child: mainUi(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }

  @override
  Widget mainUi(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        SizedBox(
          height: 100.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32.0),
          child: Text(
            'Login',
            style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal),
          ),
        ),
        SizedBox(
          height: 40.0,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/splashscreen/icon.png'),
            Padding(
              padding:
                  const EdgeInsets.only(left: 32.0, right: 32.0, top: 32.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(color: Theme.of(context).primaryColor),
                )),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        errorText:
                            userNameValidate ? 'Please enter Username' : null,
                        hintText: "Username / Email id",
                        hintStyle: TextStyle(),
                        border: InputBorder.none),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 32.0, right: 32.0, top: 16.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(color: Theme.of(context).primaryColor),
                )),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: accountPasswordController,
                    obscureText: _passwordVisible,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      errorText: accountPasswordValidate
                          ? 'Please enter Account Password'
                          : null,
                      hintText: "Account Password",
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 32.0, right: 32.0, top: 16.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(color: Theme.of(context).primaryColor),
                )),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: globalPasswordController,
                    obscureText: _passwordVisible,
                    decoration: InputDecoration(
                      errorText: globalPasswordValidate
                          ? 'Please enter Global Password'
                          : null,
                      prefixIcon: Icon(Icons.lock),
                      hintText: "Global Password",
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
                validateData();
              },
              child: Container(
                height: 50.0,
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20.0)),
                child: Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ),
              ),
            )
          ],
        )
      ],
    ));
  }

  @override
  void showLoginError(FetchException exception) {
    print('Error');
    setState(() {
      isApiCallProcess = false;
    });
    print(exception);
  }

  @override
  void showLoginSucces(LoginResponseModel loginResponseModel) {
    LoginResponseModel responseModel;
    setState(() {
      isApiCallProcess = false;
      responseModel = loginResponseModel;
    });
    //print(responseModel.organization[0].username);
    if (responseModel.status == 0) {
      ToastMessage().showToast(responseModel.message);
      setState(() {
        Preference.setAdminId(responseModel.organization[0].id);
        Preference.setName(responseModel.organization[0].name);
        Preference.setEmail(responseModel.organization[0].email);
        Preference.setUserName(responseModel.organization[0].username);
        Preference.setIsLogin(true);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Dashboard()));
      });
    } else {
      ToastMessage().showToast(responseModel.message);
    }
  }
}
