import 'package:teamupadmin/Contract/AllRequestedEventListContract.dart';
import 'package:teamupadmin/DependancyInjector/Injector.dart';
import 'package:teamupadmin/Utils/FetchException.dart';
import 'package:teamupadmin/WebService/Repos/Repos.dart';

class AllRequestedEventListPresenter {
  AllRequestedEventListContract _view;
  Repos _repos;

  AllRequestedEventListPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void getAllRequestedEvents(url) {
    _repos
        .getAllRequestedEventsList(url)
        .then((value) => _view.showSuccess(value))
        .catchError((onError) =>
            _view.showError(new FetchException(onError.toString())));
  }
}
