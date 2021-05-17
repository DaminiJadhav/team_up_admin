import 'dart:convert';
import 'package:teamupadmin/Model/ActivateAccountModel.dart';
import 'package:teamupadmin/Model/AddAdminModel.dart';
import 'package:teamupadmin/Model/AddProblemStatementModel.dart';
import 'package:teamupadmin/Model/AllRequestedEventsListModel.dart';
import 'package:teamupadmin/Model/ApproveEventModel.dart';
import 'package:teamupadmin/Model/ApproveHackathonModel.dart';
import 'package:teamupadmin/Model/ApproveProjectModel.dart';
import 'package:teamupadmin/Model/ApprovedEventResponseModel.dart';
import 'package:teamupadmin/Model/ApprovedHackathonListModel.dart';
import 'package:teamupadmin/Model/CompletedProjectDetailsModel.dart';
import 'package:teamupadmin/Model/CompletedProjectListModel.dart';
import 'package:teamupadmin/Model/DeletedAccountDetailsModel.dart';
import 'package:teamupadmin/Model/DeletedAccountsListModel.dart';
import 'package:teamupadmin/Model/EventDetailsModel.dart';
import 'package:teamupadmin/Model/GetAllAdminListModel.dart';
import 'package:teamupadmin/Model/GetSubmittedProjectDetailsModel.dart';
import 'package:teamupadmin/Model/GetSubmittedProjectListModel.dart';
import 'package:teamupadmin/Model/LoginModel.dart';
import 'package:teamupadmin/Model/OrganizationRegisterListModel.dart';
import 'package:teamupadmin/Model/RejectEventModel.dart';
import 'package:teamupadmin/Model/RejectProjectModel.dart';
import 'package:teamupadmin/Model/RequestedHackathonDetailsModel.dart';
import 'package:teamupadmin/Model/UnApprovedAllHackathonListModel.dart';
import 'package:teamupadmin/Model/UpdateAccountPasswordModel.dart';
import 'package:teamupadmin/Model/UpdateGlobalPasswordModel.dart';
import 'package:teamupadmin/Model/UpdateUserInfoModel.dart';
import 'package:teamupadmin/Model/VeifryOrganizationRejectModel.dart';
import 'package:teamupadmin/Model/VerifiedOrganizationDetailsModel.dart';
import 'package:teamupadmin/Model/VerifiedOrganizationListModel.dart';
import 'package:teamupadmin/Model/VerifyOraginzationModel.dart';
import 'package:teamupadmin/Model/VerifyOrganizationDetailsModel.dart';
import 'package:teamupadmin/WebService/Repos/Repos.dart';
import 'package:http/http.dart' as http;

class APICall implements Repos {
  String baseUrl = "https://teamup.sdaemon.com/api/";

