import 'package:eventk/Features/Home/Presentation/Manager/organization_state.dart';
import 'package:eventk/Features/Home/domain/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*Yara Adel Mohamed*/
class OrganizationCubit extends Cubit<OrganizationState> {
  OrganizationCubit(this.homeRepo) : super(InitialOrganizationState());
  HomeRepo homeRepo;
  Future<void> Organization({required bool isFollowing}) async {
    emit(LoadingOrganizationState());
    final result = await homeRepo.requestForOrganization(isFollowing);
    result.fold(
        (Failures) => emit(FailureOrganizationState(Failures.errorMessage)),
        (organizationList) => emit(SuccessOrganizationState(organizationList)));
  }
}
