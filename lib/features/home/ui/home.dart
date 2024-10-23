import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_animation/features/home/bloc/home_bloc.dart';
import 'package:hero_animation/features/home/ui/stadium_tile_widget.dart';
import 'package:hero_animation/features/planned/ui/planned_page.dart';
import 'package:hero_animation/features/wishlist/ui/wishlist_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  final HomeBloc homeBloc = HomeBloc();
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionedState,
      buildWhen: (previous, current) => current is! HomeActionedState,
      listener: (context, state) {
        if (state is HomeNavigateToPlannedPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PlannedPage()));
        } else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => WishlistPage()));
        }
      },
      builder: (context, state) {
        ///just after loading of the home screen the app can be in any of the three states
        //therefore using case
        switch (state.runtimeType) {
          case HomeLoadingState:
            //if it is loading then we will show a loader
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );

          case HomeLoadedSuccessState:
            final successstate = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "24/7 Stadiums",
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
                backgroundColor: Colors.teal,
                actions: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeWishlistButtonNavigateEvent());
                      },
                      icon: Icon(
                        Icons.favorite_border_outlined,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomePlannedButtonNavigateEvent());
                      },
                      icon: Icon(
                        Icons.checklist,
                        color: Colors.white,
                      ))
                ],
              ),
              body: ListView.builder(
                  itemCount: successstate.stadiums.length,
                  itemBuilder: (context, index) {
                    return StadiumTileWidget(
                        stadiumDataModel: successstate.stadiums[index]);
                  }),
            );

          case HomeErrorState:
            return Scaffold(
              body: Center(
                child: Text("Error"),
              ),
            );
          default:
            return SizedBox();
        }
      },
    );
  }
}
