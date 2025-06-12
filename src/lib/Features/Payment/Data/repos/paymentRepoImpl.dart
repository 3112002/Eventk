import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:eventk/Core/errors/exceptions.dart';
import 'package:eventk/Core/errors/failures.dart';
import 'package:eventk/Core/utils/ticketTypes_service.dart';
import 'package:eventk/Features/Payment/Data/models/TicketTypeModel.dart';
import 'package:eventk/Features/Payment/Domain/paymentRepo.dart';
import 'package:eventk/helper/api.dart';

class Paymentrepoimpl implements Paymentrepo {
  @override
  Future<Either<Failures, List<Tickettypemodel>>> fetchTicketTypes(
      int eventId) async {
    try {
      var tickets = await TickettypesService(api: Api(dio: Dio()))
          .fetchTicketTypes(eventId);
      return right(tickets);
    } on CustomExceptions catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
