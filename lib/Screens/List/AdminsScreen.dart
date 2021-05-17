import 'package:flutter/material.dart';
import 'package:teamupadmin/Contract/GetAllAdminListContract.dart';
import 'package:teamupadmin/Model/GetAllAdminListModel.dart';
import 'package:teamupadmin/Presenter/GetAllAdminListPresenter.dart';
import 'package:teamupadmin/Utils/CheckInternet.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/Utils/Progressbar.dart';
import 'package:teamupadmin/Utils/Toast.dart';

class Admins extends StatefulWidget {
  @override
  _AdminsState createState() => _AdminsState();
}

class _AdminsState extends State<Admins> implements GetAllAdminListContract {
  GetAllAdminResponseModel getAllAdminResponseModel;
  GetAllAdminListPresenter _getAllAdminListPresenter;
  CheckInternet _checkInternet;
  bool isInternetPresent = true;
  bool isApiCallProcess = false;

  _AdminsState() {
    _getAllAdminListPresenter = new GetAllAdminListPresenter(this);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isApiCallProcess = true;
    });
    _checkInternet = new CheckInternet();
    _checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isApiCallProcess = true;
          isInternetPresent = true;
        });
        _getAllAdminListPresenter.getAllAdmin('Admins/GetAllAdminDetails');
      } else {
        setState(() {
          isInternetPresent = false;
          isApiCallProcess = false;
        });
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
          title: Text('Admin'),
        ),
        body: isInternetPresent
            ? isApiCallProcess
                ? Container(
                    child: Center(
                      child: Text('Loading Please wait...'),
                    ),
                  )
                : Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                          child: Text(
                            "Active Admin's",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text("List of all the Admin's"),
                        ),
                        // MainAdminDesign(context, 'Gajanan', 'gajanan@sdaemon.com'),
                        SingleChildScrollView(
                          child: getAllAdminResponseModel.admin.isEmpty ? Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: MediaQuery.of(context).size.height/2.5),
                                Center(
                                  child: Expanded(
                                    child: Text(
                                      'No Admins Available..',style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0
                                    ),
                                      maxLines: 2,overflow: TextOverflow.ellipsis,),
                                  ),
                                ),
                              ],
                            ),
                          ): ListView.builder(
                            shrinkWrap: true,
                            itemCount: getAllAdminResponseModel.admin.length,
                            itemBuilder: (context, index) {
                              return MainAdminDesign(
                                  context,
                                  getAllAdminResponseModel.admin[index].name,
                                  getAllAdminResponseModel.admin[index].email,
                                  getAllAdminResponseModel.admin[index].id);
                            },
                          ),
                        )
                      ],
                    ),
                  )
            : Container(
                child: Center(
                  child: Column(
                    children: [
                      Icon(Icons.error),
                      Text('Please check your Internet Connection..')
                    ],
                  ),
                ),
              ));
  }

  Widget MainAdminDesign(
      BuildContext context, String name, String emailId, int Id) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
      child: GestureDetector(
        onTap: () {
          // print(name);
        },
        child: Card(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Text(
                        name[0],
                        style: TextStyle(fontSize: 30.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                emailId,
                                style: TextStyle(fontSize: 14.0)
                                  ,overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
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
    ToastMessage().showToast('Something went wrong,please try again later..');
  }

  @override
  void showSuccess(GetAllAdminResponseModel success) {
    setState(() {
      getAllAdminResponseModel = success;
      isApiCallProcess = false;
    });
  }
}
