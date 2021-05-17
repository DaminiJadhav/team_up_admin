import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:teamupadmin/Contract/ApprovedHackathonListContract.dart';
import 'package:teamupadmin/Model/ApprovedHackathonListModel.dart';
import 'package:teamupadmin/Presenter/ApprovedHackathonListPresenter.dart';
import 'package:teamupadmin/Utils/CheckInternet.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/Utils/Progressbar.dart';
import 'package:teamupadmin/Utils/Toast.dart';

import '../RequestedHackathonDetails.dart';

class ApprovedHackathons extends StatefulWidget {
  @override
  _ApprovedHackathonsState createState() => _ApprovedHackathonsState();
}

class _ApprovedHackathonsState extends State<ApprovedHackathons>
    implements ApprovedHackathonListContract {
  bool isApiCallProcess = false;
  bool isInternetAvailable = false;
  CheckInternet checkInternet;

  ApprovedHackathonListPresenter presenter;

  List<HackathonList> hackathonList;

  _ApprovedHackathonsState() {
    presenter = new ApprovedHackathonListPresenter(this);
  }

  getOnBack(dynamic value) {
    setState(() {});
    getHackathonDetails();
  }

  getHackathonDetails() {
    hackathonList = new List();
    checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isInternetAvailable = true;
          isApiCallProcess = true;
        });
        presenter.getApprovedList('Hackathon/GetApproveHackathonListForAdmin');
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
    getHackathonDetails();
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
        title: Text('Approved Hackathon'),
      ),
      body: isInternetAvailable
          ? hackathonList.isNotEmpty
              ? Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: hackathonList.length,
                            itemBuilder: (context, index) {
                              return MainDesign(
                                  hackathonList[index].hackathonId.toString(),
                                  hackathonList[index].hackathonName,
                                  hackathonList[index].orgName,
                                  hackathonList[index].contactNo,
                                  hackathonList[index].lastDate);
                            })
                      ],
                    ),
                  ),
                )
              : Container(
                  child: Center(
                    child: Text(isApiCallProcess
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

  Widget MainDesign(String hId, String HackathonName, String compnayName,
      String contactNo, String lastDate) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(
                builder: (context) => RequestedHackathonDetails(hId)))
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
                  const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
              child: Text(
                HackathonName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Comapny Name : ',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      compnayName,
                      style: TextStyle(fontSize: 16.0),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 8.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Last Date : ',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      lastDate,
                      style: TextStyle(fontSize: 16.0),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contact No : ',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      contactNo != null ? contactNo : 'NA',
                      style: TextStyle(fontSize: 16.0),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  )
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
    ToastMessage().showToast('Something went wrong, Please try again later');
  }

  @override
  void showSuccess(ApprovedHackathonListModel approvedHackathonListModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (approvedHackathonListModel.status == 0) {
      hackathonList.addAll(approvedHackathonListModel.hackathonList);
    } else {
      ToastMessage().showToast('Something went wrong, Please try again later');
    }
  }
}
