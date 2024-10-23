import 'package:flutter/cupertino.dart';
import 'package:hero_animation/features/home/models/home_stadium_data_model.dart';

class StadiumTileWidget extends StatelessWidget {
  final StadiumDataModel stadiumDataModel;
  const StadiumTileWidget({super.key, required this.stadiumDataModel});

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
          Text(
            stadiumDataModel.name,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(stadiumDataModel.location),
          Text("Capacity : ${stadiumDataModel.capacity}"),
          Text(stadiumDataModel.description)
        ],
      ),
    );
  }
}
