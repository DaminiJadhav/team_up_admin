import 'package:flutter/material.dart';
import 'package:teamupadmin/Contract/VerifyOrganizationContract.dart';
import 'package:teamupadmin/Contract/VerifyOrganizationDetailsContract.dart';
import 'package:teamupadmin/Contract/VerifyOrganizationRejectContract.dart';
import 'package:teamupadmin/Model/VeifryOrganizationRejectModel.dart';
import 'package:teamupadmin/Model/VerifyOraginzationModel.dart';
import 'package:teamupadmin/Model/VerifyOrganizationDetailsModel.dart';
import 'package:teamupadmin/Presenter/VerifyOrganizationDetailsPresenter.dart';
import 'package:teamupadmin/Presenter/VerifyOrganizationPresenter.dart';
import 'package:teamupadmin/Presenter/VerifyOrganizationRejectPresenter.dart';
import 'package:teamupadmin/SharedPreference/SharedPref.dart';
import 'package:teamupadmin/Utils/CheckInternet.dart';
import 'package:teamupadmin/Utils/Dialogbox/DialogHelper.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/Utils/Progressbar.dart';
import 'package:teamupadmin/Utils/Toast.dart';
import 'package:url_launcher/url_launcher.dart';

class VerifyOrganization extends StatefulWidget {
  int orgId;

  VerifyOrganization(this.orgId);

  @override
  _VerifyOrganizationState createState() => _VerifyOrganizationState();
}

