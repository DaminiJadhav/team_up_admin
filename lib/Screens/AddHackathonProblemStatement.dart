import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:teamupadmin/Contract/AddProblemStatementContract.dart';
import 'package:teamupadmin/Model/AddProblemStatementModel.dart';
import 'package:teamupadmin/Presenter/AddProblemStatementPresenter.dart';
import 'package:teamupadmin/SharedPreference/SharedPref.dart';
import 'package:teamupadmin/Utils/CheckInternet.dart';
import 'package:teamupadmin/Utils/Dialogbox/DialogHelper.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/Utils/Progressbar.dart';

class AddHackathonProblemStatement extends StatefulWidget {
  String hId;

  AddHackathonProblemStatement(this.hId);

  @override
  _AddHackathonProblemStatementState createState() =>
      _AddHackathonProblemStatementState();
}

class _AddHackathonProblemStatementState
    extends State<AddHackathonProblemStatement>
    implements AddProblemStatementContract {
  bool isApiCallProcess = false;
  bool isInternetAvailable = false;
  CheckInternet checkInternet;

  AddProblemStatementRequestModel requestModel;
  AddProblemStatementPresenter presenter;

  _AddHackathonProblemStatementState() {
    presenter = new AddProblemStatementPresenter(this);
  }

  //Controller
  final heading = TextEditingController();
  final description = TextEditingController();
  final teamSize = TextEditingController();

  //validation
  bool validateHeading = false;
  bool validateDescription = false;
  bool validateTeamSize = false;

  validateData() {
    setState(() {
      heading.text.isEmpty ? validateHeading = true : validateHeading = false;
      description.text.isEmpty
          ? validateDescription = true
          : validateDescription = false;
      teamSize.text.isEmpty
          ? validateTeamSize = true
          : validateTeamSize = false;
    });
    if (!validateHeading && !validateDescription && !validateTeamSize) {
      addProblem();
    }
  }

  addProblem() {
    setState(() {
      isApiCallProcess = true;
    });
    requestModel.hackathonId = widget.hId;
    requestModel.problemStatementHeading = heading.text.toString().trim();
    requestModel.description = description.text.toString().trim();
    requestModel.teamSize = teamSize.text.toString().trim();
    requestModel.adminId = Preference.getAdminId().toString();
    presenter.postProblemStatement(
        requestModel, 'Hackathon/CreateProblemStament');
  }

  @override
  void initState() {
    super.initState();
    requestModel = new AddProblemStatementRequestModel();
    checkInternet = new CheckInternet();
    checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isInternetAvailable = true;
        });
      } else {
        setState(() {
          isInternetAvailable = false;
        });
      }
    });
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
          title: Text('Problem'),
        ),
        body: isInternetAvailable
            ? Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                        child: Center(
                          child: Text(
                            'Add New Problem Statement',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24.0),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 32.0, bottom: 16.0),
                        child: TextField(
                            keyboardType: TextInputType.name,
                            controller: heading,
                            decoration: InputDecoration(
                              hintText: 'Problem Heading',
                              labelText: 'Heading',
                              errorText: validateHeading
                                  ? 'Please enter Problem Heading'
                                  : null,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: new BorderSide(
                                  width: 2.0,
                                ),
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, bottom: 16.0),
                        child: TextField(
                            keyboardType: TextInputType.name,
                            controller: description,
                            maxLines: 4,
                            decoration: InputDecoration(
                              hintText: 'Description',
                              labelText: 'Description',
                              errorText: validateDescription
                                  ? 'Please enter Problem Description'
                                  : null,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: new BorderSide(
                                  width: 2.0,
                                ),
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, bottom: 16.0),
                        child: TextField(
                            controller: teamSize,
                            decoration: InputDecoration(
                              hintText: 'Team Size',
                              labelText: 'Team Size',
                              errorText: validateTeamSize
                                  ? 'Please enter Team Size'
                                  : null,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: new BorderSide(
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
                            checkInternet.check().then((value) {
                              if (value != null && value) {
                                setState(() {
                                  isInternetAvailable = true;
                                });
                                validateData();
                              } else {
                                setState(() {
                                  isInternetAvailable = false;
                                });
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
                ),
              )
            : Container(
                child: Center(
                child: Lottie.asset('assets/lottie/nointernet.json'),
              )));
  }

  @override
  void showError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    DialogBoxHelper.Error(context, 'Add problem Statement',
        'Something went wrong, While adding problem statement');
  }

  @override
  void showSuccess(AddProblemStatementResponseModel responseModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (responseModel.status == 0) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => super.widget));
      DialogBoxHelper.Success(
          context, 'Add problem Statement', responseModel.message);
    } else {
      DialogBoxHelper.Error(
          context, 'Add problem Statement', responseModel.message);
    }
  }
}
