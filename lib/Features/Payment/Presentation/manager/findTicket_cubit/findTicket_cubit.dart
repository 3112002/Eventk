import 'package:eventk/Core/utils/ticketTypes_service.dart';
import 'package:eventk/Features/Payment/Presentation/manager/findTicket_cubit/findTicket_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FindticketCubit extends Cubit<FindticketStates> {
  final TickettypesService service;
  FindticketCubit({required this.service}) : super(FindTicketInitialState());
  Future<void> getTicketsTypes(int eventId) async {
    emit(FindTicketLoadingState());
    try {
      final tickets = await service.fetchTicketTypes(eventId);
      emit(FindTicketLoadedState(tickets));
    } catch (e) {
      emit(FindTicketErrorState(e.toString()));
    }
  }
}
