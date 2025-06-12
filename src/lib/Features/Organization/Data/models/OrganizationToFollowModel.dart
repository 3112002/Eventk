class Organizationtofollowmodel {
  final int organizationId;
  final String? name;
  final String? logo;
  final int followersCount;
  final bool? isFollowed;
  Organizationtofollowmodel({
    required this.organizationId,
    this.name,
    this.logo,
    required this.followersCount,
    required this.isFollowed,
  });
  factory Organizationtofollowmodel.fromJson(Map<String, dynamic> json) {
    return Organizationtofollowmodel(
      organizationId: json['organizationId'],
      name: json['name'] as String?,
      logo: json['logo'] as String?,
      followersCount: json['followersCount'],
      isFollowed: json['isFollowed'] as bool?,
    );
  }
}
