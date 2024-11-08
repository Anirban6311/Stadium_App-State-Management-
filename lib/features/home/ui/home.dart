import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_animation/features/home/bloc/home_bloc.dart';
import 'package:hero_animation/features/home/ui/stadium_tile_widget.dart';
import 'package:hero_animation/features/notes/ui/notes_page.dart';
import 'package:hero_animation/features/planned/ui/planned_page.dart';
import 'package:hero_animation/features/stadium_view/ui/stadium_view.dart';
import 'package:hero_animation/features/wishlist/ui/wishlist_page.dart';
import 'package:lottie/lottie.dart';

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
        } else if (state is HomeNavigateToTaskPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NotesPage()));
        } else if (state is HomeStadiumWishlistedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Stadium wishlisted!"),
            ),
          );
        } else if (state is HomeStadiumPlannedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Stadium planned!"),
            ),
          );
        } else if (state is HomeStadiumImageClickedActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StadiumViewPage(
                stadiumDataModel: state.stadiumDataModel,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        ///just after loading of the home screen the app can be in any of the three states
        //therefore using case
        switch (state.runtimeType) {
          case HomeLoadingState:
            //if it is loading then we will show a loader
            return Scaffold(
              backgroundColor: Colors.indigo,
              body: Center(
                child: Center(
                  child: Container(
                      child: Lottie.asset(
                          'assets/animations/stadium_animation.json')),
                ),
              ),
            );

          case HomeLoadedSuccessState:
            final successstate = state as HomeLoadedSuccessState;
            return Scaffold(
              backgroundColor: Colors.indigo,
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
                        Icons.calendar_month,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeTasksButtonNavigateEvent());

                        ///task is actually notes--> dont confuse
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
                        homeBloc: homeBloc,
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
