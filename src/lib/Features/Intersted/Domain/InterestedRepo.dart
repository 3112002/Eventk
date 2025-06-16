import 'package:dartz/dartz.dart';
import 'package:eventk/Core/errors/errorModel.dart';
import 'package:eventk/Core/errors/failures.dart';
import 'package:eventk/Core/utils/interset_model/interset_model.dart';
import 'package:eventk/Features/Intersted/Data/Models/addInterestMode.dart';
import 'package:eventk/Features/Intersted/Data/models/getInterest_model.dart';

abstract class Interestedrepo {
  Future<Either<Failures, List<EventsModel>>> getInterests();
  Future<Either<Failures, ErrorModel>> addInterest(int eventId);
  Future<Either<Failures, ErrorModel>> deleteInterest(int eventId);
  Future<Either<Failures, List<IntersetModel>>> getInt();
  Future<Either<Failures, AddInterestmodel>> addInt({required int eventId});
  Future<Either<Failures, AddInterestmodel>> delInt({required int eventId});
}
