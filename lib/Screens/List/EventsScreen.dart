import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:teamupadmin/Contract/ApprovedEventContract.dart';
import 'package:teamupadmin/Model/ApprovedEventResponseModel.dart';
import 'package:teamupadmin/Presenter/ApprovedEventPresenter.dart';
import 'package:teamupadmin/Screens/PostEventsScreen.dart';
import 'package:teamupadmin/Utils/CheckInternet.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/Utils/Progressbar.dart';
import 'package:teamupadmin/Utils/Toast.dart';

class PostedEvents extends StatefulWidget {
  @override
  _PostedEventsState createState() => _PostedEventsState();
}

class _PostedEventsState extends State<PostedEvents>
    implements ApprovedEventContract {
  bool isInternetAvailable = false;
  bool isApiCallProcess = false;
  CheckInternet checkInternet;
  ApprovedEventPresenter presenter;
  List<EventList> eventList;

  _PostedEventsState() {
    presenter = new ApprovedEventPresenter(this);
  }

  getList() {
    eventList = new List();
    checkInternet = CheckInternet();
    checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isInternetAvailable = true;
          isApiCallProcess = true;
        });
        presenter.getApprovedEventList('Event/GetApprovedEventsList');
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
        title: Text('Events'),
      ),
      body: isInternetAvailable
          ? eventList.isNotEmpty
              ? Container(
                  child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: eventList.length,
                          itemBuilder: (context, index) {
                            return MainDesign(
                                eventList[index].id.toString(),
                                eventList[index].eventName,
                                eventList[index].approvedDate,
                                eventList[index].postedDate,
                                eventList[index].content,
                                eventList[index].posterStatus,
                                eventList[index].contentStatus,
                                eventList[index].posterImage);
                          }),
                    ],
                  ),
                ))
              : Container(
                  child: Center(
                    child: Text(isApiCallProcess
                        ? ''
                        : 'Approved event not available.'),
                  ),
                )
          : Container(
              child: Center(
                child: Lottie.asset('assets/lottie/nointernet.json'),
              ),
            ),
    );
  }

  Widget MainDesign(
      String id,
      String adsHeading,
      String approvedDate,
      String postedDate,
      String Content,
      bool posterStatus,
      bool contentStatus,
      String poster) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 20,
      child: Column(
        children: [
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                  child: Icon(Icons.event_note),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                    child: Text(
                      adsHeading,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 24.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: posterStatus,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 25.0,
                clipBehavior: Clip.antiAlias,
                shadowColor: Theme.of(context).primaryColor,
                child: GestureDetector(
                  onTap: () {},
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 250.0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          image: DecorationImage(
                              fit: BoxFit.contain, image: NetworkImage(poster)
                              //AssetImage('assets/Icons/select_image.png')
                              )),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: contentStatus,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      Content,
                      style: TextStyle(
                        fontSize: 16.0
                      ),
                      maxLines: 4,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text('Approved Date : '),
                      ),
                      Flexible(
                          child:
                              Text(approvedDate != null ? approvedDate : 'NA'))
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text('Posted Date : '),
                      ),
                      Flexible(
                          child: Text(postedDate != null ? postedDate : 'NA'))
                    ],
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
    ToastMessage().showToast('Something went wrong, Please try again later');
  }

  @override
  void showSuccess(ApprovedEventResponseModel approvedEventResponseModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (approvedEventResponseModel.status == 0) {
      eventList.addAll(approvedEventResponseModel.eventList);
    } else {
      ToastMessage().showToast(approvedEventResponseModel.message);
    }
  }
}
