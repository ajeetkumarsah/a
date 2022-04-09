import 'package:wtf_web/model/gym_details.dart';
import 'package:wtf_web/model/membership_plan.dart';

class MemberShipDetailsArgument {
  final GymDetailsModel gymDetails;
  final MembershipPlan membershipPlan;

  MemberShipDetailsArgument(
      {required this.gymDetails, required this.membershipPlan});
}
