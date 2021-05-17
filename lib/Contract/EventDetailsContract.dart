import 'package:teamupadmin/Model/EventDetailsModel.dart';
import 'package:teamupadmin/Utils/FetchException.dart';

abstract class EventDetailsContract{
  void showDetailsSuccess(EventDetailsModel detailsModel);
  void showDetailsError(FetchException exception);
}