class Getorganizationeventsmodel {
  final int eventId;
  final String eventName;
  final String startDate;
  final String eventPic;
  final double? longitude;
  final double? latitude;
  Getorganizationeventsmodel({
    required this.eventId,
    required this.eventName,
    required this.startDate,
    required this.eventPic,
    required this.longitude,
    required this.latitude,
  });
  factory Getorganizationeventsmodel.fromJson(Map<String, dynamic> json) {
    return Getorganizationeventsmodel(
      eventId: json['eventId'],
      eventName: json['eventName'],
      startDate: json['startDate'],
      eventPic: json['eventPicture'],
      latitude: json['latitude'] != null
          ? (json['latitude'] as num).toDouble()
          : null,
      longitude: json['longitude'] != null
          ? (json['longitude'] as num).toDouble()
          : null,
    );
  }
}
