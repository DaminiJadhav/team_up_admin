import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:teamupadmin/Contract/AddAdminContract.dart';
import 'package:teamupadmin/Model/AddAdminModel.dart';
import 'package:teamupadmin/Presenter/AddAdminPresenter.dart';
import 'package:teamupadmin/SharedPreference/SharedPref.dart';
import 'package:teamupadmin/Utils/CheckInternet.dart';
import 'package:teamupadmin/Utils/Dialogbox/DialogHelper.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/Utils/Progressbar.dart';
import 'package:teamupadmin/Utils/Toast.dart';

class AddAdmin extends StatefulWidget {
  @override
  _AddAdminState createState() => _AddAdminState();
}

class _AddAdminState extends State<AddAdmin> implements AddAdminContract {
  AddAdminRequestModel addAdminRequestModel;
  AddAdminPresenter _adminPresenter;

  bool _passwordVisible = true;
  bool _accountPassword = true;
  String confirmPasswordErrorMsg = 'Please Confirm Password';
  bool isPasswordConfirm = false;
  bool isApiCallProcess = false;

  CheckInternet _checkInternet;

  final nameController = TextEditingController();
  final userNameController = TextEditingController();
  final emaidIdController = TextEditingController();
  final accountPasswordController = TextEditingController();
  final confirmAccountPasswordController = TextEditingController();
  final globalPasswordController = TextEditingController();
  final mobileNumberController = TextEditingController();

  bool nameValidate = false;
  bool usernameValidate = false;
  bool emailValidate = false;
  bool accountPasswordValidate = false;
  bool confirmAccountPasswordValidate = false;
  bool globalPasswordValidate = false;
  bool mobileNumberValidate = false;

  _AddAdminState() {
    _adminPresenter = new AddAdminPresenter(this);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkInternet = new CheckInternet();
    addAdminRequestModel = new AddAdminRequestModel();
    Preference.init();
  }

