import 'package:eventk/Core/utils/deleteInterest_service.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/manager/cubits/deleteInterest_cubit/deleteInterest_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteinterestCubit extends Cubit<DeleteInterestStates> {
  final DeleteinterestService service;
  DeleteinterestCubit({required this.service})
      : super(DeleteInterestInitialState());
  Future<void> deleteInterest(int eventId) async {
    emit(DeleteInterestLoadingState());
    try {
      final result = await service.deleteInterest(eventId: eventId);
      emit(DeleteInterestSuccessState(result));
    } catch (e) {
      DeleteInterestErrorState(e.toString());
    }
  }
}
