part of 'planned_bloc.dart';

@immutable
sealed class PlannedState {}

abstract class PlannedActionState extends PlannedState {}

final class PlannedInitial extends PlannedState {}

class PlannedSuccessState extends PlannedState {
  //if the planned state is success then fetch the planned items

  final List<StadiumDataModel> plannedStadiums;
  PlannedSuccessState({
    required this.plannedStadiums,
  });
}
