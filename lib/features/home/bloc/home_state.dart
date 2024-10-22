part of 'home_bloc.dart';

@immutable
sealed class HomeState {}


//actioned states and build states


abstract class HomeActionedState extends HomeState{

}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState{
}

class HomeLoadedSuccessState extends HomeState{
    final List<StadiumDataModel> products;

    HomeLoadedSuccessState({required this.products});

}

class HomeErrorState extends HomeState{

}

class HomeNavigateToWishlistPageActionState extends HomeActionedState{

}

class HomeNavigateToPlannedPageActionState extends HomeActionedState{

}


