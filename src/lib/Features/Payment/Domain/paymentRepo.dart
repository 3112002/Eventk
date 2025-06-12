import 'package:dartz/dartz.dart';
import 'package:eventk/Core/errors/failures.dart';
import 'package:eventk/Features/Payment/Data/models/TicketTypeModel.dart';

abstract class Paymentrepo {
  Future<Either<Failures, List<Tickettypemodel>>> fetchTicketTypes(int eventId);
}
