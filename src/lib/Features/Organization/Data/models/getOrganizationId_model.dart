import 'package:eventk/Features/Organization/Data/models/getOrganizationEventsModel.dart';
import 'package:eventk/Features/Organization/Data/models/organizationLinks.dart';

class GetorganizationByIdModel {
  final int organizationId;
  final String? name;
  final String? desc;
  final String? logo;
  final bool isFollowed;
  final int followersCount;
  final List<Getorganizationeventsmodel> events;
  final int pageNumber;
  final int totalPages;
  final bool hasPreviousPage;
  final bool hasNextPage;
  final List<Organizationlinks> links;
  GetorganizationByIdModel({
    required this.organizationId,
    this.name,
    this.desc,
    this.logo,
    required this.isFollowed,
    required this.followersCount,
    required this.events,
    required this.pageNumber,
    required this.totalPages,
    required this.hasPreviousPage,
    required this.hasNextPage,
    required this.links,
  });
  factory GetorganizationByIdModel.fromJson(Map<String, dynamic> json) {
    var items = json['events']['items'] as List;
    List<Getorganizationeventsmodel> eventList =
        items.map((e) => Getorganizationeventsmodel.fromJson(e)).toList();
    var linksList = (json['links'] as List)
        .map((e) => Organizationlinks.fromJson(e))
        .toList();

    return GetorganizationByIdModel(
        organizationId: json['organizationId'],
        name: json['name'],
        desc: json['description'],
        logo: json['logo'],
        isFollowed: json['isFollowed'],
        followersCount: json['followersCount'],
        events: eventList,
        pageNumber: json['events']['pageNumber'],
        totalPages: json['events']['totalPages'],
        hasPreviousPage: json['events']['hasPreviousPage'],
        hasNextPage: json['events']['hasNextPage'],
        links: linksList);
  }
}
