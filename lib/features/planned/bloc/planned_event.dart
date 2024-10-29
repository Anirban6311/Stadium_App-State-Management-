part of 'planned_bloc.dart';

@immutable
sealed class PlannedEvent {}

class PlannedInitialEvent extends PlannedEvent {}

class PlannedRemoveFromPlanned extends PlannedEvent {
  //getting the stadium through constructor
  final StadiumDataModel stadiumDataModel;
  PlannedRemoveFromPlanned({required this.stadiumDataModel});
}
