import 'package:eventk/Features/Home/Presentation/Manager/get_location_state.dart';
import 'package:eventk/Features/Home/domain/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetLocationCubit extends Cubit<GetLocationState> {
  GetLocationCubit(this.homeRepo) : super(InitialGetLocationState());
  final HomeRepo homeRepo;
  Future<void> GetLoaction() async {
    emit(LoadingGetLocationState());
    var result = await homeRepo.requestForLoaction();
    result.fold(
        (Failure) => emit(FailureGetLocationState(Failure.errorMessage)),
        (LocationModel) => emit(SuccessGetLocationState(LocationModel)));
  }
}
