import 'package:dartz/dartz.dart';
import 'package:eventk/Core/errors/errorModel.dart';
import 'package:eventk/Core/errors/failures.dart';
import 'package:eventk/Features/Intersted/Data/models/getInterest_model.dart';

abstract class Interestedrepo {
  Future<Either<Failures,List<EventsModel>>>getInterests();
  Future<Either<Failures,ErrorModel>>addInterest(int eventId);
  Future<Either<Failures,ErrorModel>>deleteInterest(int eventId);
  
}


