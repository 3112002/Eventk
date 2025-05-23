import 'package:eventk/Features/Organization/Domain/OrganizationRepo.dart';
import 'package:eventk/Features/Organization/Presenation/manager/Cubits/follow_unfollow_cubit/follow_unfollow_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FollowUnfollowCubit extends Cubit<FollowStates> {
  final Organizationrepo repo;
  FollowUnfollowCubit(this.repo) : super(FollowInitialState());
  Future<void> followOrganization(int orgId) async {
    emit(FollowLoadingState(orgId));
    try {
      var result = await repo.followOrganization(orgId);
      result.fold(
        (failure) => emit(FollowFailureState(failure.errorMessage)),
        (success) => emit(
            FollowSuccessState(success.message ?? 'Followed Successfully')),
      );
    } catch (e) {
      FollowFailureState(e.toString());
    }
  }

  Future<void> unfollowOrganization(int orgId) async {
    emit(FollowLoadingState(orgId));
    try {
      var result = await repo.unfollowOrganization(orgId);
      result.fold(
        (failure) => emit(FollowFailureState(failure.errorMessage)),
        (success) => emit(
            FollowSuccessState(success.message ?? 'Unfollowed Successfully')),
      );
    } catch (e) {
      emit(FollowFailureState(e.toString()));
    }
  }
}