  @override
  Future<LoginResponseModel> login(LoginRequestModel, url) {
    LoginResponseModel loginResponseModel = new LoginResponseModel();
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .post(newUrl, body: LoginRequestModel.toJson(), headers: header)
        .then((http.Response response) {
      final String JsonBody = response.body;
      final StatusCode = response.statusCode;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To Login.');
      }
      return loginResponseModel = loginResponseModelFromJson(response.body);
    });
  }

  @override
  Future<AddAdminResponseModel> addAdmin(AddAdminRequestModel, url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .post(newUrl, body: AddAdminRequestModel.toJson(), headers: header)
        .then((http.Response response) {
      final String JsonBody = response.body;
      final StatusCode = response.statusCode;
      final newResponse = json.decode(response.body);
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Faild To Submit Data..');
      }
      return AddAdminResponseModel(
          Status: newResponse['Status'], Message: newResponse['Message']);
    });
  }

  @override
  Future<UpdateAccountPasswordResponseModel> updateAccountPassword(
      UpdateAccountPasswordRequestModel, url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .put(newUrl,
            body: UpdateAccountPasswordRequestModel.toJson(), headers: header)
        .then((http.Response response) {
      final String JsonBody = response.body;
      final StatusCode = response.statusCode;
      final newResponse = json.decode(response.body);

      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Faild To Submit Data..');
      }
      return UpdateAccountPasswordResponseModel(
          Status: newResponse['Status'], Message: newResponse['Message']);
    });
  }

  @override
  Future<UpdateGlobalPasswordResponseModel> updateGlobalPassword(
      UpdateGlobalPasswordRequestModel, url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .put(newUrl,
            body: UpdateGlobalPasswordRequestModel.toJson(), headers: header)
        .then((http.Response response) {
      final String JsonBody = response.body;
      final StatusCode = response.statusCode;
      final newResponse = json.decode(response.body);
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Faild To Submit Data..');
      }
      return UpdateGlobalPasswordResponseModel(
          Status: newResponse['Status'], Message: newResponse['Message']);
    });
  }

  @override
  Future<UpdateUserInfoResponseModel> updateUserInfo(
      UpdateUserInfoRequestModel, url) {
    UpdateUserInfoResponseModel updateUserInfoResponseModel =
        new UpdateUserInfoResponseModel();
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .put(newUrl, body: UpdateUserInfoRequestModel.toJson(), headers: header)
        .then((http.Response response) {
      final String JsonBody = response.body;
      final StatusCode = response.statusCode;
      final newResponse = json.decode(response.body);
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Faild To Submit Data..');
      }
      return updateUserInfoResponseModel =
          updateUserInfoResponseModelFromJson(response.body.toString());
    });
  }

  @override
  Future<VerifyOrganizationResponseModel> organizationContractApprove(
      VerifyOrganizationRequestModel, url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .put(newUrl,
            body: VerifyOrganizationRequestModel.toJson(), headers: header)
        .then((http.Response response) {
      final String JsonBody = response.body;
      final StatusCode = response.statusCode;
      final newResponse = json.decode(response.body);
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Faild To Submit Data..');
      }
      return VerifyOrganizationResponseModel(
          Status: newResponse['Status'], Message: newResponse['Message']);
    });
  }

  @override
  Future<VerifyOrganizationRejectResponseModel> organizationContractReject(
      VerifyOrganizationRejectRequestModel, url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .put(newUrl,
            body: VerifyOrganizationRejectRequestModel.toJson(),
            headers: header)
        .then((http.Response response) {
      final String JsonBody = response.body;
      final StatusCode = response.statusCode;
      final newResponse = json.decode(response.body);
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Faild To Submit Data..');
      }
      return VerifyOrganizationRejectResponseModel(
          Status: newResponse['Status'], Message: newResponse['Message']);
    });
  }

  @override
  Future<GetAllAdminResponseModel> getAllAdmin(url) {
    GetAllAdminResponseModel getAllAdminResponseModel =
        new GetAllAdminResponseModel();
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http.get(newUrl, headers: header).then((http.Response response) {
      final String JsonBody = response.body;
      final StatusCode = response.statusCode;
      final newResponse = json.decode(response.body);
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Faild To Submit Data..');
      }
      return getAllAdminResponseModel =
          getAllAdminResponseModelFromJson(response.body.toString());
    });
  }

  @override
  Future<OrganizationRegisterListModel> getRegisterOrgList(url) {
    OrganizationRegisterListModel organizationRegisterListModel =
        new OrganizationRegisterListModel();
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http.get(newUrl, headers: header).then((http.Response response) {
      final String JsonBody = response.body;
      final StatusCode = response.statusCode;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To Submit Data..');
      }
      return organizationRegisterListModel =
          organizationRegisterListModelFromJson(response.body.toString());
    });
  }

  @override
  Future<VerifiedOrganizationListModel> getVerifiedOrgList(url) {
    VerifiedOrganizationListModel verifiedOrganizationListModel =
        new VerifiedOrganizationListModel();
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http.get(newUrl, headers: header).then((http.Response response) {
      final String JsonBody = response.body;
      final StatusCode = response.statusCode;
      final newResponse = json.decode(response.body);
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Faild To Submit Data..');
      }
      return verifiedOrganizationListModel =
          verifiedOrganizationListModelFromJson(response.body.toString());
    });
  }

  @override
  Future<VerifyOrganizationDetailsModel> getVerifyOrgDetails(url) {
    VerifyOrganizationDetailsModel verifyOrganizationDetailsModel =
        new VerifyOrganizationDetailsModel();
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http.get(newUrl, headers: header).then((http.Response response) {
      final String JsonBody = response.body;
      final StatusCode = response.statusCode;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To Load Data..');
      }
      return verifyOrganizationDetailsModel =
          verifyOrganizationDetailsModelFromJson(response.body.toString());
    });
  }

  @override
  Future<VerifiedOrganizationDetailsModel> getVerifiedOrgDetails(url) {
    VerifiedOrganizationDetailsModel verifiedOrganizationDetailsModel =
        new VerifiedOrganizationDetailsModel();
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http.get(newUrl, headers: header).then((http.Response response) {
      final String JsonBody = response.body;
      final StatusCode = response.statusCode;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Faild To Submit Data..');
      }
      return verifiedOrganizationDetailsModel =
          verifiedOrganizationDetailsModelFromJson(response.body.toString());
    });
  }

  @override
  Future<AllRequestedEventsListModel> getAllRequestedEventsList(url) {
    AllRequestedEventsListModel allRequestedEventsListModel =
        new AllRequestedEventsListModel();
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http.get(newUrl, headers: header).then((http.Response response) {
      final String JsonBody = response.body;
      final StatusCode = response.statusCode;

      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Faild To Submit Data..');
      }
      return allRequestedEventsListModel =
          allRequestedEventsListModelFromJson(response.body.toString());
    });
  }

  @override
  Future<EventDetailsModel> getEventDetail(url) {
    EventDetailsModel eventDetailsModel = new EventDetailsModel();
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http.get(newUrl, headers: header).then((http.Response response) {
      final String JsonBody = response.body;
      final StatusCode = response.statusCode;

      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Faild To Submit Data..');
      }
      return eventDetailsModel =
          eventDetailsModelFromJson(response.body.toString());
    });
  }

  @override
  Future<ApproveEventResponseModel> approveEvent(
      ApproveEventRequestModel, url) {
    ApproveEventResponseModel approveEventResponseModel =
        new ApproveEventResponseModel();
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .put(newUrl, body: ApproveEventRequestModel.toJson(), headers: header)
        .then((http.Response response) {
      final String JsonBody = response.body;
      final StatusCode = response.statusCode;
      final newResponse = json.decode(response.body);
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Faild To Submit Data..');
      }
      return approveEventResponseModel =
          approveEventResponseModelFromJson(response.body.toString());
    });
  }

  @override
  Future<RejectEventResponseModel> rejectEvent(RejectEventRequestModel, url) {
    RejectEventResponseModel responseModel = new RejectEventResponseModel();
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .put(newUrl, body: RejectEventRequestModel.toJson(), headers: header)
        .then((http.Response response) {
      final String JsonBody = response.body;
      final StatusCode = response.statusCode;
      final newResponse = json.decode(response.body);
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Faild To Submit Data..');
      }
      return responseModel =
          rejectEventResponseModelFromJson(response.body.toString());
    });
  }

  @override
  Future<UnApprovedAllHackathonListModel> getRequestedHackathonList(url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http.get(newUrl, headers: header).then((http.Response response) {
      final String JsonBody = response.body;
      final StatusCode = response.statusCode;

      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Faild To Submit Data..');
      }
      return unApprovedAllHackathonListModelFromJson(response.body.toString());
    });
  }

  @override
  Future<RequestedHackathonDetailsModel> getRequestedHackathonDetails(url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http.get(newUrl, headers: header).then((http.Response response) {
      final String JsonBody = response.body;
      final StatusCode = response.statusCode;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Faild To Submit Data..');
      }
      return requestedHackathonDetailsModelFromJson(response.body.toString());
    });
  }

  @override
  Future<AddProblemStatementResponseModel> addProblemStatement(
      AddProblemStatementRequestModel, url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .post(newUrl,
            body: addProblemStatementRequestModelToJson(
                AddProblemStatementRequestModel),
            headers: header)
        .then((http.Response response) {
      final String JsonBody = response.body;
      final StatusCode = response.statusCode;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Faild To Submit Data..');
      }
      return addProblemStatementResponseModelFromJson(response.body.toString());
    });
  }

  @override
  Future<ApproveHackathonResponseModel> approveHackathon(
      ApproveHackathonRequestModel, url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .put(newUrl,
            body: approveHackathonRequestModelToJson(
                ApproveHackathonRequestModel),
            headers: header)
        .then((http.Response response) {
      final String JsonBody = response.body;
      final StatusCode = response.statusCode;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Faild To Submit Data..');
      }
      return approveHackathonResponseModelFromJson(response.body.toString());
    });
  }

  @override
  Future<ApproveHackathonResponseModel> rejectHackathon(
      ApproveHackathonRequestModel, url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .put(newUrl,
            body: approveHackathonRequestModelToJson(
                ApproveHackathonRequestModel),
            headers: header)
        .then((http.Response response) {
      final String JsonBody = response.body;
      final StatusCode = response.statusCode;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Faild To Submit Data..');
      }
      return approveHackathonResponseModelFromJson(response.body.toString());
    });
  }

  @override
  Future<ApprovedHackathonListModel> getApprovedHackathonList(url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http.get(newUrl, headers: header).then((http.Response response) {
      final String JsonBody = response.body;
      final StatusCode = response.statusCode;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Faild To Submit Data..');
      }
      return approvedHackathonListModelFromJson(response.body.toString());
    });
  }

  @override
  Future<DeletedAccountsListModel> getListDeleted(url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http.get(newUrl, headers: header).then((http.Response response) {
      final String JsonBody = response.body;
      final StatusCode = response.statusCode;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Faild To Submit Data..');
      }
      return deletedAccountsListModelFromJson(response.body.toString());
    });
  }

  @override
  Future<DeletedAccountDetailsModel> getDeletedAccountDetails(url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http.get(newUrl, headers: header).then((http.Response response) {
      final String JsonBody = response.body;
      final StatusCode = response.statusCode;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Faild To Submit Data..');
      }
      return deletedAccountDetailsModelFromJson(response.body.toString());
    });
  }

  @override
  Future<ActivateAccountResponseModel> activateAccount(
      ActivateAccountRequestModel, url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .put(newUrl,
            body:
                activateAccountRequestModelToJson(ActivateAccountRequestModel),
            headers: header)
        .then((http.Response response) {
      final String JsonBody = response.body;
      final StatusCode = response.statusCode;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Faild To Submit Data..');
      }
      return activateAccountResponseModelFromJson(response.body.toString());
    });
  }

  @override
  Future<GetSubmittedProjectListModel> getSubmittedProjectList(url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http.get(newUrl, headers: header).then((http.Response response) {
      final String JsonBody = response.body;
      final StatusCode = response.statusCode;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Faild To Submit Data..');
      }
      return getSubmittedProjectListModelFromJson(response.body.toString());
    });
  }

  @override
  Future<GetSubmittedProjectDetailsModel> getSubmittedPDetails(url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http.get(newUrl, headers: header).then((http.Response response) {
      final String JsonBody = response.body;
      final StatusCode = response.statusCode;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Faild To Submit Data..');
      }
      return getSubmittedProjectDetailsModelFromJson(response.body.toString());
    });
  }

  @override
  Future<ApproveRequestedProjectResponsedModel> approveProject(
      ApproveRequestedProjectRequestedModel, url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .put(newUrl,
            body: approveRequestedProjectRequestedModelToJson(
                ApproveRequestedProjectRequestedModel),
            headers: header)
        .then((http.Response response) {
      final String JsonBody = response.body;
      final StatusCode = response.statusCode;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Faild To Submit Data..');
      }
      return approveRequestedProjectResponsedModelFromJson(
          response.body.toString());
    });
  }

  @override
  Future<RejectRequestedProjectResponseModel> rejectProject(
      RejectRequestedProjectRequestdModel, url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .put(newUrl,
            body: rejectRequestedProjectRequestdModelToJson(
                RejectRequestedProjectRequestdModel),
            headers: header)
        .then((http.Response response) {
      final String JsonBody = response.body;
      final StatusCode = response.statusCode;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Faild To Submit Data..');
      }
      return rejectRequestedProjectResponseModelFromJson(
          response.body.toString());
    });
  }

  @override
  Future<CompletedProjectListModel> getCompletedProjectList(url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http.get(newUrl, headers: header).then((http.Response response) {
      final String JsonBody = response.body;
      final StatusCode = response.statusCode;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Faild To Submit Data..');
      }
      return completedProjectListModelFromJson(response.body.toString());
    });
  }

  @override
  Future<CompletedProjectDetailsModel> getCompletedProjectDetails(url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http.get(newUrl, headers: header).then((http.Response response) {
      final String JsonBody = response.body;
      final StatusCode = response.statusCode;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Faild To Submit Data..');
      }
      return completedProjectDetailsModelFromJson(response.body.toString());
    });
  }

  @override
  Future<ApprovedEventResponseModel> getApprovedEvent(url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http.get(newUrl, headers: header).then((http.Response response) {
      final String JsonBody = response.body;
      final StatusCode = response.statusCode;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To Submit Data..');
      }
      return approvedEventResponseModelFromJson(response.body.toString());
    });
  }
}
