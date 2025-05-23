import 'package:eventk/Core/utils/status_permission.dart';
import 'package:geolocator/geolocator.dart';

/*Yara❤️*/
Future<StatusPermission?> HandleLocationPermission() async {
  bool serviceEnabled;
  LocationPermission permission;
  String message = 'Success';
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    message = 'Location services are disabled. Please enable the services';

    StatusPermission statusPermission = StatusPermission.fromJson(message);

    return statusPermission;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      message = 'Location permissions are denied';

      StatusPermission statusPermission = StatusPermission.fromJson(message);

      return statusPermission;
    }
    if (permission == LocationPermission.deniedForever) {
      message =
          'Location permissions are permanently denied, we cannot request permissions.';

      StatusPermission statusPermission = StatusPermission.fromJson(message);

      return statusPermission;
    }
    StatusPermission statusPermission = StatusPermission.fromJson(message);

    return statusPermission;
  }
}
