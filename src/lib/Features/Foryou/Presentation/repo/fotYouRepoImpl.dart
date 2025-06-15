import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:eventk/Core/errors/exceptions.dart';
import 'package:eventk/Core/errors/failures.dart';
import 'package:eventk/Core/utils/for_you_service.dart';
import 'package:eventk/Features/Foryou/Data/Model/for_you_model/for_you_model.dart';
import 'package:eventk/Features/Foryou/domain/forYouRepo.dart';

class ForYouRepoImpl extends ForYouRepo {
  @override
  Future<Either<Failures, ForYouModel>> getForYouEvents() async {
    try {
      var result = await ForYouService(Dio()).getForYouEventsService();
      return right(result!);
    } on CustomExceptions catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
