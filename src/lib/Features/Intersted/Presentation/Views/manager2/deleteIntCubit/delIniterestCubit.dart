import 'package:eventk/Features/Intersted/Domain/InterestedRepo.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/manager2/addInterestCubit/addInterestState.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/manager2/deleteIntCubit/delInterestState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DelInitCubit extends Cubit<DeleInterestState> {
  DelInitCubit(this.interestedrepo) : super(InitialDelInterestState());
  Interestedrepo interestedrepo;
  Future<void> DelInt({required int eventId}) async {
    emit(LoadingDelInterestState());
    var result = await interestedrepo.delInt(eventId: eventId);
    result.fold(
        (Failures) => emit(FailureDelInterestState(Failures.errorMessage)),
        (Success) {
      emit(SuccessDelInterestState(Success));
    });
  }
}
