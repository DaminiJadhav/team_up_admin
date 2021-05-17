import 'package:flutter/material.dart';
import 'package:teamupadmin/Contract/VerifiedOrganizationDetailsContract.dart';
import 'package:teamupadmin/Model/VerifiedOrganizationDetailsModel.dart';
import 'package:teamupadmin/Presenter/VerifiedOrganizationDetailsPresenter.dart';
import 'package:teamupadmin/Utils/CheckInternet.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/Utils/Progressbar.dart';
import 'package:teamupadmin/Utils/Toast.dart';
import 'package:url_launcher/url_launcher.dart';

class VerifiedOrganizationDetails extends StatefulWidget {
  int orgId;

  VerifiedOrganizationDetails(this.orgId);

  @override
  _VerifiedOrganizationDetailsState createState() =>
      _VerifiedOrganizationDetailsState();
}

class _VerifiedOrganizationDetailsState
    extends State<VerifiedOrganizationDetails>
    implements VerifiedOrganizationDetailsContract {
  VerifiedOrganizationDetailsPresenter verifiedOrganizationDetailsPresenter;

  bool isApiCallProcess = false;
  bool isDataAvailableToLoad = false;
  bool isInternetAvailable = false;
  String bodyMessage = 'Please wait..';
  CheckInternet _checkInternet;

  String orgName;
  String orgType;
  String orgAboutUs = 'NA';
  String orgWebSite;
  String orgEmailId;
  String orgMobile;
  String orgSpecialties;
  String orgEstablishmentDate;
  String orgAddress;
  String orgCity;
  String orgState;
  String orgCountry;
  String orgFromDate;
  String orgToDate;
  String adminName;

  _VerifiedOrganizationDetailsState() {
    verifiedOrganizationDetailsPresenter =
        new VerifiedOrganizationDetailsPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _checkInternet = new CheckInternet();
    _checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isInternetAvailable = true;
        });
        if (widget.orgId != null) {
          setState(() {
            isApiCallProcess = true;
          });
          _callDetailsApi();
        } else {
          ToastMessage()
              .showToast('Something went wrong, Please try again later..');
        }
      } else {
        setState(() {
          isInternetAvailable = false;
        });
      }
    });
  }

  _callDetailsApi() {
    int id = widget.orgId;
    verifiedOrganizationDetailsPresenter
        .getVerifiedOrgDetails("Organizations/GetVerifiedOrgDetails?Id=$id");
  }

  @override
  Widget build(BuildContext context) {
    return ProgressBar(
      child: mainUi(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }
  void handleClick(String value) {
    switch (value) {
      case 'Send Remainder':
      // print('Send Remainder');
        break;
      case 'Update Contract':
      //print('Update Contract');
        break;
    }
  }

  @override
  Widget mainUi(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Verified Organization Details'),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return {
                  'Send Remainder',
                  'Update Contract'
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
        body: isInternetAvailable
            ? isDataAvailableToLoad
                ? bodyContaint(
                    context,
                    orgName,
                    orgType,
                    orgWebSite,
                    orgMobile,
                    orgEmailId,
                    orgAboutUs,
                    orgEstablishmentDate,
                    orgAddress,
                    orgCity,
                    orgState,
                    orgCountry,
                    orgFromDate,
                    orgToDate,
                    adminName)
                : Container(
                    child: Center(
                      child: Text(
                        bodyMessage,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
            : Container(
                child: Center(
                  child: Text('Internet Connection Not Available..'),
                ),
              ));
  }

  @override
  void showError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
      bodyMessage = "Something went wrong, please try again later..";
      isDataAvailableToLoad = false;
    });
    ToastMessage().showToast('Something went wrong,please try again later..');
  }

  @override
  void showSuccess(VerifiedOrganizationDetailsModel success) {
    VerifiedOrganizationDetailsModel response;
    setState(() {
      isApiCallProcess = false;
      response = success;
    });
    if (response.status == 0) {
      setState(() {
        isDataAvailableToLoad = true;
        orgEstablishmentDate =
            response.verifiedOrganizations[0].establishmentDate;
        orgSpecialties = response.verifiedOrganizations[0].specialties;
        orgName = response.verifiedOrganizations[0].orgName;
        orgEstablishmentDate =
            response.verifiedOrganizations[0].establishmentDate;
        orgType = response.verifiedOrganizations[0].orgtypename;
        orgEmailId = response.verifiedOrganizations[0].email;
        orgMobile = response.verifiedOrganizations[0].phone;
        orgWebSite = response.verifiedOrganizations[0].website;
        orgToDate = response.verifiedOrganizations[0].toDateContract;
        orgFromDate = response.verifiedOrganizations[0].fromDateContract;
        orgCountry = response.verifiedOrganizations[0].country;
        orgState = response.verifiedOrganizations[0].state;
        orgCity = response.verifiedOrganizations[0].city;
        orgAddress = response.verifiedOrganizations[0].address;
        adminName = response.verifiedOrganizations[0].name;
      });
    } else {
      setState(() {
        isDataAvailableToLoad = false;
        bodyMessage = "Something went wrong, please try again later..";
      });
      ToastMessage().showToast(bodyMessage);
    }
  }

  Widget bodyContaint(
      BuildContext context,
      String organizationName,
      String type,
      String webSite,
      String mobileNumber,
      String emailId,
      String aboutUs,
      String estDate,
      String Address,
      String City,
      String State,
      String country,
      String fromDate,
      String toDate,
      String adminName) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: CircleAvatar(
                    radius: 70.0,
                    child: Icon(
                      Icons.business,
                      size: 90.0,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  organizationName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: Text(
                  'Organization Details',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60.0, right: 60.0),
                child: Divider(
                  thickness: 4,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0),
                child: Row(
                  children: [
                    Text(
                      'Establish Date: ',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Text(
                        estDate != null
                            ? estDate.isEmpty ? 'NA' : estDate
                            : 'NA',
                        style: TextStyle(fontSize: 18.0),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0),
                child: Row(
                  children: [
                    Text(
                      'Organization Type: ',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Text(
                        type,
                        style: TextStyle(fontSize: 18.0),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8.0, top: 8.0, bottom: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('About Us: ',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold)),
                    Expanded(
                      child: Text(aboutUs.isEmpty ? 'NA' : aboutUs,
                          maxLines: 10,
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 18.0)),
                    )
                  ],
                ),
              ),
              Center(
                child: Text(
                  'Contact Details',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60.0, right: 60.0),
                child: Divider(
                  thickness: 4,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                child: Row(
                  children: [
                    Text(
                      'Website: ',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Text(
                        webSite != null
                            ? webSite.isEmpty ? 'NA' : webSite
                            : 'NA',
                        style: TextStyle(fontSize: 18.0),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                child: Row(
                  children: [
                    Text(
                      'Email Id: ',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        launch('mailto:${emailId}');
                      },
                      child: Expanded(
                        child: Text(
                          emailId,
                          style: TextStyle(fontSize: 18.0),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                child: Row(
                  children: [
                    Text(
                      'Mobile Number: ',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        launch("tel://$mobileNumber");
                      },
                      child: Expanded(
                        child: Text(
                          mobileNumber,
                          style: TextStyle(fontSize: 18.0),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                child: Row(
                  children: [
                    Text(
                      'Address: ',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Text(
                        Address != null
                            ? Address.isEmpty ? 'NA' : Address
                            : 'NA',
                        style: TextStyle(fontSize: 18.0),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                child: Row(
                  children: [
                    Text(
                      'City: ',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Text(
                        City != null ? City.isEmpty ? 'NA' : City : 'NA',
                        style: TextStyle(fontSize: 18.0),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                child: Row(
                  children: [
                    Text(
                      'State: ',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Text(
                        State != null ? State.isEmpty ? 'NA' : State : 'NA',
                        style: TextStyle(fontSize: 18.0),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                child: Row(
                  children: [
                    Text(
                      'Country: ',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Text(
                        country != null
                            ? country.isEmpty ? 'NA' : country
                            : 'NA',
                        style: TextStyle(fontSize: 18.0),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Center(
                child: Text(
                  'Contract Details',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60.0, right: 60.0),
                child: Divider(
                  thickness: 4,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                child: Row(
                  children: [
                    Text(
                      'Start From: ',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Text(
                        orgFromDate != null
                            ? orgFromDate.isEmpty ? 'NA' : orgFromDate
                            : 'NA',
                        style: TextStyle(fontSize: 18.0),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                child: Row(
                  children: [
                    Text(
                      'End To: ',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Text(
                        orgToDate != null
                            ? orgToDate.isEmpty ? 'NA' : orgToDate
                            : 'NA',
                        style: TextStyle(fontSize: 18.0),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                child: Row(
                  children: [
                    Text(
                      'Approved By: ',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Text(
                        adminName != null
                            ? adminName.isEmpty ? 'NA' : adminName
                            : 'NA',
                        style: TextStyle(fontSize: 18.0),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
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
