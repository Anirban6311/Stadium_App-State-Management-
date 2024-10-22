import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'planned_event.dart';
part 'planned_state.dart';

class PlannedBloc extends Bloc<PlannedEvent, PlannedState> {
  PlannedBloc() : super(PlannedInitial()) {
    on<PlannedEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
