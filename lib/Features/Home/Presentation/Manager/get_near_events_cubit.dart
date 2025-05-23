import 'package:eventk/Features/Home/Presentation/Manager/get_events_state.dart';
import 'package:eventk/Features/Home/domain/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// /*Yara Adel Mohamed*/
// class GetNearEventsCubit extends Cubit<GetEventsState> {
//   GetNearEventsCubit(this.homeRepo) : super(InitialGetEventsState());
//   HomeRepo homeRepo;
//   Future<void> GetNearEvents(String endPoint, int pageNumber) async {
//     final result =
//         await homeRepo.requestForGetEventsNearYou(endPoint, pageNumber);
//     result.fold(
//         (Failures) => emit(FailureGetEventsState(Failures.errorMessage)),
//         (EventsModel) => emit(SuccessGetEventsState(EventsModel)));
//   }
// }
