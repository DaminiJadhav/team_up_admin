import 'package:teamupadmin/Model/AddProblemStatementModel.dart';
import 'package:teamupadmin/Utils/FetchException.dart';

abstract class AddProblemStatementContract {
  void showSuccess(AddProblemStatementResponseModel responseModel);

  void showError(FetchException exception);
}
