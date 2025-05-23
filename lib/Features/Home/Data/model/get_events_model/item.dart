/*YARA❤️*/
class Item {
  int eventId;
  String eventName;
  DateTime? startDate;
  String eventPicture;
  bool? isInterested;
  dynamic longitude;
  dynamic latitude;

  Item({
    required this.eventId,
    required this.eventName,
    this.startDate,
    required this.eventPicture,
    this.longitude,
    this.latitude,
    this.isInterested
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        eventId: json['eventId'] as int,
        eventName: json['eventName'] as String,
        startDate: json['startDate'] == null
            ? null
            : DateTime.parse(json['startDate'] as String),
        eventPicture: json['eventPicture'] as String,
        longitude: json['longitude'] as dynamic,
        latitude: json['latitude'] as dynamic,
        isInterested: json['isInterested']??false,
      );

  Map<String, dynamic> toJson() => {
        'eventId': eventId,
        'eventName': eventName,
        'startDate': startDate?.toIso8601String(),
        'eventPicture': eventPicture,
        'longitude': longitude,
        'latitude': latitude,
        'isInterested':isInterested
        
      };

  @override
  String toString() {
    return 'Item(eventId: $eventId, eventName: $eventName, startDate: $startDate, eventPicture: $eventPicture, longitude: $longitude, latitude: $latitude)';
  }
/*
  Item copyWith({
    int? eventId,
    String? eventName,
    DateTime? startDate,
    String? eventPicture,
    dynamic longitude,
    dynamic latitude,
  }) {
    return Item(
      eventId: eventId ?? this.eventId,
      eventName: eventName ?? this.eventName,
      startDate: startDate ?? this.startDate,
      eventPicture: eventPicture ?? this.eventPicture,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
    );
  }*/
}
