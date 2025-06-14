class EventsModel {
  final int eventId;
  final String eventName;
  final String startDate;
  final String eventPicture;
  final bool isInterested;
  final double? longitude;
  final double? latitude;
  EventsModel(
      {required this.eventId,
      required this.eventName,
      required this.startDate,
      required this.eventPicture,
      required this.isInterested,
      this.latitude,
      this.longitude});
  factory EventsModel.fromJson(Map<String, dynamic> json) {
    return EventsModel(
      eventId: json['eventId'],
      eventName: json['eventName'],
      startDate: json['startDate'],
      eventPicture: json['eventPicture'],
      isInterested: json['isInterested'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
