import 'package:flutter/material.dart';
import 'package:hero_animation/features/home/models/home_stadium_data_model.dart';

import '../bloc/home_bloc.dart';

class StadiumTileWidget extends StatelessWidget {
  final HomeBloc homeBloc;
  final StadiumDataModel stadiumDataModel;
  const StadiumTileWidget(
      {super.key, required this.stadiumDataModel, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              height: 200,
              width: 500,
              child: Image.network(
                "${stadiumDataModel.imageUrl}",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            stadiumDataModel.name,
            style: TextStyle(
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
                        homeBloc.add(HomeStadiumWishlistButtonClickedEvent(
                            stadiumClicked: stadiumDataModel));
                      },
                      icon: Icon(
                        Icons.favorite_border_outlined,
                        color: Colors.black,
                      )),
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeStadiumPlannedButtonClickedEvent(
                            stadiumClicked: stadiumDataModel));
                      },
                      icon: Icon(
                        Icons.checklist,
                        color: Colors.black,
                      ))
                ],
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
