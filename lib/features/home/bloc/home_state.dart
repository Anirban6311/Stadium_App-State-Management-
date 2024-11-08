part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

//actioned states and build states

abstract class HomeActionedState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  final List<StadiumDataModel> stadiums;

  HomeLoadedSuccessState({required this.stadiums});
}

class HomeErrorState extends HomeState {}

class HomeStadiumImageClickedActionState extends HomeActionedState {
  final StadiumDataModel stadiumDataModel;
  HomeStadiumImageClickedActionState({required this.stadiumDataModel});
}

class HomeNavigateToWishlistPageActionState extends HomeActionedState {}

class HomeNavigateToPlannedPageActionState extends HomeActionedState {}

class HomeNavigateToTaskPageActionState extends HomeActionedState {}

class HomeStadiumWishlistedActionState extends HomeActionedState {}

class HomeStadiumPlannedActionState extends HomeActionedState {}
