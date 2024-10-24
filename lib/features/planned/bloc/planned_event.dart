part of 'planned_bloc.dart';

@immutable
sealed class PlannedEvent {}

class PlannedInitialEvent extends PlannedEvent {}

class PlannedRemoveFromPlanned extends PlannedEvent {}
