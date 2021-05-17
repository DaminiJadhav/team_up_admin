import 'package:flutter/material.dart';
import 'package:teamupadmin/Contract/ApproveEventContract.dart';
import 'package:teamupadmin/Contract/EventDetailsContract.dart';
import 'package:teamupadmin/Contract/RejectEventContract.dart';
import 'package:teamupadmin/Model/ApproveEventModel.dart';
import 'package:teamupadmin/Model/EventDetailsModel.dart';
import 'package:teamupadmin/Model/RejectEventModel.dart';
import 'package:teamupadmin/Presenter/ApproveEventPresenter.dart';
import 'package:teamupadmin/Presenter/EventDetailsPresenter.dart';
import 'package:teamupadmin/Presenter/RejectEventPresenter.dart';
import 'package:teamupadmin/SharedPreference/SharedPref.dart';
import 'package:teamupadmin/Utils/CheckInternet.dart';
import 'package:teamupadmin/Utils/Dialogbox/DialogHelper.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/Utils/Progressbar.dart';
import 'package:teamupadmin/Utils/ShowNetworkImage.dart';
import 'package:teamupadmin/Utils/Toast.dart';

class EventsDetails extends StatefulWidget {
  int id;

  EventsDetails(this.id);

  @override
  _EventsDetailsState createState() => _EventsDetailsState();
}

