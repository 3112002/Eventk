class EventDetailsModel {
  final int eventId;
  final String eventName;
  final String description;
  final String eventPicture;
  final String startDate;
  final String endDate;
  bool isInterested;
  final String organizationName;
  final int organizationId;
  final bool? isPaid;
  final double? minPrice;
  final double? maxPrice;
  final double? latitude;
  final double? longitude;
  final int interestedPeople;

  final List<String> categories;

  EventDetailsModel(
      {required this.eventId,
      required this.eventName,
      required this.description,
      required this.eventPicture,
      required this.startDate,
      required this.endDate,
      required this.isInterested,
      required this.organizationName,
      required this.organizationId,
      required this.isPaid,
      required this.minPrice,
      required this.maxPrice,
      required this.latitude,
      required this.longitude,
      required this.interestedPeople,
      required this.categories});
  factory EventDetailsModel.fromJson(Map<String, dynamic> json) {
    return EventDetailsModel(
      eventId: json['eventId'],
      eventName: json['eventName'],
      description: json['about']['description'],
      eventPicture: json['eventPicture'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      isInterested: json['isInterested'],
      organizationName: json['organizationName'],
      organizationId: json['organizationId'],
      isPaid: json['isPaid'],
      minPrice: json['minPrice'] != null
          ? (json['minPrice'] as num).toDouble()
          : null,
      maxPrice: json['maxPrice'] != null
          ? (json['maxPrice'] as num).toDouble()
          : null,
      latitude: json['latitude'] != null
          ? (json['latitude'] as num).toDouble()
          : null,
      longitude: json['longitude'] != null
          ? (json['longitude'] as num).toDouble()
          : null,
      interestedPeople: json['interestedPeople'],
      categories: (json['about']['aboutCategories'] as List)
          .map((cat) => cat['categoryName'].toString())
          .toList(),
    );
  }
}
