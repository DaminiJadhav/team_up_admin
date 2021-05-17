import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:teamupadmin/Contract/ActivateAccountContract.dart';
import 'package:teamupadmin/Contract/DeletedAccountDetailsContract.dart';
import 'package:teamupadmin/Model/ActivateAccountModel.dart';
import 'package:teamupadmin/Model/DeletedAccountDetailsModel.dart';
import 'package:teamupadmin/Presenter/ActivateAccountPresenter.dart';
import 'package:teamupadmin/Presenter/DeletedAccountDetailsPresenter.dart';
import 'package:teamupadmin/SharedPreference/SharedPref.dart';
import 'package:teamupadmin/Utils/CheckInternet.dart';
import 'package:teamupadmin/Utils/Dialogbox/DialogHelper.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/Utils/Progressbar.dart';
import 'package:teamupadmin/Utils/Toast.dart';

class DeletedAccountDetails extends StatefulWidget {
  String id;
  bool isStd;

  DeletedAccountDetails(this.id, this.isStd);

  @override
  _DeletedAccountDetailsState createState() => _DeletedAccountDetailsState();
}

class _DeletedAccountDetailsState extends State<DeletedAccountDetails>
    implements DeletedAccountDetailsContract, ActivateAccountContract {
  bool isApiCallProcess = false;
  bool isInternetAvailable = false;
  bool isDataAvailable = false;
  bool buttonVisibility = true;
  CheckInternet checkInternet;

  DeletedAccountDetailsPresenter detailsPresenter;
  ActivateAccountPresenter accountPresenter;
  ActivateAccountRequestModel requestModel;

  List<UserProfile> detailsList;

  _DeletedAccountDetailsState() {
    detailsPresenter = new DeletedAccountDetailsPresenter(this);
    accountPresenter = new ActivateAccountPresenter(this);
  }

  getOnBack(dynamic value) {
    setState(() {});
    getDetails();
  }

  getDetails() {
    detailsList = new List();
    String userId = widget.id;
    bool isStd = widget.isStd;
    checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isInternetAvailable = true;
          isApiCallProcess = true;
        });
        detailsPresenter.getDetails(
            'Organizations/GetDeletedAccountDetails?ID=$userId&IsStd=$isStd');
      } else {
        setState(() {
          isInternetAvailable = false;
        });
      }
    });
  }

  activateAccount() {
    requestModel = new ActivateAccountRequestModel();
    setState(() {
      isApiCallProcess = true;
    });
    requestModel.userId = widget.id;
    requestModel.isStd = widget.isStd;
    requestModel.adminId = Preference.getAdminId().toString();

    accountPresenter.accountActivate(requestModel, 'Hackathon/ActivateAccount');
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40.0,
                        ),
                        GetUserDetails(detailsList[0].name,
                            detailsList[0].email, detailsList[0].imagePath),
                        SizedBox(
                          height: 20.0,
                        ),
                        Center(
                            child: Text(
                          'Reason To De-Activate Account :',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0),
                        )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            detailsList[0].reason != null
                                ? detailsList[0].reason
                                : 'NA',
                            maxLines: 30,
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                        Visibility(
                          visible: buttonVisibility,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 32.0,
                                right: 16.0,
                                top: 32.0,
                                bottom: 16.0),
                            child: GestureDetector(
                              onTap: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                checkInternet.check().then((value) {
                                  if (value != null && value) {
                                    activateAccount();
                                  } else {
                                    ToastMessage().showToast(
                                        'Please check your internet connection..');
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
                                    'Activate Account',
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
                      ],
                    ),
                  ),
                )
              : Container(
                  child: Center(
                    child: Text(!isDataAvailable
                        ? 'Loading'
                        : 'Something went wrong, Please try again later.'),
                  ),
                )
          : Container(
              child: Center(
                child: Lottie.asset('assets/lottie/nointernet.json'),
              ),
            ),
    );
  }

  Widget GetUserDetails(String Name, String Email, String imageUrl) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Container(
                width: double.infinity,
                height: 140,
                child: Container(
                  alignment: Alignment(0.0, 1.9),
                  child: CircleAvatar(
                    backgroundImage: imageUrl != null
                        ? NetworkImage(imageUrl)
                        : AssetImage('assets/Icons/profile.png'),
                    radius: 70.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Text(
              Name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              Email,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void showError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
      isDataAvailable = false;
    });
    ToastMessage().showToast('Something went wrong, Please try again later.');
  }

  @override
  void showSuccess(DeletedAccountDetailsModel detailsModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (detailsModel.status == 0) {
      setState(() {
        isDataAvailable = true;
      });
      detailsList.addAll(detailsModel.userProfile);
    } else {
      setState(() {
        isDataAvailable = false;
      });
      ToastMessage().showToast(detailsModel.message);
    }
  }

  @override
  void showActivateError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    DialogBoxHelper.Error(context, 'Activate Account',
        'Something went wrong, While Activating Account');
  }

  @override
  void showActivateSuccess(ActivateAccountResponseModel responseModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (responseModel.status == 0) {
      setState(() {
        buttonVisibility = false;
      });
      DialogBoxHelper.Success(
          context, "Activate Account", responseModel.message);
    } else {
      DialogBoxHelper.Error(context, "Activate Account", responseModel.message);
    }
  }
}