  void AddAdmin(String name, String userName, String emailId,
      String mobileNumber, String password, String globalPassword) {
    addAdminRequestModel.name = name;
    addAdminRequestModel.mobileNumber = mobileNumber;
    addAdminRequestModel.username = userName;
    addAdminRequestModel.emailId = emailId;
    addAdminRequestModel.password = password;
    addAdminRequestModel.globalPassword = globalPassword;
    addAdminRequestModel.adminId = Preference.getAdminId().toString();
    setState(() {
      isApiCallProcess = true;
    });
    _adminPresenter.addAdmin(addAdminRequestModel, 'Admins/PostAdmin');
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
    return Container(
      child: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Add New Admin',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
                child: TextField(
                    keyboardType: TextInputType.name,
                    controller: nameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.account_circle),
                      hintText: 'Name',
                      labelText: 'Name',
                      hintStyle: TextStyle(color: Colors.black),
                      errorText: nameValidate ? 'Please enter name' : null,
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
                    left: 16.0, right: 16.0, top: 8.0, bottom: 16.0),
                child: TextField(
                    keyboardType: TextInputType.name,
                    controller: userNameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.account_circle),
                      hintText: 'Username',
                      labelText: 'Username',
                      hintStyle: TextStyle(color: Colors.black),
                      errorText:
                          usernameValidate ? 'Please enter username' : null,
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
                    left: 16.0, right: 16.0, top: 8.0, bottom: 16.0),
                child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emaidIdController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: 'Email Id',
                      labelText: 'Email Id',
                      hintStyle: TextStyle(color: Colors.black),
                      errorText: emailValidate ? 'please enter Email Id' : null,
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
                    left: 16.0, right: 16.0, top: 8.0, bottom: 16.0),
                child: TextField(
                    keyboardType: TextInputType.phone,
                    controller: mobileNumberController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.mobile_screen_share),
                      hintText: 'Mobile Number',
                      labelText: 'Mobile Number',
                      hintStyle: TextStyle(color: Colors.black),
                      errorText: mobileNumberValidate
                          ? 'please enter Mobile Number'
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
                    left: 16.0, right: 16.0, top: 8.0, bottom: 16.0),
                child: TextField(
                    keyboardType: TextInputType.text,
                    controller: accountPasswordController,
                    obscureText: _accountPassword,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      errorText: accountPasswordValidate
                          ? 'Please enter Account Password'
                          : null,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _accountPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _accountPassword = !_accountPassword;
                          });
                        },
                      ),
                      hintText: 'Password',
                      labelText: 'Password',
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
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 8.0, bottom: 16.0),
                child: TextField(
                    keyboardType: TextInputType.text,
                    controller: confirmAccountPasswordController,
                    obscureText: _accountPassword,
                    onChanged: (text) {
                      if (text == accountPasswordController.text) {
                        setState(() {
                          confirmAccountPasswordValidate = false;
                          isPasswordConfirm = true;
                        });
                      } else {
                        setState(() {
                          isPasswordConfirm = false;
                          confirmPasswordErrorMsg = 'Password does not match.';
                          confirmAccountPasswordValidate = true;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      errorText: confirmAccountPasswordValidate
                          ? confirmPasswordErrorMsg
                          : null,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _accountPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _accountPassword = !_accountPassword;
                          });
                        },
                      ),
                      hintText: 'Confirm Password',
                      labelText: 'Confirm Password',
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
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 8.0, bottom: 16.0),
                child: TextField(
                    keyboardType: TextInputType.text,
                    controller: globalPasswordController,
                    obscureText: _passwordVisible,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      errorText: globalPasswordValidate
                          ? 'Please enter Global Password'
                          : null,
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
                      hintText: 'Global Password',
                      labelText: 'Global Password',
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
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 8.0, bottom: 16.0),
                child: GestureDetector(
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
                        'Submit',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void validateData() {
    setState(() {
      nameController.text.isEmpty ? nameValidate = true : nameValidate = false;
      userNameController.text.isEmpty
          ? usernameValidate = true
          : usernameValidate = false;
      emaidIdController.text.isEmpty
          ? emailValidate = true
          : emailValidate = false;
      accountPasswordController.text.isEmpty
          ? accountPasswordValidate = true
          : accountPasswordValidate = false;
      confirmAccountPasswordController.text.isEmpty
          ? confirmAccountPasswordValidate = true
          : confirmAccountPasswordValidate = false;
      globalPasswordController.text.isEmpty
          ? globalPasswordValidate = true
          : globalPasswordValidate = false;
      mobileNumberController.text.isEmpty
          ? mobileNumberValidate = true
          : mobileNumberValidate = false;
    });
    if (nameValidate == false &&
        usernameValidate == false &&
        emailValidate == false &&
        accountPasswordValidate == false &&
        confirmAccountPasswordValidate == false &&
        globalPasswordValidate == false) {
      if (EmailValidator.validate(emaidIdController.text)) {
        if (mobileNumberController.text.length == 10) {
          if (isPasswordConfirm == true) {
            _checkInternet.check().then((value) {
              if (value != null && value) {
                AddAdmin(
                    nameController.text.trim(),
                    userNameController.text.trim(),
                    emaidIdController.text.trim(),
                    mobileNumberController.text.trim(),
                    accountPasswordController.text.trim(),
                    globalPasswordController.text.trim());
              } else {
                ToastMessage()
                    .showToast('Please check your internet connection..');
              }
            });
          } else {
            setState(() {
              confirmPasswordErrorMsg = 'Password does not match.';
              confirmAccountPasswordValidate = true;
            });
          }
        } else {
          setState(() {
            mobileNumberValidate = true;
          });
        }
      } else {
        setState(() {
          emailValidate = true;
        });
      }
    } else {
      setState(() {
        nameController.text.isEmpty
            ? nameValidate = true
            : nameValidate = false;
        userNameController.text.isEmpty
            ? usernameValidate = true
            : usernameValidate = false;
        emaidIdController.text.isEmpty
            ? emailValidate = true
            : emailValidate = false;
        accountPasswordController.text.isEmpty
            ? accountPasswordValidate = true
            : accountPasswordValidate = false;
        confirmAccountPasswordController.text.isEmpty
            ? confirmAccountPasswordValidate = true
            : confirmAccountPasswordValidate = false;
        globalPasswordController.text.isEmpty
            ? globalPasswordValidate = true
            : globalPasswordValidate = false;
      });
    }
  }

  @override
  void showError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    DialogBoxHelper.Error(
        context, 'Failed', 'Something went wrong, Please try again later.');
    ToastMessage().showToast('Something went wrong, Please try again later.');
  }

  @override
  void showSuccess(AddAdminResponseModel responseModel) {
    AddAdminResponseModel addAdminResponseModel;
    setState(() {
      isApiCallProcess = false;
      addAdminResponseModel = responseModel;
    });
    if (addAdminResponseModel.Status == 0) {
      ToastMessage().showToast(addAdminResponseModel.Message);
      DialogBoxHelper.Success(context, 'Success', 'Admin Added Successfully..');
      setState(() {
        nameController.text = '';
        userNameController.text = '';
        emaidIdController.text = '';
        mobileNumberController.text = '';
        accountPasswordController.text = '';
        confirmAccountPasswordController.text = '';
        globalPasswordController.text = '';
      });
    } else {
      DialogBoxHelper.Error(
          context, 'Failed', 'Something went wrong, while adding Admin');
      ToastMessage().showToast(addAdminResponseModel.Message);
    }
  }
}
