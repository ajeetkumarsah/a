part of 'membership_details_bloc.dart';

abstract class MembershipDetailsState extends Equatable {
  const MembershipDetailsState();

  @override
  List<Object> get props => [];
}

class MembershipDetailsInitial extends MembershipDetailsState {}

// class PostMembershipDetailsState extends MembershipDetailsState {
//   final PostOrderIdModel postOrderIdModel;

//   PostMembershipDetailsState({required this.postOrderIdModel});
//   @override
//   // TODO: implement props
//   List<Object> get props => [this.postOrderIdModel];
// }

class FetchMembershipDetailsState extends MembershipDetailsState {
  final GetOrderIdModel orderIdModel;

  FetchMembershipDetailsState({required this.orderIdModel});
  @override
  // TODO: implement props
  List<Object> get props => [this.orderIdModel];
}
