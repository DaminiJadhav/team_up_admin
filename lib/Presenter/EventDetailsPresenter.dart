import 'package:teamupadmin/Contract/EventDetailsContract.dart';
import 'package:teamupadmin/DependancyInjector/Injector.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/WebService/Repos/Repos.dart';

class EventDetailsPresenter {
  EventDetailsContract _view;
  Repos _repos;

  EventDetailsPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void getEventDetails(url) {
    _repos
        .getEventDetail(url)
        .then((value) => _view.showDetailsSuccess(value))
        .catchError((onError) =>
            _view.showDetailsError(new FetchException(onError.toString())));
  }
}
