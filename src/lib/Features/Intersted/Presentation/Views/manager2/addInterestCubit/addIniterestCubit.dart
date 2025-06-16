import 'package:eventk/Features/Intersted/Domain/InterestedRepo.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/manager2/addInterestCubit/addInterestState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddInitCubit extends Cubit<AddInterestState> {
  AddInitCubit(this.interestedrepo) : super(InitialAddInterestState());
  Interestedrepo interestedrepo;
  Future<void> AddInt({required int eventId}) async {
    emit(LoadingAddInterestState());
    var result = await interestedrepo.addInt(eventId: eventId);
    result.fold(
        (Failures) => emit(FailureAddInterestState(Failures.errorMessage)),
        (Success) {
      emit(SuccessAddInterestState(Success));
    });
  }
}
