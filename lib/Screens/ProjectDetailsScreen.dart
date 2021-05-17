import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:teamupadmin/Contract/ApproveRequestedContract.dart';
import 'package:teamupadmin/Contract/GetSubmittedProjectDetailsContract.dart';
import 'package:teamupadmin/Model/ApproveProjectModel.dart';
import 'package:teamupadmin/Model/GetSubmittedProjectDetailsModel.dart';
import 'package:teamupadmin/Model/RejectProjectModel.dart';
import 'package:teamupadmin/Presenter/ApproveProjectPresenter.dart';
import 'package:teamupadmin/Presenter/GetSubmittedProjectDetailsPresenter.dart';
import 'package:teamupadmin/SharedPreference/SharedPref.dart';
import 'package:teamupadmin/Utils/CheckInternet.dart';
import 'package:teamupadmin/Utils/Dialogbox/DialogHelper.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/Utils/Progressbar.dart';
import 'package:teamupadmin/Utils/Toast.dart';

class ProjectDetails extends StatefulWidget {
  String pId;

  ProjectDetails(this.pId);

  @override
  _ProjectDetailsState createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails>
    implements GetSubmittedProjectDetailContract, ApproveRequestedContract {
  CheckInternet checkInternet;
  bool isInternetAvailable = false;
  bool isApiCallProcess = false;
  bool isDataLoad = true;
  bool isApproveSuccess = true;

  ApproveRequestedProjectRequestedModel approveRequestModel;
  RejectRequestedProjectRequestdModel rejectRequestModel;

  GetSubmittedProjectDetailsPresenter detailsPresenter;
  ApproveRequestedProjectPresenter approveRequestedProjectPresenter;

  _ProjectDetailsState() {
    detailsPresenter = new GetSubmittedProjectDetailsPresenter(this);
    approveRequestedProjectPresenter =
        new ApproveRequestedProjectPresenter(this);
  }

  List<ProjectTeamList> memberList;
  List<PDetails> projectDetails;

  getOnBack(dynamic value) {
    setState(() {});
    getDetails();
  }

  getDetails() {
    projectDetails = new List();
    memberList = new List();
    checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isInternetAvailable = true;
          isApiCallProcess = true;
        });
        String projectId = widget.pId;
        detailsPresenter.getDetails(
            'ProjectDetails/GetDetailsOfSubmittedProject?ProjectId=$projectId');
      } else {
        setState(() {
          isInternetAvailable = false;
        });
      }
    });
  }

  validateRejectDate() {
    rejectRequestModel = new RejectRequestedProjectRequestdModel();
    rejectRequestModel.userId = Preference.getAdminId().toString();
    rejectRequestModel.projectId = projectDetails[0].ID.toString();
    rejectRequestModel.isAdmin = true;
    rejectRequestModel.rejectReason = "";
    setState(() {
      isApiCallProcess = true;
    });

    approveRequestedProjectPresenter.reject(
        rejectRequestModel, 'ProjectDetails/RejectProject');
  }

  validateApproveData() {
    approveRequestModel = new ApproveRequestedProjectRequestedModel();
    approveRequestModel.projectId = projectDetails[0].ID.toString();
    approveRequestModel.isAdmin = true;
    approveRequestModel.userId = Preference.getAdminId().toString();
    setState(() {
      isApiCallProcess = true;
    });
    approveRequestedProjectPresenter.approve(
        approveRequestModel, 'ProjectDetails/ApproveProject');
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
          title: Text('Project Details'),
        ),
        body: isInternetAvailable
            ? projectDetails.isNotEmpty
                ? Container(
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, left: 16.0),
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      projectDetails[0].projectName,
                                      style: TextStyle(fontSize: 24.0),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, right: 16.0),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Image.asset(
                                      'assets/Icons/chat.png',
                                      height: 50.0,
                                      width: 50.0,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        ProjectAsMemberMainDesign(
                            projectDetails[0].projectName,
                            projectDetails[0].level,
                            projectDetails[0].type,
                            projectDetails[0].deadline,
                            projectDetails[0].field,
                            projectDetails[0].description),
                      ],
                    ),
                  )
                : Container(
                    child: Center(
                      child: Text(isDataLoad
                          ? ''
                          : 'Something went wrong, Please try again later.'),
                    ),
                  )
            : Container(
                child: Center(
                  child: Lottie.asset('assets/lottie/nointernet.json'),
                ),
              ));
  }

  Widget ProjectAsMemberMainDesign(String pHeading, String pLevel, String pType,
      String pDeadline, String pField, String pDesc) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  'Headlines: ',
                  style: TextStyle(fontSize: 18.0),
                ),
                Text(
                  pHeading,
                  style: TextStyle(fontSize: 18.0),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Text(
                        'Level: ',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Text(
                        pLevel,
                        style: TextStyle(fontSize: 16.0),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Text(
                        'Type: ',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Text(
                        pType,
                        style: TextStyle(fontSize: 16.0),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Text(
                        'Deadline: ',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Text(
                        pDeadline != null ? pDeadline : 'NA',
                        style: TextStyle(fontSize: 16.0),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  'Field: ',
                  style: TextStyle(fontSize: 18.0),
                ),
                Text(
                  pField,
                  style: TextStyle(fontSize: 18.0),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Description: ',
                  style: TextStyle(fontSize: 18.0),
                ),
                Expanded(
                  child: Text(
                    pDesc,
                    textAlign: TextAlign.justify,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: pDesc.length > 200 ? true : false,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Theme.of(context).primaryColor)),
                  child: Text('Show more'),
                  onPressed: () {},
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'Group Details:',
                    style: TextStyle(fontSize: 22.0),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              memberList.isNotEmpty
                  ? ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: memberList.length,
                      itemBuilder: (context, index) {
                        return UserDesign(context, memberList[index].name,
                            memberList[index].email, '');
                      })
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Center(
                          child: Text(
                            'Team Not Available',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
          Divider(
            color: Colors.black,
          ),
          Visibility(
            visible: isApproveSuccess,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      checkInternet.check().then((value) {
                        if (value != null && value) {
                          validateRejectDate();
                        } else {
                          ToastMessage().showToast(
                              'Please check your internet connection...');
                        }
                      });
                    },
                    child: Container(
                      height: 40.0,
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                                fontWeight: FontWeight.bold,
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
                      checkInternet.check().then((value) {
                        if (value != null && value) {
                          validateApproveData();
                        } else {
                          ToastMessage().showToast(
                              'Please check your internet connection...');
                        }
                      });
                    },
                    child: Container(
                      height: 40.0,
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget UserDesign(
      BuildContext context, String name, String email, String userName) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {},
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          child:
                              Icon(Icons.account_circle, color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(name),
                              Text(email),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void showError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
      isDataLoad = false;
    });
    ToastMessage().showToast('Something went wrong, Please try again later.');
  }

  @override
  void showSuccess(GetSubmittedProjectDetailsModel detailsModel) {
    setState(() {
      isApiCallProcess = false;
      isDataLoad = false;
    });
    if (detailsModel.status == 0) {
      projectDetails.add(detailsModel.projectDetails);
      memberList.addAll(detailsModel.projectDetails.projectTeamLists);
    } else {
      ToastMessage().showToast(detailsModel.message);
    }
  }

  @override
  void showApproveError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    DialogBoxHelper.Error(context, "Approve Project",
        'Something went wrong, While Approving Project.');
  }

  @override
  void showApproveSuccess(
      ApproveRequestedProjectResponsedModel responsedModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (responsedModel.status == 0) {
      DialogBoxHelper.Success(
          context, "Approve Project", responsedModel.message);
    } else {
      DialogBoxHelper.Error(context, "Approve Project", responsedModel.message);
    }
  }

  @override
  void showRejectError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    DialogBoxHelper.Error(context, "Reject Project",
        'Something went wrong, While Rejecting Project.');
  }

  @override
  void showRejectSuccess(RejectRequestedProjectResponseModel responseModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (responseModel.status == 0) {
      DialogBoxHelper.Success(context, "Reject Project", responseModel.message);
    } else {
      DialogBoxHelper.Error(context, "Reject Project", responseModel.message);
    }
  }
}
