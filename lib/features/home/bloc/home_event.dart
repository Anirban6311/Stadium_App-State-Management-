part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {

}

 class HomeInitialEvent extends HomeEvent{

 }
class HomeStadiumWishlistButtonClickedEvent extends HomeEvent{

}

class HomeStadiumPlannedButtonClickedEvent extends HomeEvent{

}

class HomeWishlistButtonNavigateEvent extends HomeEvent{

}

class HomePlannedButtonNavigateEvent extends HomeEvent{

}