class _EventsDetailsState extends State<EventsDetails>
    implements EventDetailsContract, ApproveEventContract, RejectEventContract {
  EventDetailsPresenter eventDetailsPresenter;
  ApproveEventRequestModel approveEventRequestModel;
  RejectEventRequestModel rejectEventRequestModel;
  ApproveEventPresenter approveEventPresenter;
  RejectEventPresenter rejectEventPresenter;

  CheckInternet checkInternet;
  bool isInternetAvailable = false;
  bool isApiCallProcess = false;
  bool isDataAvailableToLoad = false;
  String messageToShow = 'Loading Data...';

  String eventName;
  bool posterStatus;
  bool contentStatus;
  String address;
  String emailId;
  String mobileNumber;
  String content;
  String posterUrl;
  String publisherName;
  String eventDate;

  _EventsDetailsState() {
    eventDetailsPresenter = new EventDetailsPresenter(this);
    approveEventPresenter = new ApproveEventPresenter(this);
    rejectEventPresenter = new RejectEventPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    Preference.init();
    checkInternet = new CheckInternet();
    approveEventRequestModel = new ApproveEventRequestModel();
    rejectEventRequestModel = new RejectEventRequestModel();

    checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isInternetAvailable = true;
          isApiCallProcess = false;
        });
        getDetails();
      } else {
        setState(() {
          isInternetAvailable = false;
        });
      }
    });
  }

  getDetails() {
    int eventId = widget.id;
    eventDetailsPresenter
        .getEventDetails('Event/GetRegisterEventDetails?ID=$eventId');
  }

  rejectEvent() {
    rejectEventRequestModel.eventId = widget.id;
    rejectEventRequestModel.adminId = Preference.getAdminId();
    setState(() {
      isApiCallProcess = true;
    });
    rejectEventPresenter.reject(
        rejectEventRequestModel, 'Event/PutSuspendEvent');
  }

  approveEvent() {
    approveEventRequestModel.eventId = widget.id;
    approveEventRequestModel.adminId = Preference.getAdminId();
    setState(() {
      isApiCallProcess = true;
    });
    approveEventPresenter.approve(
        approveEventRequestModel, 'Event/PutVerifyEvent');
  }

  @override
  Widget build(BuildContext context) {
    return ProgressBar(
      child: _MainUI(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }

  @override
  Widget _MainUI(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Event Details'),
        ),
        body: isInternetAvailable
            ? isApiCallProcess
                ? Container(
                    child: Center(
                      child: Text(messageToShow),
                    ),
                  )
                : isDataAvailableToLoad
                    ? SingleChildScrollView(
                        child: Container(
                          child: Column(
                            children: [
                              MainContantDesign(context),
                            ],
                          ),
                        ),
                      )
                    : Container(
                        child: Center(
                          child: Text(messageToShow),
                        ),
                      )
            : Container(
                child: Center(
                  child: Text(
                      'Internet connection not available, Please your internet conncetion..'),
                ),
              ));
  }

  @override
  void showDetailsError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
      isDataAvailableToLoad = false;
      messageToShow = 'Something went wrong, Please try again later..';
    });
  }

  @override
  void showDetailsSuccess(EventDetailsModel detailsModel) {
    EventDetailsModel detailsModels;
    setState(() {
      isApiCallProcess = false;
      detailsModels = detailsModel;
    });
    if (detailsModels.status == 0) {
      setState(() {
        eventName = detailsModels.event[0].eventName;
        publisherName = detailsModels.event[0].publisherName;
        address = detailsModels.event[0].address;
        emailId = detailsModels.event[0].email;
        mobileNumber = detailsModels.event[0].contactNo;
        posterStatus = detailsModels.event[0].posterStatus;
        contentStatus = detailsModels.event[0].contentStatus;
        posterUrl = detailsModels.event[0].poster;
        content = detailsModels.event[0].description;
        eventDate = detailsModels.event[0].date;
        isDataAvailableToLoad = true;
      });
    } else {
      setState(() {
        isDataAvailableToLoad = false;
        messageToShow = 'Something went wrong, Please try again later..';
      });
    }
  }

  @override
  void showApproveError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    DialogBoxHelper.Error(context, 'Approve Event',
        'Something went wrong, While Approving Event. Please try again later..');
  }

  @override
  void showApproveSuccess(ApproveEventResponseModel success) {
    ApproveEventResponseModel approveEventResponseModel;
    setState(() {
      isApiCallProcess = false;
      approveEventResponseModel = success;
    });
    if (approveEventResponseModel.status == 0) {
      DialogBoxHelper.Success(
          context, 'Approve Event', 'Event Approved Successfully...');
    } else {
      DialogBoxHelper.Error(context, 'Approve Event',
          'Something went wrong, While Approving Event. Please try again later..');
    }
  }

  @override
  void showRejectError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    DialogBoxHelper.Error(context, 'Reject Event',
        'Something went wrong, While Rejecting Event. Please try again later..');
  }

  @override
  void showRejectSuccess(RejectEventResponseModel success) {
    RejectEventResponseModel responseModel;
    setState(() {
      isApiCallProcess = false;
      responseModel = success;
    });
    if (responseModel.status == 0) {
      DialogBoxHelper.Success(
          context, 'Reject Event', 'Event Rejected Successfully...');
    } else {
      DialogBoxHelper.Error(context, 'Reject Event',
          'Something went wrong, While Rejecting Event. Please try again later..');
    }
  }

  Widget MainContantDesign(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListTile(
            title: Text(
              eventName,
              textAlign: TextAlign.center,
              maxLines: 3,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Visibility(
            visible: posterStatus,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ShowNetworkImage(posterUrl)));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Hero(
                  tag: 'Image Preview',
                  child: Image.network(
                    posterUrl,
                    height: 150.0,
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: contentStatus,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 4.0, right: 16.0, left: 16.0, bottom: 4.0),
              child: Expanded(
                child: Text(
                  content,
                  maxLines: 20,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: TextStyle(fontSize: 18.0),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Venue : ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Expanded(
                  child: Text(
                    address,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18.0),
                    textAlign: TextAlign.justify,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 8.0, left: 8.0, right: 8.0, bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Date : ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Expanded(
                  child: Text(
                    eventDate,
                    style: TextStyle(fontSize: 18.0),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Contact Details',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60.0, right: 60.0),
            child: Divider(thickness: 4),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Publisher Name : ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Expanded(
                  child: Text(
                    publisherName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18.0),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              left: 8.0,
              right: 8.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contact No: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Expanded(
                  child: Text(
                    mobileNumber,
                    style: TextStyle(fontSize: 18.0),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 8.0, left: 8.0, right: 8.0, bottom: 32.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email Id: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Expanded(
                  child: Text(
                    emailId,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18.0),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 8.0, right: 8.0, top: 16.0, bottom: 16.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      checkInternet.check().then((value) {
                        if (value != null && value) {
                          rejectEvent();
                        } else {
                          ToastMessage().showToast(
                              'Please check your internet connection..');
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
                          approveEvent();
                        } else {
                          ToastMessage().showToast(
                              'Please check your internet connection..');
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
          SizedBox(
            height: 20.0,
          )
        ],
      ),
    );
  }
}
