import 'package:eventk/Features/Intersted/Domain/InterestedRepo.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/manager/cubits/getInterest_cubit/getInterest_states.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/manager2/getIntState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Getintcubit extends Cubit<Getintstate> {
  Getintcubit(this.interestedrepo) : super(InitGetIntState());
  Interestedrepo interestedrepo;

  Future<void> GetList() async {
    emit(LoadingGetIntState());

    var result = await interestedrepo.getInt();
    result.fold((Failures) => emit(FailureGetIntState(Failures.errorMessage)),
        (listInt) => emit(SuccessGetIntState(listInt)));
  }
}
