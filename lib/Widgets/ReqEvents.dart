import 'package:flutter/material.dart';
import 'package:teamupadmin/Contract/AllRequestedEventListContract.dart';
import 'package:teamupadmin/Model/AllRequestedEventsListModel.dart';
import 'package:teamupadmin/Presenter/AllRequestedEventListPresenter.dart';
import 'package:teamupadmin/Screens/EventsDetails.dart';
import 'package:teamupadmin/Screens/PostAdsScreen.dart';
import 'package:teamupadmin/Screens/PostEventsScreen.dart';
import 'package:teamupadmin/Utils/CheckInternet.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/Utils/Progressbar.dart';
import 'package:teamupadmin/Utils/Toast.dart';
import 'package:url_launcher/url_launcher.dart';

class RequestedEvents extends StatefulWidget {
  @override
  _RequestedEventsState createState() => _RequestedEventsState();
}

class _RequestedEventsState extends State<RequestedEvents>
    implements AllRequestedEventListContract {
  AllRequestedEventListPresenter allRequestedEventListPresenter;
  AllRequestedEventsListModel allRequestedEventsListModel;

  CheckInternet _checkInternet;
  bool isApiCallProcess = false;
  bool isDataAvailableToData = false;
  bool isInternetAvailable = false;
  String bodyMessage = "Loading Data, Please wait..";

  _RequestedEventsState() {
    allRequestedEventListPresenter = new AllRequestedEventListPresenter(this);
  }
  getOnBack(dynamic value){
    setState(() {

    });
    getEventList();
  }
  getEventList(){

    _checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isInternetAvailable = true;
          isApiCallProcess = true;
        });
        getAllRequestedEvents();
      } else {
        ToastMessage()
            .showToast('No internet available, Please check your connection.');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _checkInternet = new CheckInternet();
    getEventList();

  }

  getAllRequestedEvents() {
    allRequestedEventListPresenter
        .getAllRequestedEvents('Event/AllRequestEventsList');
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
        body: isInternetAvailable
            ? isApiCallProcess
                ? Container(
                    child: Center(
                      child: Text(bodyMessage),
                    ),
                  )
                : isDataAvailableToData
                    ? allRequestedEventsListModel.event.isEmpty
                        ? Container(
                            child: Center(
                              child: Text(
                                  'Events not available..',style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),),
                            ),
                          )
                        : Container(
                            child: ListView(
                            children: [
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      allRequestedEventsListModel.event.length,
                                  itemBuilder: (context, index) {
                                    return EventCardDesign(
                                        context,
                                        allRequestedEventsListModel
                                            .event[index].eventName,
                                        allRequestedEventsListModel
                                            .event[index].publisherName,
                                        allRequestedEventsListModel
                                            .event[index].posterStatus,
                                        allRequestedEventsListModel
                                            .event[index].contentStatus,
                                        allRequestedEventsListModel
                                            .event[index].email,
                                        allRequestedEventsListModel
                                            .event[index].contactNo,
                                        allRequestedEventsListModel
                                            .event[index].id);
                                  })
                            ],
                          ))
                    : Container(
                        child: Center(
                          child: Text(bodyMessage),
                        ),
                      )
            : Container(
                child: Center(
                  child: Text(
                      'No Internet Connection Available, \n Please check your Internet connection.'),
                ),
              ));
  }

  @override
  void showError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
      bodyMessage = 'Something went wrong, Please try again later..';
      isDataAvailableToData = false;
    });
    ToastMessage().showToast('Something went wrong, Please try again later..');
  }

  @override
  void showSuccess(AllRequestedEventsListModel success) {
    setState(() {
      isApiCallProcess = false;
      allRequestedEventsListModel = success;
    });
    if (allRequestedEventsListModel.status == 0) {
      setState(() {
        isDataAvailableToData = true;
      });
    } else {
      setState(() {
        bodyMessage = 'Something went wrong, Please try again later..';
        isDataAvailableToData = false;
      });
    }
  }

  Widget EventCardDesign(
      BuildContext context,
      String eventName,
      String publisherName,
      bool Poster,
      bool Content,
      String emailId,
      String mobileNumber,
      int id) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => EventsDetails(id))).then(getOnBack);
        },
        child: Card(
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
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                        child: Text(
                          eventName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 32.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        publisherName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            'Does this event has Poster ?',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [Text(Poster ? 'Yes' : 'No')],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Does this event has Content ?',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(Content ? 'Yes' : 'No'),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8.0, top: 16.0, bottom: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.email),
                          ),
                          GestureDetector(
                              onTap: () {
                                // print('Email Id click');
                              },
                              child: Text(emailId))
                        ],
                      ),
                    ),
                    // Expanded(
                    //   flex: 1,
                    //   child: Row(
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.only(right: 8.0),
                    //         child: Icon(Icons.call),
                    //       ),
                    //       GestureDetector(
                    //           onTap: () {
                    //             // print('Mobile Number Click');
                    //           },
                    //           child: Text(mobileNumber))
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 16.0),
                child: Row(
                  children: [
                    // Expanded(
                    //   flex: 1,
                    //   child: Row(
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.only(right: 8.0),
                    //         child: Icon(Icons.email),
                    //       ),
                    //       GestureDetector(
                    //           onTap: () {
                    //             // print('Email Id click');
                    //           },
                    //           child: Text(emailId))
                    //     ],
                    //   ),
                    // ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.call),
                          ),
                          GestureDetector(
                              onTap: () {
                                // launch(mobileNumber);
                              },
                              child: Text(mobileNumber))
                        ],
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
}

// Widget AdsCardDesign(
//     BuildContext context,
//     String eventName,
//     String publisherName,
//     String containPoster,
//     String containContent,
//     String emailId,
//     String mobileNumber) {
//   return Padding(
//     padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
//     child: GestureDetector(
//       onTap: () {
//         Navigator.of(context)
//             .push(MaterialPageRoute(builder: (context) => PostAds()));
//       },
//       child: Card(
//         clipBehavior: Clip.antiAlias,
//         elevation: 20,
//         child: Column(
//           children: [
//             Container(
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 8.0, top: 8.0),
//                     child: Icon(Icons.adb),
//                   ),
//                   Flexible(
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 8.0, top: 4.0),
//                       child: Text(
//                         eventName,
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 22.0),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Divider(),
//             Padding(
//               padding: const EdgeInsets.only(left: 16.0, right: 32.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Text(
//                       publisherName,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold, fontSize: 18.0),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 16.0, top: 8.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: Row(
//                       children: [
//                         Expanded(
//                             child: Text(
//                           'Does this ad has Poster ?',
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         )),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: Row(
//                       children: [Text(containPoster)],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 16.0, top: 8.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: Expanded(
//                         child: Text(
//                       'Does this ad has Content ?',
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     )),
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: Text(containContent),
//                   )
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(
//                   left: 8.0, right: 8.0, top: 16.0, bottom: 8.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(right: 8.0),
//                           child: Icon(Icons.email),
//                         ),
//                         GestureDetector(
//                             onTap: () {
//                               // print('Email Id click');
//                             },
//                             child: Expanded(
//                               child: Text(
//                                 emailId,
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ))
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding:
//                   const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 16.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(right: 8.0),
//                           child: Icon(Icons.call),
//                         ),
//                         GestureDetector(
//                             onTap: () {
//                               // print('Mobile Number Click');
//                             },
//                             child: Text(mobileNumber))
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