class _VerifyOrganizationState extends State<VerifyOrganization>
    implements
        VerifyOrganizationContract,
        VerifyOrganizationRejectContract,
        VerifyOrganizationDetailsContract {
  VerifyOrganizationPresenter verifyOrganizationPresenter;
  VerifyOrganizationRejectPresenter verifyOrganizationRejectPresenter;
  VerifyOrganizationDetailsPresenter verifyOrganizationDetailsPresenter;
  VerifyOrganizationRequestModel verifyOrganizationRequestModel;
  VerifyOrganizationRejectRequestModel verifyOrganizationRejectRequestModel;
  bool isApiCallProcess = false;
  bool isInternetAvailable = false;
  bool isShowButton = true;
  bool isDataAvailableToLoad = false;

  CheckInternet _checkInternet;
  String message = 'Please wait..';

  bool isFromDateSelect = false;
  bool isToDateSelect = false;

  String orgName;
  String orgType;
  String orgAboutUs;
  String orgWebSite;
  String orgEmailId;
  String orgMobile;
  String orgSpecialties;
  String orgEstablishmentDate;
  String orgAddress;
  String orgCity;
  String orgState;
  String orgCountry;

  DateTime contractDateFrom = DateTime.now();
  DateTime contractDateTo = DateTime.now();
  bool isContractFromDate = true;

  Future<void> _dateFromDialog() async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: contractDateFrom,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != contractDateFrom)
      setState(() {
        contractDateFrom = picked;
        isFromDateSelect = true;
      });
  }

  Future<void> _dateToDialog() async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: contractDateTo,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != contractDateTo)
      setState(() {
        contractDateTo = picked;
        isToDateSelect = true;
      });
  }

  _VerifyOrganizationState() {
    verifyOrganizationPresenter = new VerifyOrganizationPresenter(this);
    verifyOrganizationRejectPresenter =
        new VerifyOrganizationRejectPresenter(this);
    verifyOrganizationDetailsPresenter =
        new VerifyOrganizationDetailsPresenter(this);
  }

  callOrgDetailsApi() {
    int id = widget.orgId;
    setState(() {
      isApiCallProcess = true;
    });
    verifyOrganizationDetailsPresenter.getVerifyOrgDetails(
        "Organizations/GetRegisterOrganizationDetails?ID=$id");
  }

  validateApproveData() {
    if (isFromDateSelect == true && isToDateSelect == true) {
      _callApprovedOrganization(
          contractDateFrom.toString(), contractDateTo.toString());
    } else {
      if (isFromDateSelect != true) {
        ToastMessage().showToast('Please select Contract From Date.');
      } else if (isToDateSelect != true) {
        ToastMessage().showToast('Please select Contract To Date.');
      }
    }
  }

  _callApprovedOrganization(String fromDate, String toDate) {
    verifyOrganizationRequestModel.Id = widget.orgId;
    verifyOrganizationRequestModel.AdminId = Preference.getAdminId();
    verifyOrganizationRequestModel.fromDate = fromDate;
    verifyOrganizationRequestModel.toDate = toDate;
    setState(() {
      isApiCallProcess = true;
    });
    verifyOrganizationPresenter.approveOrg(
        verifyOrganizationRequestModel, 'Organizations/PutVerifyOrganization');
  }

  validateRejectDate() {
    _showAlert(context);
  }

  _callRejectOrganization() {
    verifyOrganizationRejectRequestModel.Id = widget.orgId;
    verifyOrganizationRejectRequestModel.AdminId = Preference.getAdminId();
    setState(() {
      isApiCallProcess = true;
    });
    verifyOrganizationRejectPresenter.rejectOrgContract(
        verifyOrganizationRejectRequestModel,
        'Organizations/SuspendOrganization');
  }

  void _showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Confirm",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        content: Text(
            'Are you sure. Do you want to Reject Organization Registration.'),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("No"),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          new FlatButton(
              onPressed: () {
                Navigator.of(context).pop(false);
                _callRejectOrganization();
              },
              child: Text('Yes'))
        ],
      ),
    );
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
        callOrgDetailsApi();
      } else {
        setState(() {
          isInternetAvailable = false;
        });
      }
    });
    Preference.init();
    verifyOrganizationRequestModel = new VerifyOrganizationRequestModel();
    verifyOrganizationRejectRequestModel =
        new VerifyOrganizationRejectRequestModel();
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
          title: Text('Verify organization'),
        ),
        body: isInternetAvailable
            ? isDataAvailableToLoad
                ? Container(
                    child: ListView(
                    children: [
                      bodyContaint(
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
                          orgCountry),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, left: 16.0, right: 16.0),
                        child: GestureDetector(
                          onTap: _dateFromDialog,
                          child: Container(
                            width: double.infinity,
                            height: 50.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  child: Text("${contractDateFrom.toLocal()}"
                                      .split(' ')[0]),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, left: 16.0, right: 16.0),
                        child: GestureDetector(
                          onTap: _dateToDialog,
                          child: Container(
                            width: double.infinity,
                            height: 50.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  child: Text("${contractDateTo.toLocal()}"
                                      .split(' ')[0]),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Visibility(
                        visible: isShowButton,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 16.0, bottom: 16.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    _checkInternet.check().then((value) {
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
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20.0),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                    _checkInternet.check().then((value) {
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
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20.0),
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                      ),
                    ],
                  ))
                : Container(
                    child: Center(
                      child: Text(message),
                    ),
                  )
            : Container(
                child: Center(
                    child: Text(
                        'No Internet Available. Please check Your Internet Connection')),
              ));
  }

  @override
  void showError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    DialogBoxHelper.Error(context, 'Approve Organization',
        'Something went wrong,please try again later..');
  }

  @override
  void showSuccess(VerifyOrganizationResponseModel success) {
    VerifyOrganizationResponseModel verifyOrganizationResponseModel;
    setState(() {
      isApiCallProcess = false;
      verifyOrganizationResponseModel = success;
      isShowButton = false;
    });
    if (verifyOrganizationResponseModel.Status == 0) {
      DialogBoxHelper.Success(context, 'Approve Organization',
          'Organization Approved Successfully..');
    } else {
      DialogBoxHelper.Error(context, 'Approve Organization',
          'Something went wrong, while approving Organization, please try again later..');
    }
  }

  @override
  void showRejectOnError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });

    DialogBoxHelper.Error(context, 'Reject Organization',
        'Something went wrong,please try again later..');
  }

  @override
  void showRejectSuccess(VerifyOrganizationRejectResponseModel success) {
    VerifyOrganizationRejectResponseModel verifyOrganizationRejectResponseModel;
    setState(() {
      isApiCallProcess = false;
      isShowButton = false;
      verifyOrganizationRejectResponseModel = success;
    });
    if (verifyOrganizationRejectResponseModel.Status == 0) {
      DialogBoxHelper.Success(context, 'Reject Organization',
          'Organization Rejected Successfully..');
    } else {
      DialogBoxHelper.Error(context, 'Reject Organization',
          'Something went wrong, while Rejecting Organization, please try again later..');
    }
  }

  @override
  void showErrorDetails(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    ToastMessage().showToast('Something went wrong, please try again later..');
  }

  @override
  void showSuccessDetails(VerifyOrganizationDetailsModel success) {
    VerifyOrganizationDetailsModel response;
    setState(() {
      isApiCallProcess = false;
      response = success;
    });
    if (response.status == 0) {
      setState(() {
        isDataAvailableToLoad = true;
        orgName = response.registerOrganizationDetails[0].orgName;
        orgType = response.registerOrganizationDetails[0].name;
        orgAboutUs = response.registerOrganizationDetails[0].aboutUs;
        orgWebSite = response.registerOrganizationDetails[0].website;
        orgEmailId = response.registerOrganizationDetails[0].email;
        orgMobile = response.registerOrganizationDetails[0].phone;
        orgEstablishmentDate =
            response.registerOrganizationDetails[0].establishmentDate;
        orgSpecialties = response.registerOrganizationDetails[0].specialties;
        orgAddress = response.registerOrganizationDetails[0].address;
        orgCity = response.registerOrganizationDetails[0].city;
        orgState = response.registerOrganizationDetails[0].state;
        orgCountry = response.registerOrganizationDetails[0].country;
      });

    } else {
      ToastMessage()
          .showToast('Something went wrong, Please try again later..');
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
      String country) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0),
              child: Row(
                children: [
                  Text(
                    'Establish Date: ',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      estDate != null ? estDate : 'NA',
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
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      type ==null ? 'NA' : type,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('About Us: ',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold)),
                  Expanded(
                    child: Text(aboutUs,
                        maxLines: 10,
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 18.0)),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: Row(
                children: [
                  Text(
                    'Website: ',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      webSite,
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
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
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
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
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
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      Address != null ? Address.isEmpty ? 'NA' : Address : 'NA',
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
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
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
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
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
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      country != null ? country.isEmpty ? 'NA' : country : 'NA',
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
            Text(
              'Select Contract Date',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
            ),
          ],
        ),
      ),
    );
  }
}
