import 'package:collection/collection.dart';

class RecommendedEvent {
  int? eventId;
  String? eventName;
  DateTime? startDate;
  String? eventPicture;
  bool? isInterested;
  double? longitude;
  double? latitude;

  RecommendedEvent({
    this.eventId,
    this.eventName,
    this.startDate,
    this.eventPicture,
    this.isInterested,
    this.longitude,
    this.latitude,
  });

  factory RecommendedEvent.fromJson(Map<String, dynamic> json) {
    return RecommendedEvent(
      eventId: json['eventId'] as int?,
      eventName: json['eventName'] as String?,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      eventPicture: json['eventPicture'] as String?,
      isInterested: json['isInterested'] as bool?,
      longitude: (json['longitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'eventId': eventId,
        'eventName': eventName,
        'startDate': startDate?.toIso8601String(),
        'eventPicture': eventPicture,
        'isInterested': isInterested,
        'longitude': longitude,
        'latitude': latitude,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! RecommendedEvent) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      eventId.hashCode ^
      eventName.hashCode ^
      startDate.hashCode ^
      eventPicture.hashCode ^
      isInterested.hashCode ^
      longitude.hashCode ^
      latitude.hashCode;
}
