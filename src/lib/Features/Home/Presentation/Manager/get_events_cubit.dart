import 'package:eventk/Features/Home/Presentation/Manager/get_events_state.dart';
import 'package:eventk/Features/Home/domain/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*Yara Adel Mohamed*/
class GetEventsCubit extends Cubit<GetEventsState> {
  GetEventsCubit(this.homeRepo) : super(InitialGetEventsState());
  HomeRepo homeRepo;
  Future<void> GetEvents(String endPoint, int pageNumber) async {
    if (pageNumber == 0) {
      emit(LoadingGetEventsState());
    } else {
      emit(PagenationLoadingGetEventsState());
    }
    var result = await homeRepo.requestForGetEvents(endPoint, pageNumber);
    result.fold(
        (Failures) => emit(FailureGetEventsState(Failures.errorMessage)),
        (events) => emit(SuccessGetEventsState(events)));
  }
}
