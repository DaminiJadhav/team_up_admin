import 'package:teamupadmin/Model/ActivateAccountModel.dart';
import 'package:teamupadmin/Utils/FetchException.dart';

abstract class ActivateAccountContract {
  void showActivateSuccess(ActivateAccountResponseModel responseModel);

  void showActivateError(FetchException exception);
}
