import 'package:flutter/material.dart';
import 'package:teamupadmin/Contract/UpdateAccountPasswordContract.dart';
import 'package:teamupadmin/Contract/UpdateGlobalPasswordContract.dart';
import 'package:teamupadmin/Model/UpdateAccountPasswordModel.dart';
import 'package:teamupadmin/Model/UpdateGlobalPasswordModel.dart';
import 'package:teamupadmin/Presenter/UpdateAccountPasswordPresenter.dart';
import 'package:teamupadmin/Presenter/UpdateGlobalPasswordPresenter.dart';
import 'package:teamupadmin/SharedPreference/SharedPref.dart';
import 'package:teamupadmin/Utils/CheckInternet.dart';
import 'package:teamupadmin/Utils/Dialogbox/DialogHelper.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/Utils/Progressbar.dart';
import 'package:teamupadmin/Utils/Toast.dart';

class ChangePassword extends StatefulWidget {
  int passwordType; // password Type 1 for Account Password  password Type 2 for Global Password
  ChangePassword(this.passwordType);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword>
    implements UpdateAccountPasswordContract, UpdateGlobalPasswordContract {
  CheckInternet _checkInternet;

  UpdateAccountPasswordPresenter _accountPasswordPresenter;
  UpdateGlobalPasswordPresenter _globalPasswordPresenter;

  UpdateAccountPasswordRequestModel _updateAccountPasswordRequestModel;
  UpdateGlobalPasswordRequestModel _updateGlobalPasswordRequestModel;

  bool isApiCallInProgress = false;

  String confirmAccountPasswordMsg = 'Please enter Confirm Password';
  String confirmGlobalPasswordMsg = 'Please enter Confirm Password';

  bool _currentAccountPasswordVisible = true;
  bool _newAccountPasswordVisible = true;
  bool _currentGlobalPasswordVisible = true;
  bool _newGlobalPasswordVisible = true;

  final txtGlobalCurrentPasswordController = TextEditingController();
  final txtGlobalNewPasswordController = TextEditingController();
  final txtGlobalConfirmNewPasswordController = TextEditingController();

  bool currentGlobalPasswordValidate = false;
  bool newGlobalPasswordValidate = false;
  bool confirmNewGlobalPasswordValidate = false;
  bool isGlobalPasswordConfirm = false;

  final txtAccountCurrentPasswordController = TextEditingController();
  final txtAccountNewPasswordController = TextEditingController();
  final txtAccountConfirmNewPasswordController = TextEditingController();

  bool currentAccountPasswordValidate = false;
  bool newAccountPasswordValidate = false;
  bool confirmNewAccountPasswordValidate = false;
  bool isAccountPasswordConfirm = false;

  _ChangePasswordState() {
    _accountPasswordPresenter = new UpdateAccountPasswordPresenter(this);
    _globalPasswordPresenter = new UpdateGlobalPasswordPresenter(this);
  }

  void validateAccountPassword() {
    setState(() {
      txtAccountCurrentPasswordController.text.isEmpty
          ? currentAccountPasswordValidate = true
          : currentAccountPasswordValidate = false;
      txtAccountNewPasswordController.text.isEmpty
          ? newAccountPasswordValidate = true
          : newAccountPasswordValidate = false;
      txtAccountConfirmNewPasswordController.text.isEmpty
          ? confirmNewAccountPasswordValidate = true
          : confirmNewAccountPasswordValidate = false;
    });
    if (isAccountPasswordConfirm == true) {
      setState(() {
        isApiCallInProgress = true;
      });
      _callAccountApi(txtAccountCurrentPasswordController.text.trim(),
          txtAccountConfirmNewPasswordController.text.trim());
    } else {
      setState(() {
        confirmAccountPasswordMsg = 'Password does not match.';
        confirmNewAccountPasswordValidate = true;
      });
    }
  }

  void validateGlobalPassword() {
    setState(() {
      txtGlobalCurrentPasswordController.text.isEmpty
          ? currentGlobalPasswordValidate = true
          : currentGlobalPasswordValidate = false;
      txtGlobalNewPasswordController.text.isEmpty
          ? newGlobalPasswordValidate = true
          : newGlobalPasswordValidate = false;
      txtGlobalConfirmNewPasswordController.text.isEmpty
          ? confirmNewGlobalPasswordValidate = true
          : confirmNewGlobalPasswordValidate = false;
    });

    if (isGlobalPasswordConfirm == true) {
      setState(() {
        isApiCallInProgress = true;
      });
      _callGlobalApi(txtGlobalCurrentPasswordController.text.trim(),
          txtGlobalConfirmNewPasswordController.text.trim());
    } else {
      setState(() {
        confirmNewGlobalPasswordValidate = true;
        confirmGlobalPasswordMsg = 'Password does not match.';
      });
    }
  }

  _callAccountApi(String currentPassword, String newPassword) {
    _updateAccountPasswordRequestModel.Id = Preference.getAdminId();
    _updateAccountPasswordRequestModel.CurrentPassword = currentPassword;
    _updateAccountPasswordRequestModel.AccountPassword = newPassword;

    _accountPasswordPresenter.updateAccountPassword(
        _updateAccountPasswordRequestModel, 'Admins/PutAdminAccountPassword');
  }

  _callGlobalApi(String currentPassword, String newPassword) {
    _updateGlobalPasswordRequestModel.Id = Preference.getAdminId();
    _updateGlobalPasswordRequestModel.CurrentPassword = currentPassword;
    _updateGlobalPasswordRequestModel.GlobalPassword = newPassword;

    _globalPasswordPresenter.updateGlobalPassword(
        _updateGlobalPasswordRequestModel, 'Admins/UpdateAdminGlobalPassword');
  }

  @override
  void initState() {
    super.initState();
    _updateAccountPasswordRequestModel =
        new UpdateAccountPasswordRequestModel();
    _updateGlobalPasswordRequestModel = new UpdateGlobalPasswordRequestModel();
    Preference.init();
    _checkInternet = new CheckInternet();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressBar(
      child: mainUi(context),
      inAsyncCall: isApiCallInProgress,
      opacity: 0.3,
    );
  }

  @override
  Widget mainUi(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: SingleChildScrollView(
          child: Container(child: mainDesign(context, widget.passwordType))),
    );
  }

