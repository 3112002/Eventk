import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:eventk/Core/errors/errorModel.dart';
import 'package:eventk/Core/errors/exceptions.dart';
import 'package:eventk/Core/errors/failures.dart';
import 'package:eventk/Core/utils/Follow_service.dart';
import 'package:eventk/Core/utils/OrganizationToFollow_service.dart';
import 'package:eventk/Core/utils/UnFollow_service.dart';
import 'package:eventk/Core/utils/getOrganizationById_service.dart';
import 'package:eventk/Features/Organization/Data/models/OrganizationToFollowModel.dart';
import 'package:eventk/Features/Organization/Data/models/getOrganizationId_model.dart';
import 'package:eventk/Features/Organization/Domain/OrganizationRepo.dart';
import 'package:eventk/helper/api.dart';

class OrganizationrepoImpl implements Organizationrepo {
  @override
  Future<Either<Failures, GetorganizationByIdModel>> getOrganizationById(
      {required int organizationId,
      int pageNumber = 1,
      int pageSize = 20}) async {
    try {
      var getOrgById = await GetorganizationbyidService(api: Api(dio: Dio()))
          .fetchOrganizationById(
              organizationId: organizationId,
              pageNumber: pageNumber,
              pageSize: pageSize);
      return right(getOrgById);
    } on CustomExceptions catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<Organizationtofollowmodel>>> getOrganizations(
      {required bool isFollowing}) async {
    try {
      var organizations =
          await OrganizationtofollowService(api: Api(dio: Dio()))
              .getOrganizations(isFollowing);
      return right(organizations);
    } on CustomExceptions catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, ErrorModel>> followOrganization(
      int organizationId) async {
    try {
      var result = await Followservice(api: Api(dio: Dio()))
          .followOrganization(organizationId: organizationId);
      return right(result);
    } on CustomExceptions catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, ErrorModel>> unfollowOrganization(
      int organizationId) async {
    try {
      var result = await UnfollowService(api: Api(dio: Dio()))
          .unfollowOrganization(organizationId: organizationId);
      return right(result);
    } on CustomExceptions catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
