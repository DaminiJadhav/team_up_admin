import 'package:teamupadmin/Model/AllRequestedEventsListModel.dart';
import 'package:teamupadmin/Utils/FetchException.dart';

abstract class AllRequestedEventListContract{
  void showSuccess(AllRequestedEventsListModel success);
  void showError(FetchException exception);
}