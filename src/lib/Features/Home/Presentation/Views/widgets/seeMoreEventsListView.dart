import 'package:eventk/Core/Services/get_it_services.dart';
import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Core/widgets/customErrorWidgets.dart';
import 'package:eventk/Core/widgets/customLoadingWidgets.dart';
import 'package:eventk/Features/Home/Data/model/get_events_model/item.dart';
import 'package:eventk/Features/Home/Presentation/Manager/get_events_cubit.dart';
import 'package:eventk/Features/Home/Presentation/Manager/get_events_state.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/exitException.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/seeMoreEventsDetalies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*Yara Adel Mohamed❤️*/
class SeeMoreEventsListView extends StatefulWidget {
  const SeeMoreEventsListView({super.key, this.endPoint});
  final String? endPoint;
  @override
  State<SeeMoreEventsListView> createState() => _SeeMoreEventsListViewState();
}

class _SeeMoreEventsListViewState extends State<SeeMoreEventsListView> {
  final ScrollController scrollController = ScrollController();

  int currentPage = 0;
  var isLoading = false;
  @override
  void didUpdateWidget(covariant SeeMoreEventsListView old) {
    super.didUpdateWidget(old);

    if (widget.endPoint != old.endPoint) {
      items.clear();
      currentPage = 1;
      scrollController.jumpTo(0);
      isLoading = false;
      _loadFirstPage();
    }
  }

  void _loadFirstPage() {
    if (widget.endPoint == null) return;
    BlocProvider.of<GetEventsCubit>(context)
        .GetEvents(widget.endPoint!, currentPage++);
  }

  @override
  void initState() {
    super.initState();

    if (currentPage == 1) {
      BlocProvider.of<GetEventsCubit>(context)
          .GetEvents(widget.endPoint!, currentPage++);
    }
    scrollController.addListener(onScroll);
  }

  void onScroll() {
    if (scrollController.position.pixels >=
        .7 * scrollController.position.maxScrollExtent) {
      if (!isLoading) {
        isLoading = true;
        BlocProvider.of<GetEventsCubit>(context)
            .GetEvents(widget.endPoint!, currentPage++);
      }
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  List<Item> items = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetEventsCubit, GetEventsState>(
      listener: (context, state) {
        if (state is SuccessGetEventsState) {
          final newItems = state.events.items
              .where((newItem) =>
                  !items.any((item) => item.eventId == newItem.eventId))
              .toList();
          items.addAll(newItems);
          currentPage++;
          isLoading = false;
        } else if (state is FailureGetEventsState) {
          isLoading = false;
        }
      },
      builder: (context, state) {
        if (state is SuccessGetEventsState ||
            state is PagenationLoadingGetEventsState) {
          return ListView.builder(
              // physics: NeverScrollableScrollPhysics(),
              // shrinkWrap: true,
              controller: scrollController,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return SeeMoreEventsDetalies(item: items[index]);
              });
        } else if (state is FailureGetEventsState) {
          return Error404Screen();
        } else {
          return CustomLoadingWidgets();
        }
      },
    );
  }
}
