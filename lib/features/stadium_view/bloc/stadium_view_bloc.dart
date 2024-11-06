import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'stadium_view_event.dart';
part 'stadium_view_state.dart';

class StadiumViewBloc extends Bloc<StadiumViewEvent, StadiumViewState> {
  StadiumViewBloc() : super(StadiumViewInitial()) {
    on<StadiumViewEvent>((event, emit) {
      emit(StadiumClickedSuccessState());
    });
  }
}
