import 'dart:convert';

import 'package:collection/collection.dart';

class IntersetModel {
  int? eventId;
  String? eventName;
  DateTime? startDate;
  String? eventPicture;
  bool? isInterested;
  dynamic longitude;
  dynamic latitude;

  IntersetModel({
    this.eventId,
    this.eventName,
    this.startDate,
    this.eventPicture,
    this.isInterested,
    this.longitude,
    this.latitude,
  });

  factory IntersetModel.fromMap(Map<String, dynamic> data) => IntersetModel(
        eventId: data['eventId'] as int?,
        eventName: data['eventName'] as String?,
        startDate: data['startDate'] == null
            ? null
            : DateTime.parse(data['startDate'] as String),
        eventPicture: data['eventPicture'] as String?,
        isInterested: data['isInterested'] as bool?,
        longitude: data['longitude'] as dynamic,
        latitude: data['latitude'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'eventId': eventId,
        'eventName': eventName,
        'startDate': startDate?.toIso8601String(),
        'eventPicture': eventPicture,
        'isInterested': isInterested,
        'longitude': longitude,
        'latitude': latitude,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [IntersetModel].
  factory IntersetModel.fromJson(String data) {
    return IntersetModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [IntersetModel] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! IntersetModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
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
