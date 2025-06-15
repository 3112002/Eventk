import 'package:dartz/dartz.dart';
import 'package:eventk/Core/errors/failures.dart';
import 'package:eventk/Features/Foryou/Data/Model/for_you_model/for_you_model.dart';

abstract class ForYouRepo {
  Future<Either<Failures, ForYouModel>> getForYouEvents();
}
