import 'package:dartz/dartz.dart';
import 'package:eventk/Core/errors/failures.dart';
import 'package:eventk/Features/Event/Data/model/Event_model.dart';

abstract class EventRepo {
  Future<Either<Failures,EventDetailsModel>>fetchEventDetails(int eventId);
}