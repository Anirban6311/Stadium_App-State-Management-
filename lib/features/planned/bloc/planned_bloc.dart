import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hero_animation/data/planned_items.dart';
import 'package:hero_animation/features/home/models/home_stadium_data_model.dart';
import 'package:meta/meta.dart';

part 'planned_event.dart';
part 'planned_state.dart';

class PlannedBloc extends Bloc<PlannedEvent, PlannedState> {
  PlannedBloc() : super(PlannedInitial()) {
    on<PlannedInitialEvent>(plannedInitialEvent);
    on<PlannedRemoveFromPlanned>(plannedRemoveFromPlanned);
  }

  FutureOr<void> plannedInitialEvent(
      PlannedInitialEvent event, Emitter<PlannedState> emit) {
    emit(PlannedSuccessState(plannedStadiums: plannedStadiums));
  }

  FutureOr<void> plannedRemoveFromPlanned(
      PlannedRemoveFromPlanned event, Emitter<PlannedState> emit) {
    plannedStadiums.remove(event.stadiumDataModel);
    emit(PlannedSuccessState(plannedStadiums: plannedStadiums));
  }
}
