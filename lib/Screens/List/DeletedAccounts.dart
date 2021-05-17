import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:teamupadmin/Contract/DeletedAccountsListContract.dart';
import 'package:teamupadmin/Model/DeletedAccountsListModel.dart';
import 'package:teamupadmin/Presenter/DeletedAccountsListPresenter.dart';
import 'package:teamupadmin/Screens/List/DeletedAccountDetails.dart';
import 'package:teamupadmin/Utils/CheckInternet.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/Utils/Progressbar.dart';
import 'package:teamupadmin/Utils/Toast.dart';

class DeletedAccounts extends StatefulWidget {
  @override
  _DeletedAccountsState createState() => _DeletedAccountsState();
}

class _DeletedAccountsState extends State<DeletedAccounts>
    implements DeletedAccountsListContract {
  bool isApiCallProcess = false;
  bool isInternetAvailable = false;
  CheckInternet checkInternet;
  DeletedAccountsListPresenter presenter;

  List<DeletedAccount> accountsList;

  _DeletedAccountsState() {
    presenter = new DeletedAccountsListPresenter(this);
  }

  getOnBack(dynamic value) {
    setState(() {});
    getListOfAccounts();
  }

  getListOfAccounts() {
    accountsList = new List();
    checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isInternetAvailable = true;
          isApiCallProcess = true;
        });
        presenter.getDeletedAccounts('Hackathon/GetListOfDeletedAccount');
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
    getListOfAccounts();
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
        title: Text('Deleted Accounts'),
      ),
      body: isInternetAvailable
          ? accountsList.isNotEmpty
              ? Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: accountsList.length,
                            itemBuilder: (context, index) {
                              return cardDesign(
                                  accountsList[index].id.toString(),
                                  accountsList[index].name,
                                  accountsList[index].username,
                                  accountsList[index].email,
                                  accountsList[index].mobileNo,
                                  accountsList[index].isStd);
                            })
                      ],
                    ),
                  ),
                )
              : Container(
                  child: Center(
                    child: Text(isApiCallProcess
                        ? 'Loading'
                        : 'Something went wrong, Please try again later'),
                  ),
                )
          : Container(
              child: Center(
                child: Lottie.asset('assets/lottie/nointernet.json'),
              ),
            ),
    );
  }

  Widget cardDesign(String id, String name, String username, String email,
      String mobile, bool isStd) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (context) => DeletedAccountDetails(id, isStd)))
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
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  maxLines: 3,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Username : ',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Text(
                        username != null ? username : 'NA',
                        style: TextStyle(fontSize: 16.0),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email : ',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Text(
                        email != null ? email : 'NA',
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
                    left: 16.0, right: 16.0, top: 8.0, bottom: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Is Student : ',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Text(
                        isStd ? "Yes" : "No",
                        style: TextStyle(fontSize: 16.0),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
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

  @override
  void showError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    ToastMessage().showToast('Something went wrong, Please try again later');
  }

  @override
  void showSuccess(DeletedAccountsListModel listModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (listModel.status == 0) {
      accountsList.addAll(listModel.deletedAccounts);
    } else {
      ToastMessage().showToast(listModel.message);
    }
  }
}
