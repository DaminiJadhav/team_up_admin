import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:teamupadmin/Contract/GetSubmittedProjectListContract.dart';
import 'package:teamupadmin/Model/GetSubmittedProjectListModel.dart';
import 'package:teamupadmin/Presenter/GetSubmittedProjectListPresenter.dart';
import 'package:teamupadmin/Screens/ProjectDetailsScreen.dart';
import 'package:teamupadmin/Utils/CheckInternet.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/Utils/Progressbar.dart';
import 'package:teamupadmin/Utils/Toast.dart';

class RequestedProject extends StatefulWidget {
  @override
  _RequestedProjectState createState() => _RequestedProjectState();
}

class _RequestedProjectState extends State<RequestedProject>
    implements GetSubmittedProjectListContract {
  GetSubmittedProjectListPresenter submittedProjectListPresenter;
  CheckInternet checkInternet;
  bool isInternetAvailable = false;
  bool isApiCallProcess = false;

  List<ProjectList> projectList;

  _RequestedProjectState() {
    submittedProjectListPresenter = new GetSubmittedProjectListPresenter(this);
  }

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
        submittedProjectListPresenter
            .getList('ProjectDetails/GetListOfSubmittedProjects');
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
    return isInternetAvailable
        ? projectList.isNotEmpty
            ? Container(
                child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: projectList.length,
                        itemBuilder: (context, index) {
                          return MainContaintDesign(
                              projectList[index].id.toString(),
                              projectList[index].projectname,
                              projectList[index].createdByName,
                              projectList[index].deadline,
                              projectList[index].submittedDate,
                              projectList[index].submittedByName,
                              projectList[index].contactNo);
                        }),
                  ],
                ),
              ))
            : Container(
                child: Center(
                  child:
                      Text(isApiCallProcess ? '' : 'Projects not available.',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),),
                ),
              )
        : Container(
            child: Center(
              child: Lottie.asset('assets/lottie/nointernet.json'),
            ),
          );
  }

  Widget MainContaintDesign(
      String pId,
      String projectName,
      String createdBy,
      String deadline,
      String submittedDate,
      String submittedBy,
      String contact) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(
                  MaterialPageRoute(builder: (context) => ProjectDetails(pId)))
              .then(getOnBack);
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
                            projectName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
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
                child: Text(
                  createdBy,
                  maxLines: 2,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
              ),
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
                            'Deadline:',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            deadline,
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
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Text(
                            'Submitted Date:',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            submittedDate,
                            style: TextStyle(fontSize: 16.0),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                child: Row(
                  children: [
                    Text(
                      'Submitted By: ',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        submittedBy,
                        style: TextStyle(fontSize: 16.0),
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
                      'Contact Number: ',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        contact,
                        style: TextStyle(fontSize: 16.0),
                      ),
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
  void showSuccess(GetSubmittedProjectListModel listModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (listModel.status == 0) {
      projectList.addAll(listModel.projectList);
    } else {
      ToastMessage().showToast(listModel.message);
    }
  }
}
