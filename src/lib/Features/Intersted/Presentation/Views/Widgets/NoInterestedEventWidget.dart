
import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Core/widgets/EventWidget.dart';
import 'package:eventk/Core/widgets/searchTextField.dart';
import 'package:eventk/Features/Event/Presentaion/Views/EventPage.dart';
import 'package:eventk/Features/Home/Presentation/Views/allEventsPage.dart';
import 'package:eventk/Features/Search/Presentation/Views/searchPage.dart';
import 'package:flutter/material.dart';

class Nointerestedeventwidget extends StatefulWidget {
  final List events;
  const Nointerestedeventwidget({super.key, required this.events});

  @override
  State<Nointerestedeventwidget> createState() => _NointerestedeventwidgetState();
}

class _NointerestedeventwidgetState extends State<Nointerestedeventwidget> {
  String? token;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  void _loadToken() async {
    final savedToken = await CacheHelper().getDataString(key: 'token');
    print("Saved Token $token");
    setState(() {
      token = savedToken;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (token == null) {
      return Center(child: CircularProgressIndicator());
    }

    if (token!.isNotEmpty) {
      return ListView.builder(
        itemCount: widget.events.length,
        itemBuilder: (context, index) {
          final event = widget.events[index];

          return GestureDetector(
            onTap: () {
              print("Tapped event");
              print("Tapped eventId: ${event.eventId}");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EventDetailsPage(eventId: event.eventId),
                ),
              );
            },
            child: EventCard(event: event),
          );
        },
      );
    } else {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/Images/interested.png',
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 10),
            const Text(
              "Seems like you have no favourite events here \n why not find one?",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AllEventsPage(endPoint: '')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 228, 89, 135),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 5,
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              child: const Text("Find Your Next Event"),
            )
          ],
        ),
      );
    }
  }
}
