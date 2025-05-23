import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:eventk/Core/errors/errorModel.dart';
import 'package:eventk/Core/errors/exceptions.dart';
import 'package:eventk/Core/errors/failures.dart';
import 'package:eventk/Core/utils/Follow_service.dart';
import 'package:eventk/Core/utils/Profile_Service.dart';
import 'package:eventk/Core/utils/UnFollow_service.dart';
import 'package:eventk/Core/utils/change_password_service.dart';
import 'package:eventk/Core/utils/deleteProfilePic_service.dart';
import 'package:eventk/Core/utils/delete_profile_service.dart';
import 'package:eventk/Core/utils/editProfile_service.dart';
import 'package:eventk/Features/Profille/Data/models/change_password.dart';
import 'package:eventk/Features/Profille/Data/models/deleteProfile_model.dart';
import 'package:eventk/Features/Profille/Data/models/editProfile_model.dart';
import 'package:eventk/Features/Profille/Data/models/profile_model.dart';
import 'package:eventk/Features/Profille/Domain/profile_repo.dart';
import 'package:eventk/helper/api.dart';

class ProfilerepoImpl implements ProfileRepo {
  @override
  Future<Either<Failures, ChangepasswordModel>> changePassword(
      {required String oldPass,
      required String newPass,
      required String confirmPass}) async {
    try {
      var changePass = await ChangepasswordService(api: Api(dio: Dio()))
          .changePass(oldPass, newPass, confirmPass);
      return right(changePass!);
    } on CustomExceptions catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, DeleteprofileModel>> deleteProfile(
      {required String oldPass}) async {
    try {
      var deleteProf = await DeleteProfileService(api: Api(dio: Dio()))
          .deleteProfile(oldPass);
      return right(deleteProf!);
    } on CustomExceptions catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, ProfileModel>> fetchProfile() async {
    try {
      var myProfile = await ProfileService(api: Api(dio: Dio())).fetchProfile();
      return right(myProfile);
    } on CustomExceptions catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, EditprofileModel>> editProfile({
    String? ProfilePicPath,
    String? bio,
    required String birthDate,
    required String firstName,
    required String lastName,
    required String userName,
  }) async {
    try {
      final response =
          await EditprofileService(api: Api(dio: Dio())).editProfile(
        firstName: firstName,
        lastName: lastName,
        userName: userName,
        bio: bio,
        birthDate: birthDate,
        profilePicPath: ProfilePicPath, // Pass with correct case
      );

      if (response.status != "Success") {
        return Left(ServerFailure(response.message));
      }

      return Right(response);
    } on CustomExceptions catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to update profile'));
    }
  }

  @override
  Future<Either<Failures, ErrorModel>> deleteProfilePicture() async {
    try {
      var deletePic = await DeleteprofilepicService(api: Api(dio: Dio()))
          .deleteProfilePic();
      return right(deletePic);
    } on CustomExceptions catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
/*
  @override
  Future<Either<Failures, List<OrganizationsModel>>> fetchOrganizations(
      bool? isFollowing) async {
    try {
      var data = await GetorganizationsService(api: Api(dio: Dio()))
          .getOrganizations(isFollowing: isFollowing);
      return right(data);
    } on CustomExceptions catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
  */
  
}
