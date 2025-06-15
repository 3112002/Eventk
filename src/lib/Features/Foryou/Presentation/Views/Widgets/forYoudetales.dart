import 'package:eventk/Core/Services/get_it_services.dart';
import 'package:eventk/Core/widgets/EventWidget.dart';
import 'package:eventk/Core/widgets/customErrorWidgets.dart';
import 'package:eventk/Core/widgets/customLoadingWidgets.dart';
import 'package:eventk/Features/Event/Presentaion/Views/EventPage.dart';
import 'package:eventk/Features/Foryou/Data/Model/for_you_model/recommended_event.dart';
import 'package:eventk/Features/Foryou/Presentation/Manager/ForYouCubit/for_you_cubit.dart';
import 'package:eventk/Features/Foryou/Presentation/Manager/ForYouCubit/for_you_state.dart';
import 'package:eventk/Features/Foryou/Presentation/Views/Widgets/forYouEventCard.dart';
import 'package:eventk/Features/Foryou/Presentation/Views/Widgets/seeForYouEvents.dart';
import 'package:eventk/Features/Foryou/Presentation/Views/forYouPage.dart';
import 'package:eventk/Features/Foryou/domain/forYouRepo.dart';
import 'package:eventk/Features/Home/Data/model/get_events_model/item.dart';
import 'package:eventk/Features/Home/Presentation/Manager/get_events_cubit.dart';
import 'package:eventk/Features/Home/Presentation/Manager/get_events_state.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/exitException.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/seeMoreEventsDetalies.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/seeMoreEventsDetaliesListViewLoadingIndicator.dart';
import 'package:eventk/Features/Home/domain/home_repo.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/Widgets/getIntersetListViewLoadingIndicator.dart';
import 'package:flutter/material.dart';

/*Yara❤️*/
import 'package:eventk/Core/widgets/CustomAppBar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<RecommendedEvent> forYouEvents = [];

class ForYouPageDetalies extends StatelessWidget {
  static String id = 'ForYouPage';
  const ForYouPageDetalies({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForYouCubit(getIt<ForYouRepo>())..GetForYouEvents(),
      child: BlocConsumer<ForYouCubit, GetForYouState>(
        listener: (context, state) {
          if (state is SuccessGetForYouState) {
            final newItems = state.forYouModel.recommendedEvents!
                .where((newItem) => !forYouEvents
                    .any((existing) => existing.eventId == newItem.eventId))
                .toList();
            forYouEvents.addAll(newItems!);
          }
        },
        builder: (context, state) {
          if (state is SuccessGetForYouState) {
            return ListView.builder(
                // physics: NeverScrollableScrollPhysics(),
                // shrinkWrap: true,

                itemCount: forYouEvents.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EventDetailsPage(
                              eventId: forYouEvents[index].eventId!,
                            ),
                          ),
                        );
                      },
                      child: ForYouEventCard(event: forYouEvents[index]));
                });
          } else if (state is FailureGetForYouState) {
            return Error404Screen();
          } else {
            return Getintersetlistviewloadingindicator();
          }
        },
      ),
    );
  }
}
