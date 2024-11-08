import 'package:flutter/material.dart';
import 'package:hero_animation/features/home/models/home_stadium_data_model.dart';
import 'package:hero_animation/features/stadium_view/ui/stadium_view.dart';

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
      decoration: BoxDecoration(
        color: Colors.white24, // Card background color
        borderRadius: BorderRadius.circular(20), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              homeBloc.add(HomeStadiumImageClickedEvent(
                  stadiumClicked: stadiumDataModel));
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      StadiumViewPage(stadiumDataModel: stadiumDataModel),
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
              child: Container(
                height: 200,
                width: double.infinity, // Full width of the container
                child: Image.network(
                  "${stadiumDataModel.imageUrl}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            stadiumDataModel.name,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Text(
            stadiumDataModel.location,
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Capacity: ${stadiumDataModel.capacity}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeStadiumWishlistButtonClickedEvent(
                          stadiumClicked: stadiumDataModel));
                    },
                    icon: Icon(Icons.favorite_border_outlined,
                        color: Colors.redAccent),
                  ),
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeStadiumPlannedButtonClickedEvent(
                          stadiumClicked: stadiumDataModel));
                    },
                    icon: Icon(Icons.calendar_month_outlined,
                        color: Colors.purple),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
