import 'package:eventk/Core/utils/getOrganizationById_service.dart';
import 'package:eventk/Features/Organization/Presenation/manager/Cubits/getOrganizationId_cubit/getOraganizationId_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetorganizationidCubit extends Cubit<GetoraganizationidStates> {
  final GetorganizationbyidService service;
  GetorganizationidCubit({required this.service})
      : super(GetoraganizationidInitialState());
  Future<void> fetchOrganizationById({
    required int organizationId,
    int pageNumber = 1,
    int pageSize = 20,
  }) async {
    emit(GetoraganizationidLoadingState());
    try {
      final res = await service.fetchOrganizationById(
        organizationId: organizationId,
        pageNumber: pageNumber,
        pageSize: pageSize,
      );
      emit(GetoraganizationidSuccessState(res));
    } catch (e) {
      emit(GetoraganizationidFailureState(e.toString()));
    }
  }
}
