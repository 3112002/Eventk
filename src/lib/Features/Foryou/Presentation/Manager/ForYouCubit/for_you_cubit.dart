import 'package:eventk/Features/Foryou/Presentation/Manager/ForYouCubit/for_you_state.dart';
import 'package:eventk/Features/Foryou/domain/forYouRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForYouCubit extends Cubit<GetForYouState> {
  ForYouCubit(this.forYouRepo) : super(InitialGetForYouEvents());
  ForYouRepo forYouRepo;
  Future<void> GetForYouEvents() async {
    emit(LoadingGetForYouState());
    var result = await forYouRepo.getForYouEvents();
    result.fold(
        (Failures) => emit(FailureGetForYouState(Failures.errorMessage)),
        (result) => emit(SuccessGetForYouState(result)));
  }
}
