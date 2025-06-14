import 'package:eventk/Core/utils/get_Interest_service.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/manager/cubits/getInterest_cubit/getInterest_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetinterestCubit extends Cubit<GetinterestStates> {
  final GetInterestService service;
  GetinterestCubit({required this.service}) : super(GetInterestInitialState());
  Future<void> fetchInterests() async {
    emit(GetInterestLoadingState());
    try {
      final interests = await service.getInterest();
      emit(GetInterestLoadedState(interests));
    } catch (e) {
      emit(GetInterestErrorState(e.toString()));
    }
  }
}
