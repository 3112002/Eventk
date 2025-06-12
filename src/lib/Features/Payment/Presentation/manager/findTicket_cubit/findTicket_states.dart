import 'package:eventk/Features/Payment/Data/models/TicketTypeModel.dart';

class FindticketStates {}

class FindTicketInitialState extends FindticketStates {}

class FindTicketLoadingState extends FindticketStates {}

class FindTicketLoadedState extends FindticketStates {
  final List<Tickettypemodel> tickets;
  FindTicketLoadedState(this.tickets);
}

class FindTicketErrorState extends FindticketStates {
  final String error;
  FindTicketErrorState(this.error);
}
