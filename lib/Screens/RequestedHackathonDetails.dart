import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:teamupadmin/Contract/ApproveHackathonContrct.dart';
import 'package:teamupadmin/Contract/RequestedHackathonDetailsContract.dart';
import 'package:teamupadmin/Model/ApproveHackathonModel.dart';
import 'package:teamupadmin/Model/RequestedHackathonDetailsModel.dart';
import 'package:teamupadmin/Presenter/ApproveHackathonPresenter.dart';
import 'package:teamupadmin/Presenter/RequestedHackathonDetailsPresenter.dart';
import 'package:teamupadmin/SharedPreference/SharedPref.dart';
import 'package:teamupadmin/Utils/CheckInternet.dart';
import 'package:teamupadmin/Utils/Dialogbox/DialogHelper.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/Utils/Progressbar.dart';
import 'package:teamupadmin/Utils/Toast.dart';

import 'AddHackathonProblemStatement.dart';
import 'package:url_launcher/url_launcher.dart';

class RequestedHackathonDetails extends StatefulWidget {
  String hackthonId;

  RequestedHackathonDetails(this.hackthonId);

  @override
  _RequestedHackathonDetailsState createState() =>
      _RequestedHackathonDetailsState();
}

class _RequestedHackathonDetailsState extends State<RequestedHackathonDetails>
    implements RequestedHackathonDetailsContract, ApproveHackathonContrct {
  bool isApiCallProcess = false;
  bool isInternetAvailable = false;
  CheckInternet checkInternet;
  bool isDataAvailable = false;

  ApproveHackathonRequestModel requestModel;

  //Presenter
  RequestedHackathonDetailsPresenter presenter;
  ApproveHackathonPresenter approveHackathonPresenter;

  List<HackathonList> detailsList;
  List<NoOfProblemStatement> problemsList;

  _RequestedHackathonDetailsState() {
    presenter = new RequestedHackathonDetailsPresenter(this);
    approveHackathonPresenter = new ApproveHackathonPresenter(this);
  }

  getOnBack(dynamic value) {
    setState(() {});
    getDetails();
  }

  _launchURL(String url) async {
    print(url);
    const newurl = 'https://flutter.dev';
    if (await canLaunch(newurl)) {
      await launch(newurl);
    } else {
      throw 'Could not launch $newurl';
    }
  }

  getDetails() {
    detailsList = new List();
    problemsList = new List();
    checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isInternetAvailable = true;
          isApiCallProcess = true;
        });
        String hId = widget.hackthonId;
        presenter.getDetails(
            'Hackathon/GetHackathonDetailsForAdmin?HackathonId=$hId');
      } else {
        setState(() {
          isInternetAvailable = false;
        });
      }
    });
  }

  validateRejectHackathon() {
    setState(() {
      isApiCallProcess = true;
    });
    requestModel = new ApproveHackathonRequestModel();
    requestModel.adminId = Preference.getAdminId().toString();
    requestModel.hackathonId = widget.hackthonId;
    approveHackathonPresenter.hackathonReject(
        requestModel, 'Hackathon/RejectHackathon');
  }

  validateApproveHackathon() {
    setState(() {
      isApiCallProcess = true;
    });
    requestModel = new ApproveHackathonRequestModel();
    requestModel.adminId = Preference.getAdminId().toString();
    requestModel.hackathonId = widget.hackthonId;
    approveHackathonPresenter.hackathonApprove(
        requestModel, 'Hackathon/ApproveHackathon');
  }

  @override
  void initState() {
    super.initState();
    checkInternet = new CheckInternet();
    getDetails();
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
        title: Text('Details'),
      ),
      body: isInternetAvailable
          ? detailsList.isNotEmpty
              ? Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Center(
                            child: Text(
                              detailsList[0].hackathonName,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                              maxLines: 3,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Center(
                            child: Text(
                              detailsList[0].orgName,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0),
                              maxLines: 3,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 8.0),
                                    child: Text(
                                      'Description',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0,
                                          right: 8.0,
                                          bottom: 8.0,
                                          top: 8.0),
                                      child: Text(
                                        detailsList[0].description,
                                        style: TextStyle(
                                          fontSize: 18.0,
                                        ),
                                        textAlign: TextAlign.justify,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Start Date : ',
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  detailsList[0].startDate,
                                                  style:
                                                      TextStyle(fontSize: 18.0),
                                                  maxLines: 2,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'End Date : ',
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  detailsList[0].endDate,
                                                  style:
                                                      TextStyle(fontSize: 18.0),
                                                  maxLines: 2,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0,
                                        right: 16.0,
                                        top: 8.0,
                                        bottom: 8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Contact No : ',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'NA',
                                            style: TextStyle(fontSize: 16.0),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: isApiCallProcess ? false : detailsList[0].website != null ? true : false,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 50.0,
                                          right: 50.0,
                                          top: 16.0,
                                          bottom: 16.0),
                                      child: GestureDetector(
                                        onTap: () {
                                        //  print(detailsList[0].website);
                                          _launchURL(
                                              detailsList[0].website);
                                        },
                                        child: Container(
                                          height: 50.0,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                          child: Center(
                                            child: Text(
                                              'website',
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
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 32.0),
                                    child: Divider(
                                      thickness: 1,
                                    ),
                                  ),
                                  Visibility(
                                    visible: detailsList[0].isApproved,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 8.0, bottom: 8.0),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Problem Statement ',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  detailsList[0].isApproved
                                      ? problemsList.isNotEmpty
                                          ? ListView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: problemsList.length,
                                              itemBuilder: (context, index) {
                                                return ProblemStatementDesign(
                                                    problemsList[index]
                                                        .problemStatementId
                                                        .toString(),
                                                    problemsList[index]
                                                        .problemStatementHeading,
                                                    problemsList[index]
                                                        .teamSize
                                                        .toString());
                                              })
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                child: Center(
                                                  child: Text(
                                                      'Problem Statement not uploaded.'),
                                                ),
                                              ),
                                            )
                                      : Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: GestureDetector(
                                                onTap: () {
                                                  checkInternet
                                                      .check()
                                                      .then((value) {
                                                    if (value != null &&
                                                        value) {
                                                      validateRejectHackathon();
                                                    } else {
                                                      ToastMessage().showToast(
                                                          'Please check your internet connection...');
                                                    }
                                                  });
                                                },
                                                child: Container(
                                                  height: 40.0,
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 20.0),
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.close,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(
                                                        width: 10.0,
                                                      ),
                                                      Text(
                                                        'Reject',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20.0),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: GestureDetector(
                                                onTap: () {
                                                  checkInternet
                                                      .check()
                                                      .then((value) {
                                                    if (value != null &&
                                                        value) {
                                                      validateApproveHackathon();
                                                    } else {
                                                      ToastMessage().showToast(
                                                          'Please check your internet connection...');
                                                    }
                                                  });
                                                },
                                                child: Container(
                                                  height: 40.0,
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 20.0),
                                                  decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.verified_user,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(
                                                        width: 10.0,
                                                      ),
                                                      Text(
                                                        'Approve',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20.0),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(
                  child: Center(
                    child: Text(isDataAvailable
                        ? 'Something went wrong, Please try again later.'
                        : 'Loading'),
                  ),
                )
          : Container(
              child: Center(
                child: Lottie.asset('assets/lottie/nointernet.json'),
              ),
            ),
      floatingActionButton: Visibility(
        visible: isApiCallProcess ? false : detailsList[0].isApproved,
        child: FloatingActionButton(
          isExtended: false,
          tooltip: 'Add New Problem Statement',
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (context) =>
                        AddHackathonProblemStatement(widget.hackthonId)))
                .then(getOnBack);
          },
        ),
      ),
    );
  }

  Widget ProblemStatementDesign(
      String pId, String problemStatement, String teamCount) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: GestureDetector(
        onTap: () {
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) => HackathonProblemStatementDetails(pId,widget.hackathonId))).then(getOnBack);
        },
        child: Card(
          elevation: 25.0,
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  problemStatement,
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Team Enrolled : ',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Text(
                        teamCount,
                        style: TextStyle(fontSize: 16.0),
                      )
                    ],
                  )),
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
      isDataAvailable = true;
    });
  }

  @override
  void showSuccess(RequestedHackathonDetailsModel detailsModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (detailsModel.status == 0) {
      detailsList.add(detailsModel.hackathonList);
      problemsList.addAll(detailsModel.hackathonList.noOfProblemStatement);
    } else {
      setState(() {
        isDataAvailable = true;
      });
    }
  }

  @override
  void showApproveError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    DialogBoxHelper.Error(context, 'Approve Hackathon',
        'Something went wrong, While Approving Hackathon.');
  }

  @override
  void showApproveSuccess(ApproveHackathonResponseModel responseModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (responseModel.status == 0) {
      DialogBoxHelper.Success(
          context, 'Approve Hackathon', responseModel.message);
    } else {
      DialogBoxHelper.Error(
          context, 'Approve Hackathon', responseModel.message);
    }
  }

  @override
  void showRejectError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    DialogBoxHelper.Error(context, 'Reject Hackathon',
        'Something went wrong, While Rejecting Hackathon.');
  }

  @override
  void showRejectSuccess(ApproveHackathonResponseModel responseModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (responseModel.status == 0) {
      DialogBoxHelper.Success(
          context, 'Reject Hackathon', responseModel.message);
    } else {
      DialogBoxHelper.Error(context, 'Reject Hackathon', responseModel.message);
    }
  }
}
