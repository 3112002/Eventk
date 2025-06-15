import 'package:collection/collection.dart';

import 'recommended_event.dart';

class ForYouModel {
  List<RecommendedEvent>? recommendedEvents;
  String? recommendationType;

  ForYouModel({this.recommendedEvents, this.recommendationType});

  factory ForYouModel.fromJson(Map<String, dynamic> json) => ForYouModel(
        recommendedEvents: (json['recommendedEvents'] as List<dynamic>?)
            ?.map((e) => RecommendedEvent.fromJson(e as Map<String, dynamic>))
            .toList(),
        recommendationType: json['recommendationType'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'recommendedEvents': recommendedEvents?.map((e) => e.toJson()).toList(),
        'recommendationType': recommendationType,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ForYouModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => recommendedEvents.hashCode ^ recommendationType.hashCode;
}
