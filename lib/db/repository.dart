import 'package:wtf_web/db/api_response.dart';
import 'package:wtf_web/db/db_provider.dart';
import 'package:wtf_web/model/add_membership.dart';
import 'package:wtf_web/model/post_order_id.dart';
import 'package:wtf_web/model/signup.dart';

class Repository {
  final _dbProvider = DBProvider();

  Future<ApiResponse> getGymList({required String userId}) async =>
      _dbProvider.getGymList();

  Future<ApiResponse> getGymDetails({required String uid}) async =>
      _dbProvider.getGymDetails(id: uid);
  Future<ApiResponse> sendOTP({required String mobile}) async =>
      _dbProvider.sendOTP(mobile: mobile);
  Future<ApiResponse> postLogin(
          {required String firstData, required String authenticator}) async =>
      _dbProvider.logIn(firstData: firstData, authenticator: authenticator);
  Future<ApiResponse> postNewMember(
          {required AddMembershipModel memberShip}) async =>
      _dbProvider.addMembership(membershipModel: memberShip);

  Future<ApiResponse> postSignup({required SignupModel userDetails}) async =>
      _dbProvider.signUp(userDetails);
  Future<ApiResponse> getMembershipPlan({required String id}) async =>
      _dbProvider.getMembershipPlan(id: id);
  Future<ApiResponse> getOffers({required String id}) async =>
      _dbProvider.getOffers(id: id);
  Future<ApiResponse> getOrderId(
          {required PostOrderIdModel postOrderIdModel}) async =>
      _dbProvider.getOrderId(postOrderIdModel: postOrderIdModel);
  Future<ApiResponse> getUserInfo() async => _dbProvider.getUserInfo();
  Future<ApiResponse> postType1Type2({required String type}) async =>
      _dbProvider.getType1Type2(type: type);

  Future<ApiResponse> updateNewMember(
          {required AddMembershipModel memberShip}) async =>
      _dbProvider.updateMembership(membershipModel: memberShip);

  Future<ApiResponse> getSubscriptionList({required String userId}) async =>
      _dbProvider.getSubscriptionList();
}
