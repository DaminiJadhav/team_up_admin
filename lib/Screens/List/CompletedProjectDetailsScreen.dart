import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:teamupadmin/Contract/CompletedProjectDetailsContract.dart';
import 'package:teamupadmin/Model/CompletedProjectDetailsModel.dart';
import 'package:teamupadmin/Presenter/CompletedProjectDetailsPresenter.dart';
import 'package:teamupadmin/Utils/CheckInternet.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/Utils/Progressbar.dart';
import 'package:teamupadmin/Utils/Toast.dart';

class CompletedProjectDetails extends StatefulWidget {
  String pId;

  CompletedProjectDetails(this.pId);

  @override
  _CompletedProjectDetailsState createState() =>
      _CompletedProjectDetailsState();
}

class _CompletedProjectDetailsState extends State<CompletedProjectDetails>
    implements CompletedProjectDetailsContract {
  bool isApiCallProcess = false;
  bool isInternetAvailable = false;
  CheckInternet checkInternet;

  int descriptionLine = 4;
  String buttonText = "Show More";
  bool isShowMoreClick = false;

  CompletedProjectDetailsPresenter detailsPresenter;

  _CompletedProjectDetailsState() {
    detailsPresenter = new CompletedProjectDetailsPresenter(this);
  }

  List<ProjectDetails> projectDetails;
  List<ProjectTeamList> memberList;

  getDetails() {
    projectDetails = new List();
    memberList = new List();
    checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isInternetAvailable = true;
          isApiCallProcess = true;
        });
        String id = widget.pId;
        detailsPresenter.getDetails(
            'ProjectDetails/GetDetailsOfApprovedProject?ProjectId=$id');
      } else {
        setState(() {
          isInternetAvailable = false;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
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
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8.0, left: 16.0),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        projectDetails[0].projectName,
                                        style: TextStyle(fontSize: 24.0),
                                      )),
                                ),
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
                        ProjectAsMemberMainDesign(context),
                      ],
                    ),
                  ),
                )
              : Container(
                  child: Center(
                    child: Text(isApiCallProcess
                        ? ''
                        : "Something went wrong, Please try again later."),
                  ),
                )
          : Container(
              child: Center(
                child: Lottie.asset('assets/lottie/nointernet.json'),
              ),
            ),
    );
  }

  Widget ProjectAsMemberMainDesign(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Text(
                //   'Headlines: ',
                //   style: TextStyle(fontSize: 18.0),
                // ),
                Text(
                  projectDetails[0].projectName,
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
                        projectDetails[0].level,
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
                        projectDetails[0].type,
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
                        projectDetails[0].endDate,
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
                  projectDetails[0].field,
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
                  'Created By Name: ',
                  style: TextStyle(fontSize: 18.0),
                ),
                Expanded(
                  child: Text(
                    projectDetails[0].createdByName !=null ?projectDetails[0].createdByName : 'NA',
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Submitted By Name: ',
                  style: TextStyle(fontSize: 18.0),
                ),
                Expanded(
                  child: Text(
                    projectDetails[0].submittedByName != null
                        ? projectDetails[0].submittedByName
                        : 'NA',
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Approved By Name: ',
                  style: TextStyle(fontSize: 18.0),
                ),
                Expanded(
                  child: Text(
                    projectDetails[0].approvedByName,
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'IsReview: ',
                  style: TextStyle(fontSize: 18.0),
                ),
                Expanded(
                  child: Text(
                    projectDetails[0].isReview != null
                        ? projectDetails[0].isReview ? 'True' : 'False'
                        : 'NA',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
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
                    projectDetails[0].description,
                    textAlign: TextAlign.justify,
                    maxLines: descriptionLine,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: projectDetails[0].description.length > 200 ? true : false,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Theme.of(context).primaryColor)),
                  child: Text(buttonText),
                  onPressed: () {
                    setState(() {
                      isShowMoreClick = !isShowMoreClick;
                    });
                    if (isShowMoreClick) {
                      setState(() {
                        descriptionLine = 50;
                        buttonText = "Show Less";
                      });
                    } else {
                      setState(() {
                        descriptionLine = 4;
                        buttonText = "Show More";
                      });
                    }
                  },
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
                    'Group Details ',
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
                        return UserDesign(
                            context,
                            memberList[index].name,
                            memberList[index].email,
                            memberList[index].imagePath);
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
        ],
      ),
    );
  }

  Widget UserDesign(
      BuildContext context, String name, String email, String imagePath) {
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
    });
    ToastMessage().showToast('Something went wrong, Please try again later.');
  }

  @override
  void showSuccess(CompletedProjectDetailsModel detailsModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (detailsModel.status == 0) {
      projectDetails.add(detailsModel.projectDetails);
      memberList.addAll(detailsModel.projectDetails.projectTeamLists);
    } else {
      ToastMessage().showToast(detailsModel.message);
    }
  }
}
