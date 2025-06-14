import 'package:eventk/Core/utils/interset_model/interset_model.dart';

abstract class Getintstate {}

class InitGetIntState extends Getintstate {}

class SuccessGetIntState extends Getintstate {
  List<IntersetModel> getList;
  SuccessGetIntState(this.getList);
}

class LoadingGetIntState extends Getintstate {}

class FailureGetIntState extends InitGetIntState {
  String errMessage;
  FailureGetIntState(this.errMessage);
}
