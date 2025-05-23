import 'package:eventk/Core/Services/get_it_services.dart';
import 'package:eventk/Core/widgets/customErrorWidgets.dart';
import 'package:eventk/Core/widgets/customLoadingWidgets.dart';
import 'package:eventk/Features/Home/Data/model/get_events_model/item.dart';
import 'package:eventk/Features/Home/Presentation/Manager/get_events_cubit.dart';
import 'package:eventk/Features/Home/Presentation/Manager/get_events_state.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/seeMoreEventsDetalies.dart';
import 'package:eventk/Features/Home/domain/home_repo.dart';
import 'package:flutter/material.dart';

/*Yara❤️*/
import 'package:eventk/Core/widgets/CustomAppBar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<Item> items = [];

class ForYouPageDetalies extends StatelessWidget {
  static String id = 'ForYouPage';
  const ForYouPageDetalies({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetEventsCubit(getIt<HomeRepo>())..GetEvents('', 0),
      child: BlocConsumer<GetEventsCubit, GetEventsState>(
        listener: (context, state) {
          if (state is SuccessGetEventsState) {
            items.addAll(state.events.items);
          }
        },
        builder: (context, state) {
          if (state is SuccessGetEventsState ||
              state is PagenationLoadingGetEventsState) {
            return ListView.builder(
                // physics: NeverScrollableScrollPhysics(),
                // shrinkWrap: true,

                itemCount: items.length,
                itemBuilder: (context, index) {
                  return SeeMoreEventsDetalies(item: items[index]);
                });
          } else if (state is FailureGetEventsState) {
            return CustomErrorWidgets(errMessage: state.errMessage);
          } else {
            return CustomLoadingWidgets();
          }
        },
      ),
    );
  }
}
