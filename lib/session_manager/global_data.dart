import 'package:wtf_web/model/member_info.dart';
import 'package:wtf_web/model/user_profile.dart';

class GlobalData {
  UserProfile? userProfile;
  get getUserProfile => this.userProfile;

  set setUserProfile(userProfile) => this.userProfile = userProfile;
  MemberInfo? memberInfo;
  MemberInfo? get getMemberInfo => this.memberInfo;

  set setMemberInfo(MemberInfo? memberInfo) => this.memberInfo = memberInfo;
}

GlobalData globalData = GlobalData();
