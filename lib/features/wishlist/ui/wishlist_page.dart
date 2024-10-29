import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_animation/data/wishlist_items.dart';
import 'package:hero_animation/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:hero_animation/features/wishlist/ui/wishlist_tile_widget.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  WishlistBloc wishlistBloc = WishlistBloc();
  @override
  void initState() {
    wishlistBloc.add(WishListInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text(
            "Wishlist Page",
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
        ),
        body: BlocConsumer<WishlistBloc, WishlistState>(
          bloc: wishlistBloc,
          listener: (context, state) {},
          listenWhen: (previous, current) => current is WishListedActionState,
          buildWhen: (previous, current) => current is! WishListedActionState,
          builder: (context, state) {
            switch (state.runtimeType) {
              case WishListedSuccessState:
                final successtate = state as WishListedSuccessState;
                return ListView.builder(
                    itemCount: wishlistStadiums.length,
                    itemBuilder: (context, index) {
                      return WishListTileWidget(
                        stadiumDataModel: successtate.wishlistStadiums[index],
                        wishlistBloc: wishlistBloc,
                      );
                    });

              default:
                return Center(
                  child: Text("No wishlisted stadiums"),
                );
            }
          },
        ));
  }
}
