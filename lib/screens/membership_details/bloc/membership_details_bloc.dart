import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wtf_web/db/api_response.dart';
import 'package:wtf_web/db/repository.dart';
import 'package:wtf_web/model/get_order_id.dart';
import 'package:wtf_web/model/post_order_id.dart';
part 'membership_details_event.dart';
part 'membership_details_state.dart';

class MembershipDetailsBloc
    extends Bloc<MembershipDetailsEvent, MembershipDetailsState> {
  final _repository = Repository();
  MembershipDetailsBloc() : super(MembershipDetailsInitial()) {
    on<MembershipDetailsEvent>((event, emit) {
      if (event is PostMembershipDetailsEvent) {
        emit(MembershipDetailsInitial());
        _repository
            .getOrderId(postOrderIdModel: event.postOrderIdModel)
            .then((value) => _convertData(apiResponse: value));
      }
      // if (event is FetchMembershipDetailsEvent) {
      //   _repository
      //       .getOrderId(data: event.orderIdModel)
      //       .then((value) => _convertData(apiResponse: value));
      // }

      if (event is FetchMembershipDetailsEvent) {
        emit(FetchMembershipDetailsState(orderIdModel: event.orderIdModel));
      }
    });
  }
  _convertData({required ApiResponse apiResponse}) {
    print('Got the Data============>');

    GetOrderIdModel _getOrderIdModel =
        GetOrderIdModel.fromJson(apiResponse.finalData['data']);
    add(FetchMembershipDetailsEvent(orderIdModel: _getOrderIdModel));
  }
}
