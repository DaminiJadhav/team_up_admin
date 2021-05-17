import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:teamupadmin/Contract/OrganizationRegisterListContract.dart';
import 'package:teamupadmin/Model/OrganizationRegisterListModel.dart';
import 'package:teamupadmin/Presenter/OrganizationRegisterListPresenter.dart';
import 'package:teamupadmin/Screens/VerifyOrganization.dart';
import 'package:teamupadmin/Utils/CheckInternet.dart';
import 'package:teamupadmin/Utils/Dialogbox/DialogHelper.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/Utils/Progressbar.dart';
import 'package:teamupadmin/Utils/Toast.dart';

class RequestedOrganization extends StatefulWidget {
  @override
  _RequestedOrganizationState createState() => _RequestedOrganizationState();
}

class _RequestedOrganizationState extends State<RequestedOrganization>
    implements OrganizationRegisterListContract {
  OrganizationRegisterListPresenter organizationRegisterListPresenter;
  OrganizationRegisterListModel organizationRegisterListModel;

  CheckInternet _checkInternet;
  bool isInternetPresent = true;
  bool isApiCallProcess = true;

  _RequestedOrganizationState() {
    organizationRegisterListPresenter =
        new OrganizationRegisterListPresenter(this);
  }

  getOnBack(dynamic value) {
    setState(() {});
    getOrgList();
  }

  getOrgList() {
    _checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isApiCallProcess = true;
          isInternetPresent = true;
        });
        organizationRegisterListPresenter
            .getorgList('Organizations/GetRegisterOrganizationDetails');
      } else {
        setState(() {
          isInternetPresent = false;
          isApiCallProcess = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _checkInternet = new CheckInternet();
    getOrgList();
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
    return isInternetPresent
        ? isApiCallProcess
            ? Container(
                child: Center(
                  child: Text('Loading Please wait...'),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    organizationRegisterListModel
                            .registerOrganizationDetails.isEmpty
                        ? Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        2.5),
                                Center(
                                  child: Expanded(
                                    child: Text(
                                      'Organizations not available.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: organizationRegisterListModel
                                .registerOrganizationDetails.length,
                            itemBuilder: (context, index) {
                              return MainContaintDesign(
                                  context,
                                  organizationRegisterListModel
                                      .registerOrganizationDetails[index]
                                      .orgName,
                                  organizationRegisterListModel
                                      .registerOrganizationDetails[index].email,
                                  organizationRegisterListModel
                                      .registerOrganizationDetails[index].phone,
                                  organizationRegisterListModel
                                      .registerOrganizationDetails[index].name,
                                  organizationRegisterListModel
                                      .registerOrganizationDetails[index]
                                      .website,
                                  organizationRegisterListModel
                                      .registerOrganizationDetails[index].id);
                            })
                  ],
                ),
              )
        : Container(
            child: Center(
              child: Lottie.asset('assets/lottie/nointernet.json'),
            ),
          );
  }

  @override
  void showError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    DialogBoxHelper.Error(context, 'Failed', 'Failed to Load Data..');
  }

  @override
  void showSuccess(OrganizationRegisterListModel success) {
    setState(() {
      isApiCallProcess = false;
      organizationRegisterListModel = success;
    });
    if (organizationRegisterListModel.status != 0) {
      ToastMessage().showToast(organizationRegisterListModel.message);
    }
  }

  Widget MainContaintDesign(
      BuildContext context,
      String organizationName,
      String emailId,
      String mobileNumber,
      String type,
      String webSite,
      int orgId) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => VerifyOrganization(orgId))).then(getOnBack);
        },
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 20,
          child: Column(
            children: [
              Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.business),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            organizationName,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22.0),
                          ),
                        ),
                      ),
                    ],
                  )),
              Divider(),
              Padding(
                padding:
                    const EdgeInsets.only(left: 28.0, right: 8.0, top: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Organization Type: ',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Expanded(
                      child: Text(
                        type,
                        style: TextStyle(fontSize: 16.0),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                child: Row(
                  children: [
                    Icon(Icons.language),
                    Text(
                      'Website: ',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Expanded(
                      child: Text(
                        webSite == null ? 'NA' : webSite,
                        style: TextStyle(fontSize: 16.0),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.email),
                    Text(
                      'Email Id : ',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        emailId,
                        style: TextStyle(fontSize: 16.0),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8.0, top: 8.0, bottom: 16.0),
                child: Row(
                  children: [
                    Icon(Icons.call),
                    Text(
                      'Mobile Number: ',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Expanded(
                        child: Text(
                          mobileNumber,
                          style: TextStyle(fontSize: 16.0),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
