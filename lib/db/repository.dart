import 'package:wtf_web/db/api_response.dart';
import 'package:wtf_web/db/db_provider.dart';
import 'package:wtf_web/model/gym_details.dart';
import 'package:wtf_web/model/login.dart';
import 'package:wtf_web/screens/gym_details/gym_details.dart';

class Repository {
  final _dbProvider = DBProvider();

  Future<ApiResponse> getGymList({required String userId}) async =>
      _dbProvider.getGymList();

  Future<ApiResponse> getGymDetails({required String uid}) async =>
      _dbProvider.getGymDetails(id: uid);
  Future<ApiResponse> postLogin({required LoginModel userDetails}) async =>
      _dbProvider.logIn(userDetails);
  Future<ApiResponse> getMembershipPlan({required String id}) async =>
      _dbProvider.getMembershipPlan(id: id);
  Future<ApiResponse> getOffers({required String id}) async =>
      _dbProvider.getOffers(id: id);
}
