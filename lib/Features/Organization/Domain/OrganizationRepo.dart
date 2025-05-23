import 'package:dartz/dartz.dart';
import 'package:eventk/Core/errors/errorModel.dart';
import 'package:eventk/Core/errors/failures.dart';
import 'package:eventk/Features/Organization/Data/models/OrganizationToFollowModel.dart';
import 'package:eventk/Features/Organization/Data/models/getOrganizationId_model.dart';

abstract class Organizationrepo {
  Future<Either<Failures, GetorganizationByIdModel>> getOrganizationById({
    required int organizationId,
    int pageNumber,
    int pageSize,
  });
  Future<Either<Failures, List<Organizationtofollowmodel>>> getOrganizations({required bool isFollowing});
   Future<Either<Failures,ErrorModel>>followOrganization(int organizationId);
  Future<Either<Failures,ErrorModel>>unfollowOrganization(int organizationId);

}
