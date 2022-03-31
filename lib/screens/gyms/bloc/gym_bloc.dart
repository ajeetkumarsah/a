import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wtf_web/db/api_response.dart';
import 'package:wtf_web/db/repository.dart';
import 'package:wtf_web/model/gym_list_model.dart';
part 'gym_event.dart';
part 'gym_state.dart';

class GymBloc extends Bloc<GymEvent, GymState> {
  final  _repository=Repository();
  GymBloc() : super(GymInitial()) {
    on<GymEvent>((event, emit) {
     
      if(event is FetchGymsEvent){
        emit(GymInitial());
        _repository.getGymList(userId: event.userId).then((value) =>_convertGymList(apiResponse: value) );

      }

      if(event is FetchGymListEvent){
        emit(FetchGymListState(gymList: event.gymList));
      }

    });
  }
  void _convertGymList({required ApiResponse apiResponse}){

    List<dynamic> _gymList= apiResponse.finalData['data'] as List;
    
    List<GymListModel> _list = _gymList.map((e) => GymListModel.fromJson(e)).toList();
    
add(FetchGymListEvent(gymList:_list ));
  }
}
