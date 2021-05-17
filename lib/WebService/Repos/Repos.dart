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

abstract class Repos {
  Future<LoginResponseModel> login(LoginRequestModel, url);

  Future<AddAdminResponseModel> addAdmin(AddAdminRequestModel, url);

  Future<UpdateAccountPasswordResponseModel> updateAccountPassword(
      UpdateAccountPasswordRequestModel, url);

  Future<UpdateGlobalPasswordResponseModel> updateGlobalPassword(
      UpdateGlobalPasswordRequestModel, url);

  Future<UpdateUserInfoResponseModel> updateUserInfo(
      UpdateUserInfoRequestModel, url);

  Future<GetAllAdminResponseModel> getAllAdmin(url);

  Future<OrganizationRegisterListModel> getRegisterOrgList(url);

  Future<VerifyOrganizationResponseModel> organizationContractApprove(
      VerifyOrganizationRequestModel, url);

  Future<VerifyOrganizationRejectResponseModel> organizationContractReject(
      VerifyOrganizationRejectRequestModel, url);

  Future<VerifiedOrganizationListModel> getVerifiedOrgList(url);

  Future<VerifyOrganizationDetailsModel> getVerifyOrgDetails(url);

  Future<VerifiedOrganizationDetailsModel> getVerifiedOrgDetails(url);

  Future<AllRequestedEventsListModel> getAllRequestedEventsList(url);

  Future<EventDetailsModel> getEventDetail(url);

  Future<ApproveEventResponseModel> approveEvent(ApproveEventRequestModel, url);

  Future<RejectEventResponseModel> rejectEvent(RejectEventRequestModel, url);

  Future<UnApprovedAllHackathonListModel> getRequestedHackathonList(url);

  Future<RequestedHackathonDetailsModel> getRequestedHackathonDetails(url);

  Future<ApproveHackathonResponseModel> approveHackathon(
      ApproveHackathonRequestModel, url);

  Future<ApproveHackathonResponseModel> rejectHackathon(
      ApproveHackathonRequestModel, url);

  Future<AddProblemStatementResponseModel> addProblemStatement(
      AddProblemStatementRequestModel, rul);

  Future<ApprovedHackathonListModel> getApprovedHackathonList(url);

  Future<DeletedAccountsListModel> getListDeleted(url);

  Future<DeletedAccountDetailsModel> getDeletedAccountDetails(url);

  Future<ActivateAccountResponseModel> activateAccount(
      ActivateAccountRequestModel, url);

  Future<GetSubmittedProjectListModel> getSubmittedProjectList(url);

  Future<GetSubmittedProjectDetailsModel> getSubmittedPDetails(url);

  Future<ApproveRequestedProjectResponsedModel> approveProject(
      ApproveRequestedProjectRequestedModel, url);

  Future<RejectRequestedProjectResponseModel> rejectProject(
      RejectRequestedProjectRequestdModel, url);

  Future<CompletedProjectListModel> getCompletedProjectList(url);

  Future<CompletedProjectDetailsModel> getCompletedProjectDetails(url);

  Future<ApprovedEventResponseModel> getApprovedEvent(url);



}
