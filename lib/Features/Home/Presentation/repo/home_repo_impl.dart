import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:eventk/Core/errors/exceptions.dart';
import 'package:eventk/Core/errors/failures.dart';
import 'package:eventk/Core/utils/User%E2%80%99sLatitudeaLongitude.dart';
import 'package:eventk/Core/utils/categories_service.dart';
import 'package:eventk/Core/utils/get_events_service.dart';
import 'package:eventk/Core/utils/get_organization_service.dart';
import 'package:eventk/Features/Home/Data/model/categoriesModel.dart';
import 'package:eventk/Features/Home/Data/model/categoriesModelId.dart';
import 'package:eventk/Features/Home/Data/model/get_events_model/get_events_model.dart';
import 'package:eventk/Features/Home/Data/model/get_events_model/item.dart';
import 'package:eventk/Features/Home/Data/model/locationModel.dart';
import 'package:eventk/Features/Home/Data/model/organizationModel.dart';
import 'package:eventk/Features/Home/domain/home_repo.dart';

/*Yara Adel Mohamed*/
class HomeRepoImpl extends HomeRepo {
  @override
  Future<Either<Failures, LocationModel>> requestForLoaction() async {
    try {
      var result = await Userislatitudealongitude().GetLocation();
      return right(result!);
    } on CustomExceptions catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<CategoriesModel>>> requestForCategories() async {
    try {
      var result = await CategoriesService(Dio()).requestForCategories();
      return right(result!);
    } on CustomExceptions catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, GetEventsModel>> requestForGetEvents(
      String endPoint, int pageNumber) async {
    try {
      var data = await GetEventsService(Dio()).GetEvents(endPoint, pageNumber);

      return right(data);
    } on CustomExceptions catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure((e.toString())));
    }
  }

  @override
  Future<Either<Failures, List<OrganizationModel>>> requestForOrganization(
      bool? isFollowing) async {
    try {
      var result =
          await GetOrganizationService(Dio()).GetOrganizatoin(isFollowing);
      return right(result);
    } on CustomExceptions catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
