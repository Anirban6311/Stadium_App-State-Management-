part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeStadiumImageClickedEvent extends HomeEvent {
  final StadiumDataModel stadiumClicked;
  HomeStadiumImageClickedEvent({
    required this.stadiumClicked,
  });
}

class HomeStadiumWishlistButtonClickedEvent extends HomeEvent {
  ///passing data through events
  final StadiumDataModel stadiumClicked;
  HomeStadiumWishlistButtonClickedEvent({
    required this.stadiumClicked,
  });
}

class HomeStadiumPlannedButtonClickedEvent extends HomeEvent {
  ///passing data through events
  final StadiumDataModel stadiumClicked;
  HomeStadiumPlannedButtonClickedEvent({
    required this.stadiumClicked,
  });
}

class HomeWishlistButtonNavigateEvent extends HomeEvent {}

class HomePlannedButtonNavigateEvent extends HomeEvent {}

class HomeTasksButtonNavigateEvent extends HomeEvent {}
