import 'package:teamupadmin/Model/UpdateGlobalPasswordModel.dart';
import 'package:teamupadmin/Utils/FetchException.dart';

abstract class UpdateGlobalPasswordContract{
  void showGlobalSuccess(UpdateGlobalPasswordResponseModel success);
  void showGlobalError(FetchException exception);
}

