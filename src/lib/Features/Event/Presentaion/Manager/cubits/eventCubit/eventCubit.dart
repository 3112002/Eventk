import 'package:eventk/Core/utils/Event_Service.dart';
import 'package:eventk/Features/Event/Presentaion/Manager/cubits/eventCubit/event_states';
import 'package:flutter_bloc/flutter_bloc.dart';

class Eventcubit extends Cubit<EventStates> {
  final EventService service;
  Eventcubit({required this.service}) : super(EventInitialState());
  Future<void> fetchEventDetails(int eventId) async {
    emit(EventLoadingState());
    try {
      final event = await service.getEventDetails(eventId);
      emit(EventLoadedState(event));
    } catch (e) {
      emit(EventErrorState(e.toString()));
    }
  }
}
