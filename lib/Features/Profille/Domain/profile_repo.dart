import 'package:dartz/dartz.dart';
import 'package:eventk/Core/errors/errorModel.dart';
import 'package:eventk/Core/errors/failures.dart';
import 'package:eventk/Features/Profille/Data/models/change_password.dart';
import 'package:eventk/Features/Profille/Data/models/deleteProfile_model.dart';
import 'package:eventk/Features/Profille/Data/models/editProfile_model.dart';
import 'package:eventk/Features/Profille/Data/models/profile_model.dart';

abstract class ProfileRepo {
  Future<Either<Failures,ProfileModel>>fetchProfile();
  Future<Either<Failures,EditprofileModel>>editProfile({
    required String firstName,
    required String lastName,
    required String userName,
    String? bio,
    required String birthDate,
    String? ProfilePicPath,
  });
  Future<Either<Failures,ChangepasswordModel>>changePassword({
    required String oldPass,
    required String newPass,
    required String confirmPass,
  }
  );
  Future<Either<Failures,DeleteprofileModel>>deleteProfile({
    required String oldPass
  });
  Future<Either<Failures,ErrorModel>>deleteProfilePicture();
  //Future<Either<Failures,List<OrganizationsModel>>>fetchOrganizations(bool ? isFollowing);
  //Future<Either<Failures,ErrorModel>>followOrganization(int organizationId);
  //Future<Either<Failures,ErrorModel>>unfollowOrganization(int organizationId);

}
