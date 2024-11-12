import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_animation/features/home/models/home_stadium_data_model.dart';
import 'package:hero_animation/features/stadium_view/ui/stadium_view.dart';

import '../../../data/wishlist_items.dart';
import '../bloc/home_bloc.dart';

class StadiumTileWidget extends StatefulWidget {
  final HomeBloc homeBloc;
  final StadiumDataModel stadiumDataModel;

  const StadiumTileWidget(
      {super.key, required this.stadiumDataModel, required this.homeBloc});

  @override
  State<StadiumTileWidget> createState() => _StadiumTileWidgetState();
}

class _StadiumTileWidgetState extends State<StadiumTileWidget> {
  bool isLiked = false;
  @override
  void initState() {
    super.initState();
    isLiked = wishlistStadiums.contains(widget.stadiumDataModel);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      bloc: widget.homeBloc,
      listener: (context, state) {
        if (state is HomeLoadedSuccessState) {
          final stadiumLiked =
              wishlistStadiums.contains(widget.stadiumDataModel);
          setState(() {
            isLiked = stadiumLiked;
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white24, // Card background color
          borderRadius: BorderRadius.circular(20), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                widget.homeBloc.add(HomeStadiumImageClickedEvent(
                    stadiumClicked: widget.stadiumDataModel));
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        StadiumViewPage(
                            stadiumDataModel: widget.stadiumDataModel),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                  ),
                );
              },
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(15), // Rounded edges for the image
                child: SizedBox(
                  height: 200,
                  width: double.infinity, // Full width of the container
                  child: Image.network(
                    "${widget.stadiumDataModel.imageUrl}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.stadiumDataModel.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Text(
              widget.stadiumDataModel.location,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Capacity: ${widget.stadiumDataModel.capacity}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isLiked = !isLiked;
                        });
                        /////
                        widget.homeBloc.add(
                            HomeStadiumWishlistButtonClickedEvent(
                                stadiumClicked: widget.stadiumDataModel,
                                isLiked: isLiked));
                      },
                      icon: isLiked
                          ? const Icon(Icons.favorite, color: Colors.redAccent)
                          : const Icon(Icons.favorite_border_outlined,
                              color: Colors.redAccent),
                    ),
                    IconButton(
                      onPressed: () {
                        widget.homeBloc.add(
                            HomeStadiumPlannedButtonClickedEvent(
                                stadiumClicked: widget.stadiumDataModel));
                      },
                      icon: const Icon(Icons.calendar_month_outlined,
                          color: Colors.purple),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
