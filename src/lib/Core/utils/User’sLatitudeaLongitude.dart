import 'package:eventk/Core/Services/get_it_services.dart';
import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Core/errors/exceptions.dart';
import 'package:eventk/Core/utils/get_current_position_service.dart';
import 'package:eventk/Core/utils/locationCache.dart';
import 'package:eventk/Features/Home/Data/model/locationModel.dart';
import 'package:geocoding/geocoding.dart';

import 'package:geolocator/geolocator.dart';

/*Yara Adel Mohamed*/
class Userislatitudealongitude {
  Future<LocationModel?> GetLocation() async {
    try {
      Position position = await GetCurrentPositionService().determinePosition();
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      String currentAddress =
          '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.administrativeArea}';
      LocationModel locationModel = LocationModel(
          latitude: position.latitude,
          longitude: position.longitude,
          address: currentAddress);
      getIt<CacheHelper>().saveData(key: 'latitude', value: position.latitude);
      getIt<CacheHelper>()
          .saveData(key: 'longitude', value: position.longitude);

      getIt<CacheHelper>().saveData(key: 'address', value: currentAddress);

      return locationModel;
    } catch (e) {
      print('Error fetching location/address: $e');
      throw CustomExceptions((e.toString()));
    }
  }
}
