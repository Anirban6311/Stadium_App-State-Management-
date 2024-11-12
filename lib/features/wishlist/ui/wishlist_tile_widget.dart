import 'package:flutter/material.dart';
import 'package:hero_animation/features/home/models/home_stadium_data_model.dart';
import 'package:hero_animation/features/wishlist/bloc/wishlist_bloc.dart';

class WishListTileWidget extends StatelessWidget {
  final WishlistBloc wishlistBloc;
  final StadiumDataModel stadiumDataModel;
  const WishListTileWidget(
      {super.key, required this.stadiumDataModel, required this.wishlistBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: SizedBox(
              height: 200,
              width: 500,
              child: Image.network(
                "${stadiumDataModel.imageUrl}",
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            stadiumDataModel.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(stadiumDataModel.location),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Capacity : ${stadiumDataModel.capacity}"),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        wishlistBloc.add(WishlistRemoveFromWishlist(
                            stadiumDataModel: stadiumDataModel));
                      },
                      icon: const Icon(
                        Icons.remove_circle_sharp,
                        color: Colors.red,
                        size: 24,
                      )),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
