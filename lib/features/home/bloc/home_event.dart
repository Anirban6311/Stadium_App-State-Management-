part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

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
