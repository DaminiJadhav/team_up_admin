import 'package:teamupadmin/WebService/APICall/ApiCall.dart';
import 'package:teamupadmin/WebService/Repos/Repos.dart';

class Injector{

  static final Injector _singleton = new Injector._internal();

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  Repos get repos{
    return new APICall();
  }
}