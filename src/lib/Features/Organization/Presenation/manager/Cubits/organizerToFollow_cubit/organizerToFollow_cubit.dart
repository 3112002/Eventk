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

  void updateOrganizationFollowStatus(int orgId, bool isFollowed) {
    if (state is OrganizationsToFollowSuccessState) {
      final currentList =
          (state as OrganizationsToFollowSuccessState).organizations;
      final updatedList = currentList.map((org) {
        if (org.organizationId == orgId) {
          return org.copyWith(isFollowed: isFollowed);
        }
        return org;
      }).toList();

      emit(OrganizationsToFollowSuccessState(updatedList));
    }
  }
}
