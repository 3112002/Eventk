class FollowStates {}

class FollowInitialState extends FollowStates {}

class FollowLoadingState extends FollowStates {
  final int orgId;
  FollowLoadingState(this.orgId);
}

class FollowSuccessState extends FollowStates {
  final String message;
  FollowSuccessState(this.message);
}

class UnFollowSuccessState extends FollowStates {
  final String message;
  UnFollowSuccessState(this.message);
}

class FollowFailureState extends FollowStates {
  final String error;
  FollowFailureState(this.error);
}
