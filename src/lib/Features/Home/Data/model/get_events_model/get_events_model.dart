import 'item.dart';

/*YARA❤️*/
class GetEventsModel {
  List<Item> items;
  int? pageNumber;
  int? totalPages;

  bool? hasPreviousPage;
  bool? hasNextPage;
  int? pageSize;

  GetEventsModel({
    required this.items,
    this.pageNumber,
    this.totalPages,
    this.hasPreviousPage,
    this.hasNextPage,
    this.pageSize,
  });

  factory GetEventsModel.fromJson(Map<String, dynamic> json) {
    return GetEventsModel(
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      pageNumber: json['pageNumber'] as int?,
      totalPages: json['totalPages'] as int?,
      hasPreviousPage: json['hasPreviousPage'] as bool?,
      hasNextPage: json['hasNextPage'] as bool?,
      pageSize: json['pageSize'] as int?,
    );
  }

  @override
  String toString() {
    return 'GetEventsModel(items: $items, pageNumber: $pageNumber, totalPages: $totalPages, hasPreviousPage: $hasPreviousPage, hasNextPage: $hasNextPage, pageSize: $pageSize)';
  }
/*
  Map<String, dynamic> toJson() => {
        'items': items?.map((e) => e.toJson()).toList(),
        'pageNumber': pageNumber,
        'totalPages': totalPages,
        'hasPreviousPage': hasPreviousPage,
        'hasNextPage': hasNextPage,
        'pageSize': pageSize,
      };

  GetEventsModel copyWith({
    List<Item>? items,
    int? pageNumber,
    int? totalPages,
    bool? hasPreviousPage,
    bool? hasNextPage,
    int? pageSize,
  }) {
    return GetEventsModel(
      items: items ?? this.items,
      pageNumber: pageNumber ?? this.pageNumber,
      totalPages: totalPages ?? this.totalPages,
      hasPreviousPage: hasPreviousPage ?? this.hasPreviousPage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      pageSize: pageSize ?? this.pageSize,
    );
  }*/
}
