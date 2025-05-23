class Organizationlinks {
  final String linkUrl;
  final String linkName;
  Organizationlinks({required this.linkUrl, required this.linkName});
  factory Organizationlinks.fromJson(Map<String, dynamic> json) {
    return Organizationlinks(
        linkUrl: json['linkUrl'], linkName: json['linkName']);
  }
}
