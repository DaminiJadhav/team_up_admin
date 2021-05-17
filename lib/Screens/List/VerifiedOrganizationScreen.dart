import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:teamupadmin/Contract/VerifiedOrganizationListContract.dart';
import 'package:teamupadmin/Model/VerifiedOrganizationListModel.dart';
import 'package:teamupadmin/Presenter/VerifiedOrganizationListPresenter.dart';
import 'package:teamupadmin/Presenter/VerifyOrganizationPresenter.dart';
import 'package:teamupadmin/Screens/List/OrganizationDetails.dart';
import 'package:teamupadmin/Screens/List/VerifiedOrganizationDetails.dart';
import 'package:teamupadmin/Utils/CheckInternet.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/Utils/Progressbar.dart';
import 'package:teamupadmin/Utils/Toast.dart';

class VerifiedOrganization extends StatefulWidget {
  @override
  _VerifiedOrganizationState createState() => _VerifiedOrganizationState();
}

class _VerifiedOrganizationState extends State<VerifiedOrganization>
    implements VerifiedOrganizationListContract {
  VerifiedOrganizationListPresenter verifiedOrganizationListPresenter;
  VerifiedOrganizationListModel verifiedOrganizationListModel;

  bool isApiCallProcess = true;
  CheckInternet _checkInternet;

  _VerifiedOrganizationState() {
    verifiedOrganizationListPresenter =
        new VerifiedOrganizationListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    verifiedOrganizationListModel = new VerifiedOrganizationListModel();
    _checkInternet = new CheckInternet();
    callApi();
  }

  callApi() {
    _checkInternet.check().then((value) {
      if (value != null && value) {
        verifiedOrganizationListPresenter
            .getAllVerifiedOrgList('Organizations/GetVerifiedOrganization');
      } else {
        setState(() {
          isApiCallProcess = false;
        });
        ToastMessage().showToast('Please check your internet connection..');
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
        title: Text('Verified Organization'),
      ),
      body: isApiCallProcess
          ? Container(
              child: Center(child: Text('Loading Data please wait..')),
            )
          : Container(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                    child: Center(
                      child: Text(
                        'Verified Organization',
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Center(
                        child: Text('List of all the Verified Organization')),
                  ),

                  SingleChildScrollView(
                    child: Column(
                      children: [
                        verifiedOrganizationListModel.verifiedOrganizations.isEmpty ? Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: MediaQuery.of(context).size.height/2.5),
                              Center(
                                child: Expanded(
                                  child: Text(
                                    'No Verified Organization Available..',style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0
                                  ),
                                    maxLines: 2,overflow: TextOverflow.ellipsis,),
                                ),
                              ),
                            ],
                          ),
                        ) :ListView.builder(
                            shrinkWrap: true,
                            itemCount: verifiedOrganizationListModel
                                .verifiedOrganizations.length,
                            itemBuilder: (context, index) {
                              return MainContaintDesign(
                                  context,
                                  verifiedOrganizationListModel
                                      .verifiedOrganizations[index].orgName,
                                  verifiedOrganizationListModel
                                      .verifiedOrganizations[index].email,
                                  verifiedOrganizationListModel
                                      .verifiedOrganizations[index].phone,
                                  verifiedOrganizationListModel
                                      .verifiedOrganizations[index].name,
                                  verifiedOrganizationListModel
                                      .verifiedOrganizations[index].website,
                                  verifiedOrganizationListModel
                                      .verifiedOrganizations[index].id
                              );
                            })
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }

  @override
  void showError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    ToastMessage().showToast('Something went wrong,please try again later..');
  }

  @override
  void showSuccess(VerifiedOrganizationListModel success) {
    setState(() {
      isApiCallProcess = false;
    });
    if (success.status == 0) {
      setState(() {
        verifiedOrganizationListModel = success;
      });
    } else {
      ToastMessage().showToast(success.message);
    }
  }

  Widget MainContaintDesign(BuildContext context, String organizationName,
      String emailId, String mobileNumber, String type, String webSite,int id) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> VerifiedOrganizationDetails(id)));
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
                        webSite,
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
