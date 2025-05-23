class OrganizationModel {
  final int organizationId;
  final String name;
  final String? logo;
  final int followersCount;
  bool? isFollowed;

  OrganizationModel({
    required this.organizationId,
    required this.name,
    this.logo,
    required this.followersCount,
    this.isFollowed,
  });

  factory OrganizationModel.fromJson(Map<String, dynamic> json) {
    return OrganizationModel(
      organizationId: json['organizationId'] as int,
      name: json['name'] as String,
      logo: json['logo'] as String?,
      followersCount: json['followersCount'] as int,
      isFollowed: json['isFollowed'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
        'organizationId': organizationId,
        'name': name,
        'logo': logo,
        'followersCount': followersCount,
        'isFollowed': isFollowed,
      };
}