  Widget mainDesign(BuildContext context, int index) {
    if (index == 1) {
      return Container(
        child: Column(
          children: [
            SizedBox(
              height: 50.0,
            ),
            Text(
              'Update Account Password',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
            ),
            SizedBox(
              height: 40.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 32.0, right: 16.0, top: 16.0),
              child: TextField(
                  controller: txtAccountCurrentPasswordController,
                  obscureText: _currentAccountPasswordVisible,
                  decoration: InputDecoration(
                    hintText: 'Current Account Password',
                    labelText: 'Password',
                    hintStyle: TextStyle(color: Colors.black),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _currentAccountPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _currentAccountPasswordVisible =
                              !_currentAccountPasswordVisible;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: new BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                  )),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 32.0, right: 16.0, top: 16.0),
              child: TextField(
                  controller: txtAccountNewPasswordController,
                  obscureText: _newAccountPasswordVisible,
                  decoration: InputDecoration(
                    hintText: 'New Account Password',
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _newAccountPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _newAccountPasswordVisible =
                              !_newAccountPasswordVisible;
                        });
                      },
                    ),
                    hintStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: new BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                  )),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 32.0, right: 16.0, top: 16.0),
              child: TextField(
                  controller: txtAccountConfirmNewPasswordController,
                  obscureText: _newAccountPasswordVisible,
                  onChanged: (text) {
                    if (text == txtAccountNewPasswordController.text) {
                      setState(() {
                        isAccountPasswordConfirm = true;
                        confirmNewAccountPasswordValidate = false;
                      });
                    } else {
                      setState(() {
                        isAccountPasswordConfirm = false;
                        confirmNewAccountPasswordValidate = true;
                        confirmAccountPasswordMsg = 'Password does not match.';
                      });
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Confirm New Account Password',
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _newAccountPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _newAccountPasswordVisible =
                              !_newAccountPasswordVisible;
                        });
                      },
                    ),
                    hintStyle: TextStyle(color: Colors.black),
                    errorText: confirmNewAccountPasswordValidate
                        ? confirmAccountPasswordMsg
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: new BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 32.0, right: 16.0, top: 32.0, bottom: 16.0),
              child: GestureDetector(
                onTap: () {
                  _checkInternet.check().then((value) {
                    if (value != null && value) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      validateAccountPassword();
                    } else {
                      ToastMessage()
                          .showToast('Please check your internet connection..');
                    }
                  });
                },
                child: Container(
                  height: 50.0,
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Center(
                    child: Text(
                      'Save',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
          child: Column(
        children: [
          SizedBox(
            height: 50.0,
          ),
          Text(
            'Update Global Password',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
          ),
          SizedBox(
            height: 40.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 32.0, right: 16.0, top: 16.0),
            child: TextField(
                controller: txtGlobalCurrentPasswordController,
                obscureText: _currentGlobalPasswordVisible,
                decoration: InputDecoration(
                  hintText: 'Current Global Password',
                  labelText: 'Password',
                  hintStyle: TextStyle(color: Colors.black),
                  errorText: currentGlobalPasswordValidate
                      ? 'Please enter Current Global Password'
                      : null,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _currentGlobalPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _currentGlobalPasswordVisible =
                            !_currentGlobalPasswordVisible;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: new BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 32.0, right: 16.0, top: 16.0),
            child: TextField(
                controller: txtGlobalNewPasswordController,
                obscureText: _newGlobalPasswordVisible,
                decoration: InputDecoration(
                  hintText: 'New Global Password',
                  labelText: 'Password',
                  hintStyle: TextStyle(color: Colors.black),
                  errorText: newGlobalPasswordValidate
                      ? 'Please enter New Global Password'
                      : null,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _newGlobalPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _newGlobalPasswordVisible = !_newGlobalPasswordVisible;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: new BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 32.0, right: 16.0, top: 16.0),
            child: TextField(
                controller: txtGlobalConfirmNewPasswordController,
                obscureText: _newGlobalPasswordVisible,
                onChanged: (text) {
                  if (text == txtGlobalNewPasswordController.text) {
                    setState(() {
                      isGlobalPasswordConfirm = true;
                      confirmNewGlobalPasswordValidate = false;
                    });
                  } else {
                    setState(() {
                      isGlobalPasswordConfirm = false;
                      confirmNewGlobalPasswordValidate = true;
                      confirmGlobalPasswordMsg = 'Password does not match.';
                    });
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Confirm New Global Password',
                  labelText: 'Password',
                  hintStyle: TextStyle(color: Colors.black),
                  errorText: confirmNewGlobalPasswordValidate
                      ? confirmGlobalPasswordMsg
                      : null,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _newGlobalPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _newGlobalPasswordVisible = !_newGlobalPasswordVisible;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: new BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 32.0, right: 16.0, top: 32.0, bottom: 16.0),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
                _checkInternet.check().then((value) {
                  if (value != null && value) {
                    validateGlobalPassword();
                  } else {
                    ToastMessage()
                        .showToast('Please check your internet connection..');
                  }
                });
              },
              child: Container(
                height: 50.0,
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20.0)),
                child: Center(
                  child: Text(
                    'Save',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ));
    }
  }

  @override
  void showAccountError(FetchException exception) {
    setState(() {
      isApiCallInProgress = false;
    });

    DialogBoxHelper.Error(context, 'Update Account Password',
        'Something went wrong, Please try again later...');
    ToastMessage().showToast('Something went wrong, please try again later..');
  }

  @override
  void showAccountSuccess(UpdateAccountPasswordResponseModel success) {
    UpdateAccountPasswordResponseModel accountPasswordResponseModel;
    setState(() {
      isApiCallInProgress = false;
      accountPasswordResponseModel = success;
    });
    if (accountPasswordResponseModel.Status == 0) {
      DialogBoxHelper.Success(context, 'Update Account Password',
          'Account Password Updated Successfully..');

      ToastMessage().showToast(accountPasswordResponseModel.Message);
    } else {
      DialogBoxHelper.Error(context, 'Update Account Password',
          'Something went wrong, while Updating Account Password.');
      ToastMessage().showToast(accountPasswordResponseModel.Message);
    }
  }

  @override
  void showGlobalError(FetchException exception) {
    setState(() {
      isApiCallInProgress = false;
    });
    DialogBoxHelper.Error(context, 'Update Global Password',
        'Something went wrong, Please try again later...');
    ToastMessage().showToast('Something went wrong, please try again later..');
  }

  @override
  void showGlobalSuccess(UpdateGlobalPasswordResponseModel success) {
    UpdateGlobalPasswordResponseModel globalPasswordResponseModel;
    setState(() {
      isApiCallInProgress = false;
      globalPasswordResponseModel = success;
    });
    if (globalPasswordResponseModel.Status == 0) {
      DialogBoxHelper.Success(context, 'Update Global Password',
          'Global Password Updated Successfully..');
      ToastMessage().showToast(globalPasswordResponseModel.Message);
    } else {
      DialogBoxHelper.Error(context, 'Update Global Password',
          'Something went wrong, while Updating Global Password.');
      ToastMessage().showToast(globalPasswordResponseModel.Message);
    }
  }
}
