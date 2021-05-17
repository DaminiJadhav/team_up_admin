import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:teamupadmin/Contract/UpdateUserInfoContract.dart';
import 'package:teamupadmin/Model/UpdateUserInfoModel.dart';
import 'package:teamupadmin/Presenter/UpdateUserInfoPresenter.dart';
import 'package:teamupadmin/Screens/ChangePasswordScreen.dart';
import 'package:teamupadmin/SharedPreference/SharedPref.dart';
import 'package:teamupadmin/Utils/CheckInternet.dart';
import 'package:teamupadmin/Utils/Dialogbox/DialogHelper.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/Utils/Progressbar.dart';
import 'package:teamupadmin/Utils/Toast.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> implements UpdateUserInfoContract {
  bool isEditable = false;
  bool isApiCallProcess = false;

  UpdateUserInfoPresenter userInfoPresenter;
  UpdateUserInfoRequestModel infoRequestModel;
  CheckInternet _checkInternet;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();

  bool validateName = false;
  bool validateEmail = false;
  bool validateUsername = false;

  _ProfileState() {
    userInfoPresenter = new UpdateUserInfoPresenter(this);
  }

  void handleClick(String value) {
    switch (value) {
      case 'Edit Profile':
        // print('Edit Profile');
        setState(() {
          isEditable = true;
        });
        break;
      case 'Change Account Password':
        // print('Change Account Password');
        pageNavigator(1); // password Type 1 for Account Password
        break;
      case 'Change Global Password':
        // print('Change Global Password');
        pageNavigator(2); // password Type 2 for Global Password
        break;
    }
  }

  void pageNavigator(int passwordType) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => ChangePassword(passwordType)));
  }

  @override
  void initState() {
    super.initState();
    Preference.init();
    _checkInternet = new CheckInternet();
    nameController.text = Preference.getName();
    usernameController.text = Preference.getUserName();
    emailController.text = Preference.getEmail();
    infoRequestModel = new UpdateUserInfoRequestModel();
  }

  validateUserInfo() {
    setState(() {
      nameController.text.isEmpty ? validateName = true : validateName = false;
      usernameController.text.isEmpty
          ? validateUsername = true
          : validateUsername = false;
      emailController.text.isEmpty
          ? validateEmail = true
          : validateEmail = false;
    });
    if (EmailValidator.validate(emailController.text)) {
      if (validateName == false &&
          validateUsername == false &&
          validateEmail == false) {
        setState(() {
          isApiCallProcess = true;
        });
        _callUpdateAPI(nameController.text.trim(),
            usernameController.text.trim(), emailController.text.trim());
      } else {
        if (validateName == true) {
          setState(() {
            validateName = true;
          });
        } else if (validateUsername == true) {
          setState(() {
            validateName = true;
          });
        } else if (validateEmail == true) {
          setState(() {
            validateEmail = true;
          });
        }
      }
    } else {
      setState(() {
        validateEmail = true;
      });
    }
  }

  _callUpdateAPI(String name, String username, String email) {
    infoRequestModel.Id = Preference.getAdminId();
    infoRequestModel.name = name;
    infoRequestModel.username = username;
    infoRequestModel.emailId = email;

    userInfoPresenter.updateUserInfo(infoRequestModel, 'Admins/PutAdmin');
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
      appBar: AppBar(
        title: Text('Profile'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Edit Profile',
                'Change Account Password',
                'Change Global Password'
              }.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 40.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: CircleAvatar(
                    radius: 70.0,
                    child: Icon(
                      Icons.account_circle,
                      size: 90.0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'User Info',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 32.0, right: 16.0, top: 16.0, bottom: 8.0),
                child: TextField(
                    controller: nameController,
                    enabled: isEditable,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      labelText: 'Name',
                      hintStyle: TextStyle(color: Colors.black),
                      errorText: validateName ? 'Please enter Name' : null,
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
                    left: 32.0, right: 16.0, top: 8.0, bottom: 8.0),
                child: TextField(
                    controller: usernameController,
                    enabled: isEditable,
                    decoration: InputDecoration(
                      hintText: 'Username',
                      labelText: 'Username',
                      hintStyle: TextStyle(color: Colors.black),
                      errorText:
                          validateUsername ? 'Please enter Username' : null,
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
                    left: 32.0, right: 16.0, top: 8.0, bottom: 16.0),
                child: TextField(
                    controller: emailController,
                    enabled: isEditable,
                    decoration: InputDecoration(
                      hintText: 'Email Id',
                      labelText: 'Email Id',
                      hintStyle: TextStyle(color: Colors.black),
                      errorText: validateEmail ? 'Please enter Email Id' : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: new BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                    )),
              ),
              Visibility(
                visible: isEditable,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 32.0, right: 16.0, top: 16.0, bottom: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      _checkInternet.check().then((value) {
                        if (value != null && value) {
                          validateUserInfo();
                        } else {
                          // ToastMessage().showToast(
                          //     'Please check your internet connection..');
                          DialogBoxHelper.Error(context, 'Internet',
                              'Please check your internet connection..');
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
              ),
              SizedBox(
                height: 16.0,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void showError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    DialogBoxHelper.Error(context, 'User Info Update',
        'Something went wrong, Please try again later...');
  }

  @override
  void showSuccess(UpdateUserInfoResponseModel succee) {
    UpdateUserInfoResponseModel infoResponseModel;
    setState(() {
      isApiCallProcess = false;
      infoResponseModel = succee;
    });
    if (infoResponseModel.status == 0) {
      setState(() {
        isEditable = false;
        Preference.setName(infoResponseModel.admin[0].name);
        Preference.setUserName(infoResponseModel.admin[0].username);
        Preference.setEmail(infoResponseModel.admin[0].email);
      });
      DialogBoxHelper.Success(
          context, 'User Info Update', 'User information updated successfully');
    } else {
      DialogBoxHelper.Error(context, 'User Info Update',
          'Something went wrong, While updating User information..');
    }
  }
}
