import 'package:eventk/Features/Organization/Domain/OrganizationRepo.dart';
import 'package:eventk/Features/Organization/Presenation/manager/Cubits/organizerToFollow_cubit/organizerToFollow_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrganizertofollowCubit extends Cubit<OrganizationsToFollowState> {
  final Organizationrepo repo;
  OrganizertofollowCubit(this.repo)
      : super(OrganizationsToFollowInitialState());
  Future<void> fetchOrganizationsToFollow({required bool isFollowing}) async {
    emit(OrganizationsToFollowLoadingState());
    final result = await repo.getOrganizations(isFollowing: isFollowing);
    result.fold(
      (failure) =>
          emit(OrganizationsToFollowFailureState(failure.errorMessage)),
      (organizations) => emit(OrganizationsToFollowSuccessState(organizations)),
    );
  }
}
