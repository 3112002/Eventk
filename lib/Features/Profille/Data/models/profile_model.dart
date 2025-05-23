class ProfileModel {
  final String userName;
  final String firstName;
  final String lastName;
  final String? birthDate;
  final String? bio;
  final String? profilePic;
  ProfileModel(
      {required this.userName,
      required this.firstName,
      required this.lastName,
      this.birthDate,
      this.bio,
      this.profilePic});
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
        userName: json['userName'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        birthDate: json['birthDate'],
        bio: json['bio'],
        profilePic: json['profilePicture']);
  }
  Map<String, dynamic> toJson() => {
        'userName': userName,
        'firstName': firstName,
        'lastName': lastName,
        'birthDate': birthDate,
        'bio': bio,
        'profilePicture': profilePic
      };
}
