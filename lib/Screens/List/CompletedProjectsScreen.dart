import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:teamupadmin/Contract/CompletedProjectListContract.dart';
import 'package:teamupadmin/Model/CompletedProjectListModel.dart';
import 'package:teamupadmin/Presenter/CompletedProjectListPresenter.dart';
import 'package:teamupadmin/Screens/List/CompletedProjectDetailsScreen.dart';
import 'package:teamupadmin/Utils/CheckInternet.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/Utils/Progressbar.dart';
import 'package:teamupadmin/Utils/Toast.dart';

class CompletedProjects extends StatefulWidget {
  @override
  _CompletedProjectsState createState() => _CompletedProjectsState();
}

class _CompletedProjectsState extends State<CompletedProjects>
    implements CompletedProjectListContract {
  CompletedProjectListPresenter completedProjectListPresenter;

  bool isApiCallProcess = false;
  bool isInternetAvailable = false;
  CheckInternet checkInternet;

  _CompletedProjectsState() {
    completedProjectListPresenter = new CompletedProjectListPresenter(this);
  }

  List<ProjectApprovedList> projectList;

  getOnBack(dynamic value) {
    setState(() {});
    getList();
  }

  getList() {
    projectList = new List();
    checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isInternetAvailable = true;
          isApiCallProcess = true;
        });
        completedProjectListPresenter
            .getList('ProjectDetails/GetListOfApprovedProjects');
      } else {
        setState(() {
          isInternetAvailable = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    checkInternet = new CheckInternet();
    getList();
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
        title: Text('Completed Projects'),
      ),
      body: isInternetAvailable
          ? projectList.isNotEmpty
              ? Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                          child: Center(
                            child: Text(
                              'Completed Projects',
                              style: TextStyle(
                                  fontSize: 24.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Center(
                              child: Text(
                                  'List of all successfully completed projects.')),
                        ),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: projectList.length,
                            itemBuilder: (context, index) {
                              return MainContaintDesign(
                                  projectList[index].id.toString(),
                                  projectList[index].projectname,
                                  projectList[index].approvedDate,
                                  projectList[index].isApprovedByAdmin,
                                  projectList[index].approvedByName);
                            }),
                      ],
                    ),
                  ),
                )
              : Container(
                  child: Center(
                    child: Text(isApiCallProcess
                        ? ''
                        : 'Completed project not available. '),
                  ),
                )
          : Container(
              child: Center(
                child: Lottie.asset('assets/lottie/nointernet.json'),
              ),
            ),
    );
  }

  Widget MainContaintDesign(String pId, String pName, String approvedDate,
      bool isApproveAdmin, String approvedByName) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (context) => CompletedProjectDetails(pId)))
              .then((getOnBack));
        },
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.pages),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            pName,
                            // overflow: TextOverflow.fade,
                            maxLines: 4,
                            // softWrap: false,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24.0),
                          ),
                        ),
                      ),
                    ],
                  )),
              Divider(),
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Text(
                            'Approved Date: ',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            approvedDate,
                            style: TextStyle(fontSize: 16.0),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                child: Row(
                  children: [
                    Text(
                      'Approved By: ',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Text(
                      approvedByName,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 16.0),
                child: Row(
                  children: [
                    Text(
                      'Is Approved By Admin: ',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Text(
                      isApproveAdmin ? "True" : "False",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
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
    ToastMessage().showToast('Something went wrong, Please try again later.');
  }

  @override
  void showSuccess(CompletedProjectListModel responseModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (responseModel.status == 0) {
      projectList.addAll(responseModel.projectApprovedList);
    } else {
      ToastMessage().showToast(responseModel.message);
    }
  }
}
