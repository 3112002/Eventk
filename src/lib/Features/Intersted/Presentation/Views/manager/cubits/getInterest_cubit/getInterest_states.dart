import 'package:eventk/Features/Intersted/Data/models/getInterest_model.dart';

class GetinterestStates {}
class GetInterestInitialState extends GetinterestStates{}
class GetInterestLoadingState extends GetinterestStates{}
class GetInterestLoadedState extends GetinterestStates{
  final List<EventsModel>interests;
  GetInterestLoadedState(this.interests);
}
class GetInterestErrorState extends GetinterestStates{
  final String message;
  GetInterestErrorState(this.message);

}