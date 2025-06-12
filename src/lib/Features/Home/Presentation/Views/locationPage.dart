import 'package:eventk/Core/utils/get_current_position_service.dart';
import 'package:eventk/Core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

/*Yara Adel Mohamed*/
Position? currentPosition;
String? currentAddress;

class Locationpage extends StatefulWidget {
  Locationpage({super.key});
  @override
  State<Locationpage> createState() => _LocationpageState();
}

class _LocationpageState extends State<Locationpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Location Page")),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'LAT: ${currentPosition?.latitude ?? ""}',
                style: Styles.styleText15,
              ),
              Text(
                'LNG: ',
                style: Styles.styleText15,
              ),
              Text(
                'ADDRESS: ',
                style: Styles.styleText15,
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () async {
                  Position position =
                      await GetCurrentPositionService().determinePosition();
                  //30.1300829, 31.3249049
                  List<Placemark> placemarks =
                      await placemarkFromCoordinates(29.9792, 31.1342);
                  Placemark place = placemarks[0];
                  setState(() {
                    currentAddress =
                        '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
                    print("CurrenAdress: $currentAddress");
                  });
                },
                child: const Text("Get Current Location"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
