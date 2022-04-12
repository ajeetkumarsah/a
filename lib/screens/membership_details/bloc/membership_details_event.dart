part of 'membership_details_bloc.dart';

abstract class MembershipDetailsEvent extends Equatable {
  const MembershipDetailsEvent();

  @override
  List<Object> get props => [];
}

class PostMembershipDetailsEvent extends MembershipDetailsEvent {
  final PostOrderIdModel postOrderIdModel;

  PostMembershipDetailsEvent({required this.postOrderIdModel});
  @override
  List<Object> get props => [this.postOrderIdModel];
}

class FetchMembershipDetailsEvent extends MembershipDetailsEvent {
  final GetOrderIdModel orderIdModel;

  FetchMembershipDetailsEvent({required this.orderIdModel});
  @override
  List<Object> get props => [this.orderIdModel];
}
