
import 'package:teamupadmin/Contract/AddAdminContract.dart';
import 'package:teamupadmin/DependancyInjector/Injector.dart';
import 'package:teamupadmin/Model/AddAdminModel.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/WebService/Repos/Repos.dart';

class AddAdminPresenter{
  AddAdminContract _view;
  Repos _repos;

  AddAdminPresenter(this._view){
    _repos = new Injector().repos;
  }
  void addAdmin(AddAdminRequestModel,url){
   _repos
   .addAdmin(AddAdminRequestModel, url)
       .then((value) => _view.showSuccess(value))
       .catchError((onError)=> _view.showError(new FetchException(onError.toString())));
  }
}