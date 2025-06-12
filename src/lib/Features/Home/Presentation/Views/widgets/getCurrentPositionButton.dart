import 'package:eventk/Core/utils/User%E2%80%99sLatitudeaLongitude.dart';
import 'package:eventk/Features/Home/Data/model/locationModel.dart';
import 'package:flutter/material.dart';

/*Yara❤️*/
class GetCurrentPositionButton extends StatelessWidget {
  GetCurrentPositionButton({super.key, this.updatedLocation});
  final Function(double lat, double long)? updatedLocation;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        LocationModel? locationModel =
            await Userislatitudealongitude().GetLocation();
        // onLocationFetched(locationModel!.latitude, locationModel!.longitude);
      },
      child: const Text("Get Current Location"),
    );
  }
}
