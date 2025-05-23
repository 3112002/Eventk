import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:eventk/Core/errors/exceptions.dart';
import 'package:eventk/Core/errors/failures.dart';
import 'package:eventk/Core/utils/Event_Service.dart';
import 'package:eventk/Features/Event/Data/model/Event_model.dart';
import 'package:eventk/Features/Event/Domain/EventRepo.dart';
import 'package:eventk/helper/api.dart';

class Eventrepoimpl implements EventRepo {
  @override
  Future<Either<Failures, EventDetailsModel>> fetchEventDetails(
      int eventId) async {
    try {
      var getEvent =
          await EventService(api: Api(dio: Dio())).getEventDetails(eventId);
      return right(getEvent);
    } on CustomExceptions catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
