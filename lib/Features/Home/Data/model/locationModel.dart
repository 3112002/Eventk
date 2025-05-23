class LocationModel {
  final double latitude;
  final double longitude;
  final String address;

  LocationModel({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  @override
  String toString() => 'Lat: $latitude, Lon: $longitude, Addr: $address';
}
