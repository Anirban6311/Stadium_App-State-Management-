import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hero_animation/data/stadiums_data.dart';
import 'package:hero_animation/data/wishlist_items.dart';
import 'package:hero_animation/features/home/models/home_stadium_data_model.dart';
import 'package:meta/meta.dart';

import '../../../data/planned_items.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    //on this event give this state
    ///priority wise events
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeStadiumWishlistButtonClickedEvent>(
        homeStadiumWishlistButtonClickedEvent);
    on<HomeStadiumPlannedButtonClickedEvent>(
        homeStadiumPlannedButtonClickedEvent);
    on<HomeWishlistButtonNavigateEvent>(homeWishlistButtonNavigateEvent);
    on<HomePlannedButtonNavigateEvent>(homePlannedButtonNavigateEvent);
    // add(HomeInitialEvent());
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    //adding some time to fetch the data
    await Future.delayed(Duration(seconds: 3));
    //after sucessfull fetching of the data we can map it to the product data model that we have created
    emit(HomeLoadedSuccessState(
        stadiums: StadiumsData.stadiumItems
            .map((e) => StadiumDataModel(
                name: e['name'],
                location: e['location'],
                capacity: e['capacity'],
                openedYear: e['openedYear'],
                description: e['description'],
                imageUrl: e['imageUrl']))
            .toList()));
    // also give a init state after this to load the data to data model just after opening of the screen
  }

  FutureOr<void> homeStadiumWishlistButtonClickedEvent(
      HomeStadiumWishlistButtonClickedEvent event, Emitter<HomeState> emit) {
    print("Wishlist Stadium Clicked!");

    ///passing data from event to bloc
    wishlistStadiums.add(event.stadiumClicked);
    emit(HomeStadiumWishlistedActionState());
  }

  FutureOr<void> homeStadiumPlannedButtonClickedEvent(
      HomeStadiumPlannedButtonClickedEvent event, Emitter<HomeState> emit) {
    print("Planned Stadium Clicked");

    ///passing data from event to bloc
    plannedStadiums.add(event.stadiumClicked);
    emit(HomeStadiumPlannedActionState());
  }

  FutureOr<void> homeWishlistButtonNavigateEvent(
      HomeWishlistButtonNavigateEvent event, Emitter<HomeState> emit) {
    print("Wishlist Navigate Clicked");
    // Emit the state for navigation
    emit(HomeNavigateToWishlistPageActionState());
  }

  FutureOr<void> homePlannedButtonNavigateEvent(
      HomePlannedButtonNavigateEvent event, Emitter<HomeState> emit) {
    print("Planned Navigate Clicked");
    // Emit the state for navigation
    emit(HomeNavigateToPlannedPageActionState());
  }
}
