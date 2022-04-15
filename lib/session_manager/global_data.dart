import 'package:wtf_web/model/member_info.dart';
import 'package:wtf_web/model/type1_type2.dart';
import 'package:wtf_web/model/user_profile.dart';

class GlobalData {
  UserProfile? userProfile;
  get getUserProfile => this.userProfile;

  set setUserProfile(userProfile) => this.userProfile = userProfile;
  MemberInfo? memberInfo;
  MemberInfo? get getMemberInfo => this.memberInfo;

  set setMemberInfo(MemberInfo? memberInfo) => this.memberInfo = memberInfo;

  List<Type1Type2Model>? typeList;
  get getTypeList => this.typeList;

  set setTypeList(typeList) => this.typeList = typeList;
}

GlobalData globalData = GlobalData();
