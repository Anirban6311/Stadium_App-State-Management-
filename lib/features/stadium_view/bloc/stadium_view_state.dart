part of 'stadium_view_bloc.dart';

@immutable
sealed class StadiumViewState {}

class StadiumViewActionState extends StadiumViewState {}

final class StadiumViewInitial extends StadiumViewState {}

class StadiumClickedSuccessState extends StadiumViewState {}
